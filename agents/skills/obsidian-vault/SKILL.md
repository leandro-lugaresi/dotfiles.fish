---
name: obsidian-vault
description: Search, create, and manage notes in the Obsidian vault using the Obsidian CLI. Use when user wants to find, create, or organize notes in Obsidian.
---

# Obsidian Vault

## Prerequisites

- Obsidian 1.12+ with CLI enabled (Settings → General → Command line interface)
- Obsidian must be running for CLI commands to work

## Vault

Target vault with `vault=<name>` as the first parameter. Target files with `file=<name>` (wikilink resolution) or `path=<path>` (exact path from vault root).

Vault name: `AI Research`

## Naming conventions

- **Index notes**: aggregate related topics (e.g., `Ralph Wiggum Index.md`, `Skills Index.md`, `RAG Index.md`)
- **Title case** for all note names
- No folders for organization - use links and index notes instead

## Linking

- Use Obsidian `[[wikilinks]]` syntax: `[[Note Title]]`
- Notes link to dependencies/related notes at the bottom
- Index notes are just lists of `[[wikilinks]]`

## Workflows

### Search for notes

```bash
# Full-text search
obsidian search vault="AI Research" query="keyword"

# Search with context lines
obsidian search vault="AI Research" query="keyword" context=2
```

### Create a new note

```bash
obsidian create vault="AI Research" path="Note Title.md" content="note content here"
```

1. Use **Title Case** for filename
2. Write content as a unit of learning (per vault rules)
3. Add `[[wikilinks]]` to related notes at the bottom
4. If part of a numbered sequence, use the hierarchical numbering scheme

### Read a note

```bash
obsidian read vault="AI Research" file="Note Title"
```

### Append/prepend to a note

```bash
obsidian append vault="AI Research" file="Note Title" content="\n\n## New Section\n\nContent here"
obsidian prepend vault="AI Research" file="Note Title" content="Content at top"
```

### Move/rename a note (updates internal links automatically)

```bash
obsidian move vault="AI Research" file="Old Name" to="New Name.md"
obsidian rename vault="AI Research" file="Old Name" name="New Name"
```

### Find related notes (backlinks)

```bash
obsidian backlinks vault="AI Research" file="Note Title"
```

### Find outgoing links

```bash
obsidian links vault="AI Research" file="Note Title"
```

### Find orphan and dead-end notes

```bash
# Notes with no incoming links
obsidian orphans vault="AI Research"

# Notes with no outgoing links
obsidian deadends vault="AI Research"

# Unresolved wikilinks
obsidian unresolved vault="AI Research"
```

### Find index notes

```bash
obsidian search vault="AI Research" query="Index" format=paths
```

### List tags, aliases, or properties

```bash
obsidian tags vault="AI Research"
obsidian aliases vault="AI Research"
obsidian properties vault="AI Research"
```

### Get note outline

```bash
obsidian outline vault="AI Research" file="Note Title"
```

### Daily notes

```bash
obsidian daily vault="AI Research"
obsidian daily:read vault="AI Research"
obsidian daily:append vault="AI Research" content="New entry"
```

### Output formatting

Most commands support `format=json|tsv|csv|md|paths`. Add `--copy` to copy results to clipboard.
