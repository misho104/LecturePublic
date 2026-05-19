---
name: typst-math
description: Add or improve theorems, definitions, and formal mathematical content
  in Typst lecture notes. Use when asked to write or revise #theorem blocks, add
  formal definitions, or improve mathematical exposition.
---
## Scope
- Edit or add content inside `#theorem[]`, `#example[]`, and `#solution[]` environments
- May also add `#advanced-note[]` or `#be-careful[]` if mathematically warranted
- Do NOT edit prose outside these environments
- Do NOT modify `#set`, `#show`, `#import`, or `#let` blocks
- Preserve all existing labels and cross-references

## Typst syntax for theorems

```typst
#theorem(title: "optional name")[
  Let $f : RR -> RR$ be differentiable. Then ...
  $ f(a + epsilon) approx f(a) + epsilon f'(a). $ <eq:taylor-1>
]
```

- Use `$ ... $ <label>` to add an equation number and label
- Use `#no-num($...$)` for display equations that should NOT be numbered
- Reference equations with `@label` in the text
- All math must be typeset in Typst math mode (`$...$`), never as plain text

## Math helpers available (`physica.typ`)

| Function | Renders as |
|----------|-----------|
| `dv(f, x)` | $df/dx$ |
| `dv(f, x, x)` | $d^2f/dx^2$ |
| `dv(x)f` | $(d/dx)f$ operator form |
| `pdv(f, x)` | $\partial f/\partial x$ |
| `eval(expr)` | evaluation bar $\|$ |

Use `dv(f, x, style: "horizontal")` for inline-style $f'/x$.

## Design principles

### Audience
First-year university physics students. Assume calculus is known but rigour is new.

### Clarity over generality
- State the most useful special case first, then mention the general form
- Avoid "it can be shown that" — either show it or mark it `#advanced-note`
- Every symbol must be defined before it is used in the theorem statement

### Physical motivation
- Whenever possible, state why the theorem matters for physics
- Prefer concrete illustrative formulas over abstract notation

### Consistency
1. Read the whole chapter file before writing to match notation and style
2. Use the same symbol conventions already established in the file
3. Do NOT introduce new notation without defining it

## Context loading strategy
1. Read ONLY the file specified by the user
2. Check existing `#theorem[]` blocks for style and notation consistency
3. Do NOT open other `.typ` files unless explicitly asked
