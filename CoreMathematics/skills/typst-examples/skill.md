---
name: typst-examples
description: Add or improve worked examples with solutions in Typst math lecture
  notes. Use when asked to write Example+Solution pairs that illustrate key concepts
  or common student mistakes.
---
## Scope
- Edit or add content inside `#example[]` and `#solution[]` environments only
- Do NOT edit prose outside those environments
- Do NOT modify `#set`, `#show`, `#import`, or `#let` blocks
- Preserve all existing labels and cross-references (`@eq:`, `@fig:`, etc.)

## Typst syntax

```typst
#example(title: "optional title")[
  Problem statement here. May contain inline math $f(x)$ or display math:
  $ f(x) = x^2 + 1. $
  Sub-parts use #h-enum:
  #h-enum(cols: 3)[
    + Sub-problem (a)
    + Sub-problem (b)
    + Sub-problem (c)
  ]
]
#solution[
  Use #enum with custom numbering for multi-part solutions:
  #enum(numbering: cn => box(width: 2em, align(right, text-sf[*(#cn)*])), tight: false)[
    Solution to (a). Use #no-num($...$) for unnumbered display math inside solution.
  ][
    Solution to (b).
  ]
]
```

- `#example[]` and `#solution[]` must appear as a consecutive pair
- Use `#no-num($...$)` for display math that should not be equation-numbered
- Use `#h-enum(cols: N)[...]` for multi-part sub-problems (N = 2, 3, or 4)

## Editorial context

This is a physics math drill book, not a formal math textbook. The author (Sho) writes with a warm, direct, and slightly humorous voice. This book aims for two things simultaneously: *fluency* (fast, accurate calculation) and *logical correctness*.

Key rules for examples:
- Every example should target a **specific student confusion point**, not just "show how to do the calculation."
- Common confusion patterns: sign errors; constant vs. variable ($a$ declared constant vs. $a$ as variable); notation traps ($\sin^2 x$ vs. $\sin x^2$, $\sin^{-1} x$ vs. $1/\sin x$); missing steps that look "obvious."
- The solution must show **all intermediate steps**. If a first-year student could miss a step, show it.
- Name pitfalls explicitly in the solution ("Note: do not confuse this with...").
- Prefer **physics-motivated contexts** (kinetic energy, oscillation, error, electric field) over pure algebra.
- State domains. If $a > 0$ is required, say so.
- Address the student in the same voice as the surrounding text.

Common confusion patterns to target:
- Sign errors and minus handling
- Constant vs. variable (e.g., $a$ declared as constant vs. as variable)
- Notation ambiguity (e.g., $f'(a)$ vs. $\frac{d}{dx}f(a)$)
- Missing steps that seem "obvious" but trip up beginners
- Subtle differences between similar-looking cases (e.g., $\sin(x^2)$ vs. $\sin^2(x)$)

### Solution quality criteria
- Show all intermediate steps — never skip a step that a first-year student might not see
- Conclude with an underlined or boxed final answer: `underline(...)` or `#box[...]`
- If there is a pitfall, name it explicitly (e.g., "Note: do not confuse this with...")
- Keep algebraic manipulations left-aligned and logically sequential

### Difficulty calibration
- Default: accessible to a first-year student who just read the section
- Examples should be slightly easier than the corresponding `#problems[]` exercises
- One example per key concept is usually enough; avoid redundancy

## Context loading strategy
1. Read ONLY the file specified by the user
2. Check existing `#example[]` blocks in that file to match style and avoid duplication
3. Do NOT open other `.typ` files unless explicitly asked
