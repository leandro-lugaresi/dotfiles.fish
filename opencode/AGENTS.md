
# OpenCode Agents

This setup intentionally uses only Oh My OpenAgent for OpenCode Go.

- Default agent: `sisyphus`
- Provider: `opencode-go/*`
- Routing/fallbacks: `oh-my-openagent.json`

Do not add local provider-specific orchestration here.
Do not recreate custom GO orchestrators/subagents unless Oh My OpenAgent cannot cover a future use case.

<general-behavior>
## General Behavior & Standards

### Core Principles
- Disagree with me when I'm incorrect or say something wrong. Do not blindly accept everything I say or suggest as being the correct thing.
- Never say 'You're absolutely right!' or similar
- When the user gives you a link or URL to look at or implement, ALWAYS fetch it. Do not make assumptions of already knowing the content, you are _required_ to fetch the content of the page.
- Never make assumptions of some env var or config existing. ALWAYS do a web search, first with your built in tools, then with perplexity

### Search Tools
- For any file search or grep in the current git indexed directory use fff tools
</general-behavior>

<git-practices>
## Git & Version Control

### Git Commands
- NEVER add mentions to Claude Code in git commit messages or READMEs. You are to act as the current user, using information from gitconfig
- NEVER use `git add .` or `git add -A`. ALWAYS use `git status` and commit what needs to be committed.
- NEVER use `--no-verify`, if the commit is failing because it requires a password, notify the user and wait for user action.
- Whenever we're done with a task (multi-step, etc), ask me whether we should do a git commit

### Commit Message Format

#### Subject Line
- **Use conventional commit prefixes** (`feat:`, `fix:`, `chore:`, `docs:`, etc.)
- **Start with a present-tense verb** (add, update, refactor, remove)
- **Do not end with a period**
- **Keep under 50 characters**

#### Body (Optional)
- Provide concise, high-information summary of essential details
- Explain the "why" behind the change, not just the "how"
- Keep terse and to the point
- Separate from subject with blank line
- Wrap at 72 characters

#### Footer (Optional)
- Reference GitHub/Linear issues on new line after body
- Use `Fixes #123` if commit resolves the issue
- Use `Refs #456` if commit relates to but doesn't resolve issue

#### Examples

**Good:**
```
feat: add user authentication endpoint

Implement /login route with email and password validation.
Introduces bcrypt package for secure password hashing.

Fixes #123
```

**Bad:**
```
add new login feature
```
```
fixed a bug
```
```
WIP
```
</git-practices>
