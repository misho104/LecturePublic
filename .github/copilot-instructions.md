# Copilot Instructions

## Repository Overview

This repository contains university lecture materials by Sho Iwamoto (NSYSU), licensed under CC BY-NC 4.0. Two sub-projects exist with different toolchains:

- **`CoreMathematics/`** — Typst source (`.typ` files), compiled to PDF
- **`GeneralPhysics/`** — LaTeX source (`.tex` files), compiled via `latexmk`

## Build Commands

### CoreMathematics (Typst)

```sh
cd CoreMathematics
make          # compile lecture.pdf
make watch    # live-recompile on save
make o        # open PDF
make clean    # remove PDFs
```

Direct compile (requires local fonts):
```sh
typst compile --font-path=/users/misho/Library/Fonts --input "time=$(date '+%H:%M:%S')" lecture.typ
```

### GeneralPhysics (LaTeX)

```sh
cd GeneralPhysics
make          # compile all PDFs via latexmk
make clean    # remove auxiliary files
```

## Typst Architecture (`CoreMathematics/`)

- `lecture.typ` — main entry point; imports `misho-text.typ` and `physica.typ`, includes chapter files
- `misho-text.typ` — the layout/style library (port of `MishoNote.cls`); defines all custom commands, colors, fonts, and page styles. **Do not modify `#set`, `#show`, `#import`, or `#let` blocks in this file.**
- `physica.typ` — physics/math notation helpers
- `title.typ`, `preface.typ` — front matter

### Key custom commands in `misho-text.typ`

| Command | Purpose |
|---|---|
| `#chapter[Title]` | Chapter opener with gray box; use instead of `= Heading` at top level |
| `#quizzes[...]` | Numbered quiz block |
| `#h-enum(cols: N)[...]` | Horizontal enumeration grid (default 4 columns) |
| `#text-sf(...)` / `#text-tt(...)` | Sans-serif / monospace with automatic scaling |
| `#JA(size: ..., "text")` | Japanese text inline |
| `c.blue`, `c.pink`, `c.green`, … | Named color palette |

Section headings use `= Title` (level 1 within a chapter = section, `== Title` = subsection).

## Conventions

### Typst files
- Preserve all `@label` cross-references (`@eq:`, `@fig:`, etc.) — do not rename labels
- Never restructure heading hierarchy
- The `--input "time=HH:MM:SS"` flag embeds the compile time in the PDF header via `sys.inputs`
- `# cspell: disable` / `# cspell: disable-line` comments suppress spell-check on code identifiers

### Language style (all lecture content)
- Plain English for undergraduate non-native speakers
- Short sentences; no idioms
- Define every symbol at first use within a section

### GitHub Pages / versioning
- PDFs are deployed to GitHub Pages via `.github/workflows/deploy-pages.yml`
- `.github/versions.json` lists older PDF versions to archive (format: `file`, `tag`, `version`)
- `.github/page-config.yml` controls category groupings on the index page
- See `.github/VERSIONING.md` for the full versioning workflow
