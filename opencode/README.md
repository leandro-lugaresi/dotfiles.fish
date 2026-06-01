# OpenCode

Personal OpenCode configuration using [Oh My OpenAgent](https://github.com/ohmyopencodes/openagent) for orchestration.

## Setup

- **Default agent**: `sisyphus`
- **Provider**: `opencode-go/*`
- **Model**: `opencode-go/kimi-k2.6`
- **Routing/fallbacks**: `oh-my-openagent.json`

## Files

| File | Purpose |
|------|---------|
| `opencode.json` | Main config, models, MCP servers, plugins |
| `AGENTS.md` | Global agent behavior rules |
| `oh-my-openagent.json` | Oh My OpenAgent routing and agent definitions |
| `plugins/` | Custom plugins (`effect-ts`, `local-bin-path`) |
| `skills/` | Installed agent skills |

## Installation

Prerequisites: OpenCode CLI installed and authenticated.

```bash
# Link into ~/.config
mkdir -p ~/.config/opencode
rsync -a opencode/ ~/.config/opencode/
cd ~/.config/opencode && bun install
```

Verify:

```bash
opencode debug config
opencode agent list
```

## Usage

Just use `auto` — Oh My OpenAgent handles routing to the right specialist automatically.

- Default to `auto` for everything
- Use manual commands (e.g. `/code`, `/plan`, `/review`) only when you want to force a specific path
