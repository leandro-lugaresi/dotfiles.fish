# OpenCode

Personal OpenCode V2 configuration. Oh My OpenCode Slim handles
orchestration across `opencode-go/*` models; specialised agents (oracle,
librarian, designer, fixer) are configured in `oh-my-opencode-slim.json`.

## Setup

- **CLI**: `opencode2` (V2; install via the `beta` distribution)
- **Default model**: `opencode-go/kimi-k2.6`
- **Small model**: `opencode-go/deepseek-v4-flash` (used by the `title` agent)
- **Routing/fallbacks**: `oh-my-opencode-slim.json`
- **Cyberdeck overlay**: `cyberdeck.json` (loaded by the `plugins/cyberdeck` plugin)

## Files

| File | Purpose |
|------|---------|
| `opencode.json` | Server + project config (V2 native shape) |
| `cli.json` | Terminal-client config (theme, attention, diffs) — V2 global format |
| `oh-my-opencode-slim.json` | Slim preset configuration (orchestrator, oracle, librarian, ...) |
| `cyberdeck.json` | Cyberdeck plugin overlay (presets, council, fallbacks) |
| `AGENTS.md` | Global agent behaviour rules |
| `commands/` | Custom commands (plannotator) |
| `plugins/` | Local plugins (`effect-ts`, `local-bin-path`) + symlinked `cyberdeck` |
| `skills/` | Installed agent skills |

## Installation

Prerequisites: `opencode2` CLI installed and authenticated.

```bash
mkdir -p ~/.config/opencode
rsync -a opencode/ ~/.config/opencode/
cd ~/.config/opencode && bun install
```

Verify:

```bash
opencode2 debug config
opencode2 agent list
opencode2 service status
```

## Usage

Just use the default orchestrator — Oh My OpenCode Slim routes each task to
the right specialist automatically.

- Default to the orchestrator for everything
- Override per-task with manual commands only when you need to force a path
