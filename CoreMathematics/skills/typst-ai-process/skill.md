---
name: typst-ai-process
description: Scan Typst source files for !AI marker comments and replace each with
  generated content. Use when asked to "process AI markers", "run !AI todos", or
  "batch generate content".
---
## What this skill does

Finds every `// !AI ...` comment in the specified file(s), generates the requested
content in place, and removes the marker. Each marker type maps to the same rules
as the corresponding dedicated skill.

## Marker syntax

```typst
// !AI d: <instruction>
// !AI e: <instruction>
// !AI p: <instruction>
// !AI q: <instruction>
// !AI t: <instruction>
```

The marker must be on its own line (leading whitespace allowed).
The `<instruction>` is a free-form hint about what to generate.

### Examples

```typst
= Chain Rule

// !AI description: explain the chain rule for a composite function f(g(x)), mention the common mistake of forgetting the inner derivative

#quizzes[
  + `4` Differentiate $sin(x^2)$.
]

// !AI exercise: add level-4 and level-3 problems for chain rule, focus on cases where students forget the inner derivative
```

## Processing algorithm

For each file given:

1. **Read the entire file** to understand context, notation, and what already exists.
2. **Collect all markers** in order (do not skip any).
3. **For each marker**, generate content following the rules below.
4. **Replace** the `// !AI ...` line with the generated content.
   - Insert the content at the marker's position in the file.
   - Remove the marker line itself.
5. After processing all markers in a file, write the file once.

## Generation rules by marker type

### `d` for description
- Follow the same rules as the `typst-description` skill
- Rewrite or insert prose that explains the concept named in the instruction
- Do NOT add new equations; may reference existing labelled equations with `@label`
- Keep paragraph structure consistent with surrounding text

### `p` for problems
- Follow the same rules as the `typst-problems` skill
- Wrap content in `#problems[...]` or append to the nearest existing `#problems[...]`
  block if the marker is immediately before or inside one
- Choose problem levels based on the instruction; default: one `4` + one `3`
- Focus on confusion points named in the instruction
- For `9` drill items, follow the **Drill design** rules in the `typst-exercises` skill:
  group problems by the specific trap or sub-skill being practiced; never generate
  a random list of similar calculations

### `q` for quizzes
- Follow the same rules as the `typst-exercises` skill but use `#quizzes[...]`
- Short inline check questions; prefer level `4`

### `e` for examples
- Follow the same rules as the `typst-examples` skill
- Generate a `#example()[...]` immediately followed by `#solution[...]`
- Show all intermediate steps in the solution

### `t` for theorems
- Follow the same rules as the `typst-math` skill
- Generate a `#theorem(title: "...")[...]` block
- Define all symbols used; add a `#be-careful` or `#advanced-note` if warranted

## Quality checklist (apply to every generated block)

- [ ] Notation is consistent with the rest of the file
- [ ] All symbols are defined before first use
- [ ] No new `#set`/`#show`/`#let`/`#import` blocks introduced
- [ ] Existing labels and cross-references are not broken
- [ ] Generated exercises do not duplicate existing ones in the file
- [ ] Language: plain English, short sentences, no idioms

## Context loading strategy

1. Read every file that contains `// !AI` markers (specified by the user or found by searching)
2. Process one file at a time; do not mix edits across files in a single write
3. Do **not** open other files (other chapters, `misho-text.typ`, `physica.typ`, etc.) unless the marker instruction explicitly references them. Reading the target file is sufficient; opening extra files bloats the context window unnecessarily.
