---
name: typst-description
description: Rewrite or improve explanation text in Typst lecture
  notes. Use when asked to clarify, simplify, or expand a description
  or definition—without touching math environments or style settings.
---
## Scope
- Read ONLY on the files specified in $ARGUMENTS
- Rewrite prose passages only
- Avoid altering math expressions
- Avoid adding new equations
- Try to keep the same paragraph structure

## Context loading strategy
1. Read ONLY the target file specified by the user
2. Do NOT open other .typ files unless explicitly asked

## Quality criteria
- Would a student seeing this concept for the first time understand it?
- Novice students can avoid typical pitfalls? No risk of confusion?
