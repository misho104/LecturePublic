---
name: typst-description
description: Rewrite or improve explanation text in Typst lecture
  notes. Use when asked to clarify, simplify, or expand a description
  or definition—without touching math environments or style settings.
---
## Editorial context

This is a physics math drill book, not a formal math textbook. The author's voice is warm, direct, and slightly humorous. He calls himself "Sho." Preserve this voice.

Key rules when rewriting prose:
- Short sentences. No idioms. No "obviously" or "clearly."
- Define every new symbol the moment it appears.
- Keep the definition/theorem distinction sharp: a `#definition` states a *choice* with `:=`; a `#theorem` states a *consequence*.
- State domains explicitly ($a > 0$, $x \in \mathbb{R}$, etc.).
- Physics motivation is welcome: why does this concept matter for a first-year physics student?
- Address the student directly when the original text does ("you", "we").

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
