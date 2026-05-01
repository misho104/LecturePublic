---
name: typst-exercises
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
- `9` drill — Hanon-style repetitive calculation, maximize variety of patterns

## When adding new exercises
1. Read the whole file first to check coverage and notation
2. Focus on levels 4 and 3. Add levels 2 and 1 only for really important topics.
3. For drills, maximize variety of problem patterns

## Context loading strategy
- Read ONLY the file specified by the user
- Do NOT open other .typ files unless explicitly asked
