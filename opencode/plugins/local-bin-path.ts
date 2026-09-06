import { Plugin } from "@opencode-ai/plugin"
import { execFile } from "node:child_process"
import { constants, existsSync } from "node:fs"
import { access } from "node:fs/promises"
import { delimiter, join } from "node:path"
import { promisify } from "node:util"

const execFileAsync = promisify(execFile)

const FNM_USE_MARKER = "# opencode-fnm-use-if-nvmrc"

const fnmUseIfNvmrc = `${FNM_USE_MARKER}
eval "$(fnm env --shell bash)" || exit $?
fnm use --install-if-missing >/dev/null || exit $?`

// Prepares shell executions for project-local command behavior: rewrite commands
// through rtk, switch Node versions through fnm when .nvmrc exists, and prefer
// local node_modules binaries over global executables.
export default Plugin.define({
  id: "local-bin-path",

  async setup(ctx) {
    const projectDirectory = ctx.location.project.directory
    const hasRtk = await commandExists("rtk")
    const hasFnm = await commandExists("fnm")

    // Stay on the tool hook so the rewrite is scoped to the model's shell tool
    // and does not affect shell work OpenCode does outside of it.
    await ctx.tool.hook("execute.before", async (event) => {
      const tool = event.tool.toLowerCase()
      if (tool !== "bash" && tool !== "shell") return

      if (!event.input || typeof event.input !== "object") return

      const input = event.input as Record<string, unknown>
      const command = input.command

      if (
        typeof command !== "string" ||
        !command ||
        command.includes(FNM_USE_MARKER) ||
        command.includes("-bench")
      ) {
        return
      }

      const preparedCommand = hasRtk ? await rewriteWithRtk(command) : command

      // Lazy detection keeps behaviour correct when .nvmrc is added or
      // removed without a session restart.
      const rewrittenCommand =
        detectNvmrc(projectDirectory) && hasFnm
          ? `${fnmUseIfNvmrc}\n${preparedCommand}`
          : preparedCommand

      event.input = { ...input, command: rewrittenCommand }
    })

    // V2 replacement for the V1 "shell.env" hook. Mutating event.env injects
    // the project's local node_modules/.bin ahead of the global PATH for every
    // shell OpenCode creates.
    await ctx.shell.hook("create.before", (event) => {
      const localBin = join(event.cwd, "node_modules", ".bin")
      const currentPath = event.env.PATH ?? process.env.PATH ?? ""
      const entries = currentPath.split(delimiter)

      if (!entries.includes(localBin)) {
        event.env.PATH = [localBin, ...entries].join(delimiter)
      }
    })
  },
})

function detectNvmrc(projectDirectory: string) {
  return existsSync(join(projectDirectory, ".nvmrc"))
}

async function commandExists(name: string): Promise<boolean> {
  for (const directory of (process.env.PATH ?? "").split(delimiter)) {
    if (!directory) continue

    try {
      await access(join(directory, name), constants.X_OK)
      return true
    } catch {
      // Try the next PATH entry.
    }
  }

  return false
}

async function rewriteWithRtk(command: string): Promise<string> {
  try {
    const result = await execFileAsync("rtk", ["rewrite", command], {
      encoding: "utf8",
    })
    return result.stdout.trim() || command
  } catch {
    return command
  }
}
