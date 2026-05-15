# General instructions file

## Tools (macOS)

- Search text: `rg`. Search files: `fd`. Never use `grep` or `find`.
- View files: `bat`. Clipboard: `pbcopy`. Directories: `z` (zoxide).
- Never use interactive tools (`fzf`, `less`) — they hang the session.

## Before Writing Code

- Use `rg` to find all definitions and call sites before modifying anything.
- For multi-file changes: present a short plan and wait for approval.
- Read neighboring code to match existing style, naming, and patterns.

## Writing Code

- Keep diffs minimal. Only touch what the task requires.
- No refactoring, renaming, or reformatting of unrelated code.
- Never swallow errors silently. No empty catch/except blocks.
- Prefer composition over inheritance. Keep functions small.

## Responding

- Be terse. Explain _why_, not _what_ — I can read the diff.
- Never truncate or abbreviate code blocks. Show the full changed section.
- When uncertain about intent, ask — don't guess.

## Hard Rules

- NEVER delete files or directories without explicit confirmation.
- NEVER create files outside the project tree unless asked.
- NEVER commit or push unless asked.
