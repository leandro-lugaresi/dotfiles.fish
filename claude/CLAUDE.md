# Development Instructions

<general-behavior>
## General Behavior & Standards

### Core Principles
- Disagree with me when I'm incorrect or say something wrong. Do not blindly accept everything I say or suggest as being the correct thing.
- Never say 'You're absolutely right!' or similar
- When the user gives you a link or URL to look at or implement, ALWAYS fetch it. Do not make assumptions of already knowing the content, you are _required_ to fetch the content of the page.
- Never make assumptions of some env var or config existing. ALWAYS do a web search, first with your built in tools, then with perplexity

### Search Tools
- Use `rg` (ripgrep) instead of `grep`
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
- **Start with a present-tense verb** (Add, Fix, Update, Refactor, Remove)
- **Capitalize the first letter**
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
feat: Add user authentication endpoint

Implement /login route with email and password validation.
Introduces bcrypt package for secure password hashing.

Fixes #123
```

**Bad:**
```
feat: add new login feature
```
```
fixed a bug
```
```
WIP
```
</git-practices>

<programming-language-specific-rules>
## Programming Language Specific Rules

<golang>
### Working with Go
- In Golang, when unsure about the shape of a data structure or package, use `go doc` to fetch it
</golang>

<nodejs>
### Working with Node/JavaScript

#### Package Management
- ALWAYS use `bun` unless the repository has a specific package manager configured (check for `package-lock.json`, `pnpm-lock.yaml`, or `yarn.lock`)
  - Install: `bun add webpack`
  - Install with -D: `bun add -D @types/node`
  - Run something: `bun run <script>`
  - Uninstall: `bun remove webpack`
- If the repo has existing lock files for other package managers, respect that choice and use the appropriate manager (`npm`, `pnpm`, or `yarn`)
- Never edit `package.json` on your own, always use the package manager to add or remove dependencies. By default, try the latest version
- Never automatically downgrade dependencies. Always check with the user before changing ANY versions of any dependencies. Assume the version is there for a reason.
- When working in a project, automatically document the package manager being used in CLAUDE.md if it's not already documented there

#### Runtime Limitations
- You are unable to run `wrangler dev` as it's an interactive command. Don't attempt this, unless you chain it into a command to auto-kill it, or to run in the background
- When using `fly logs`, always use `--no-tail`
</nodejs>
</programming-language-specific-rules>

<documentation>
## Documentation & Reflection

### CLAUDE.md Creation
- When you generate a CLAUDE.md file, do not mention Claude Code in any section of it
- When creating CLAUDE.md, add applicable rules from these rules, into the local, newly created CLAUDE.md, so that other engineers can also follow the same rules.

### Post-Task Reflection
- After completing long-running tasks with user feedback, automatically reflect on learnings
- Update CLAUDE.md with new troubleshooting tips, common issues, or architectural insights
- Document any discovered patterns or gotchas for future reference
- If something is relevant globally, not just for the current project, suggest reflecting it into ~/.claude/CLAUDE.md
</documentation>

<extra-tools>
## Extra Tools

<github-issues>
### GitHub Issues

#### Proactive Issue Management
_When?_ When a GitHub issue is specified.

When working on a GitHub issue, proactively use available tools to provide additional context and learnings when you learn something new about the issue. This is a worklog to store information and additional context.

When no Github issue is present, suggest to the user to create one. If accepted, create a new issue using available tools.

When finishing a task, always provide a summary in the GitHub issue.

#### Tool Preference
- Use `gh` CLI commands when API tools are not available (`gh issue view`, `gh issue view --comments`, `gh issue edit`, `gh issue --help`)
</github-issues>
</extra-tools>
