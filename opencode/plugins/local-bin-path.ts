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

// Ensures local node_modules binaries are available in PATH for all shell
// executions (main agent, subagents, and user terminals). Fixes issues where
// tools like biome are called as global executables instead of the local copy.
export const LocalBinPathPlugin: Plugin = async () => {
  return {
    "tool.execute.before": async (input, output) => {
      const tool = String(input?.tool ?? "").toLowerCase()
      if (tool !== "bash" && tool !== "shell") return

      const args = output?.args
      if (!args || typeof args !== "object") return

      const command = (args as Record<string, unknown>).command
      if (typeof command !== "string" || !command || command.includes(FNM_USE_MARKER)) return

      ;(args as Record<string, unknown>).command = `${fnmUseIfNvmrc}\n${command}`
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
