import type { Plugin } from "@opencode-ai/plugin"

const FNM_USE_MARKER = "# opencode-fnm-use-if-nvmrc"

const fnmUseIfNvmrc = `${FNM_USE_MARKER}
if [ -f .nvmrc ]; then
  if ! command -v fnm >/dev/null 2>&1; then
    echo "[fnm] .nvmrc found but fnm is not available in PATH" >&2
    exit 127
  fi
  eval "$(fnm env --shell bash)" || exit $?
  fnm use --install-if-missing >/dev/null || exit $?
fi`

// Prepares shell executions for project-local command behavior: rewrite commands
// through rtk, switch Node versions through fnm when .nvmrc exists, and prefer
// local node_modules binaries over global executables.
export const LocalBinPathPlugin: Plugin = async ({ $ }) => {
  const hasRtk = await $`which rtk`.quiet().nothrow().then((result) => result.exitCode === 0)

  return {
    "tool.execute.before": async (input, output) => {
      const tool = String(input?.tool ?? "").toLowerCase()
      if (tool !== "bash" && tool !== "shell") return

      const args = output?.args
      if (!args || typeof args !== "object") return

      const command = (args as Record<string, unknown>).command
      if (typeof command !== "string" || !command || command.includes(FNM_USE_MARKER)) return

      const preparedCommand = hasRtk ? await rewriteWithRtk($, command) : command

      ;(args as Record<string, unknown>).command = `${fnmUseIfNvmrc}\n${preparedCommand}`
    },
    "shell.env": async (input, output) => {
      const localBin = `${input.cwd}/node_modules/.bin`
      const existingPath = output.env.PATH || process.env.PATH || ""

      // Prepend local bin directory so locally-installed tools are preferred
      // over global ones. Avoid duplicating if it's already present.
      if (!existingPath.includes(localBin)) {
        output.env.PATH = `${localBin}:${existingPath}`
      }
    },
  }
}

async function rewriteWithRtk($: Parameters<Plugin>[0]["$"], command: string) {
  try {
    const result = await $`rtk rewrite ${command}`.quiet().nothrow()
    const rewritten = String(result.stdout).trim()
    return rewritten || command
  } catch {
    return command
  }
}
