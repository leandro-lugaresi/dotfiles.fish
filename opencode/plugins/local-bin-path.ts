import type { Plugin } from "@opencode-ai/plugin"
import { existsSync } from "node:fs"
import { join } from "node:path"

const FNM_USE_MARKER = "# opencode-fnm-use-if-nvmrc"

const fnmUseIfNvmrc = `${FNM_USE_MARKER}
eval "$(fnm env --shell bash)" || exit $?
fnm use --install-if-missing >/dev/null || exit $?`

// Prepares shell executions for project-local command behavior: rewrite commands
// through rtk, switch Node versions through fnm when .nvmrc exists, and prefer
// local node_modules binaries over global executables.
export const LocalBinPathPlugin: Plugin = async ({ $, directory }) => {
  const hasRtk = await $`which rtk`.quiet().nothrow().then((result) => result.exitCode === 0)
  const hasFnm = await $`which fnm`.quiet().nothrow().then((result) => result.exitCode === 0)
  let hasNvmrc = detectNvmrc(directory)

  return {
    event: async ({ event }) => {
      if (event.type === "session.created") {
        hasNvmrc = detectNvmrc(directory)
      }
    },

    "tool.execute.before": async (input, output) => {
      const tool = String(input?.tool ?? "").toLowerCase()
      if (tool !== "bash" && tool !== "shell") return

      const args = output?.args
      if (!args || typeof args !== "object") return

      const command = (args as Record<string, unknown>).command
      if (typeof command !== "string" || !command || command.includes(FNM_USE_MARKER)) return

      const preparedCommand = hasRtk ? await rewriteWithRtk($, command) : command

      ;(args as Record<string, unknown>).command = hasNvmrc && hasFnm
        ? `${fnmUseIfNvmrc}\n${preparedCommand}`
        : preparedCommand
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

function detectNvmrc(directory: string) {
  return existsSync(join(directory, ".nvmrc"))
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
