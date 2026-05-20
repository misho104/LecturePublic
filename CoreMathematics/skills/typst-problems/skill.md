---
name: typst-problems
description: Improve existing exercises or add new ones to Typst
  math lecture notes. Use when asked to fix, rewrite, or generate
  exercise problems.
---
## Scope
- Edit or add content inside #problems[] and #quizzes[] environments only
- Use the same Typst syntax as existing exercises (check the file first)
- Do NOT add solutions nor solution environments

## Typst syntax

- #quizzes[] blocks have short check questions embedded in the text to confirm understanding while reading. Usually "4: mandatory" level only.
- #problems[] blocks have other exercises, together with drills.

~~~typst
#problems[
  - `4` Compute the derivative of $f(x) = x^2 sin(x)$.
  - `3` Show that ...
  - `9` Differentiate:
    #h-enum(cols: 4, v-sep: 1.5em)[
      + $x^3$
      + $3 sin(x)$
      + $ln(x)$
      + $sqrt(x)$
    ]
]
~~~

## Problem levels
- `4` mandatory — all students must attempt
- `3` standard — solidifies understanding  
- `2` advanced — only for really important topics
- `1` challenge — only for really important topics
- `9` drill — Hanon-style repetitive calculation; see drill design rules below

## Design principles for exercises

### Focus on student confusion points
Before writing, ask: *where do students typically go wrong with this topic?*
Prioritize problems that target:
- Common sign errors or algebraic slips
- Notation ambiguity (e.g., $f'(a)$ vs. $\frac{d}{dx}f(a)$, constant vs. variable)
- Subtle case distinctions that look similar but differ (e.g., $\sin(x^2)$ vs. $\sin^2(x)$)
- Steps students tend to skip and regret

Avoid problems that are merely "more of the same" — each problem should test something distinct.

### Drill design (`9` level)

Drills must not be random. Group problems by the *specific trap or sub-skill* being practiced, and order groups from simple to surprising. Each group should have a clear internal logic that a student can notice after solving a few.

Typical group types for calculation drills:
- **Canonical cases**: straightforward application of the rule (build fluency)
- **Trailing-zero / ambiguity trap**: result looks like a round number; correct notation requires scientific notation or explicit trailing zero (e.g., $2.0 \times 5.0 = 10 \to 1.0 \times 10^1$)
- **Dominant-term trap**: adding a small number to a large one; the small number vanishes (e.g., $1.0 \times 10^3 + 2.5 = 1.0 \times 10^3$)
- **Precision-loss trap**: subtraction of nearly-equal numbers destroys significant figures (e.g., $5.00 - 4.99 = 0.01$, only 1 SF)
- **Scientific-notation input**: both operands given in scientific notation; tests whether students apply the rule correctly in that form

For multi-step drills, additionally include:
- **Rule-order trap**: addition first then multiply vs. multiply first then add — different rules apply at each step and the sequence matters
- **Power trap**: $x^n$ keeps the same SF as $x$, but the result may require scientific notation

For unit-calculation drills, additionally include:
- **Prefix-conversion trap**: mixed prefixes (km + m, μm + nm) must be converted before applying the decimal-place rule; after conversion the number of decimal places changes
- **Vanishing-term trap**: after unit conversion one term is so small it disappears entirely
- **Physics-motivated problems**: use realistic values (speed of light, electron charge, Planck constant) so students see that these rules matter in real calculations

## When adding new exercises
1. Read the whole file first to check coverage and notation
2. Focus on levels 4 and 3. Add levels 2 and 1 only for really important topics.
3. For drills, maximize variety of problem patterns

## Context loading strategy
- Read ONLY the file specified by the user
- Do NOT open other .typ files unless explicitly asked
