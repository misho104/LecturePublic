# Copilot Instructions — CoreMathematics

This repository contains a Typst lecture note ("Core Mathematics") for first-year university physics students.

## Build

```sh
make          # compile lecture.pdf
make watch    # live-recompile on save
make o        # open PDF
```

Font path is set in `Makefile`; do not change it.

## File structure

| File | Role |
|------|------|
| `lecture.typ` | Root document; imports chapters |
| `misho-text.typ` | All custom environments and template |
| `physica.typ` | Math helpers (`dv`, `pdv`, `eval`) |
| `N-topic.typ` | Chapter files (numbered) |
| `refs.yml` | Bibliography |

## !AI marker system

Place `// !AI <type>: <instruction>` on its own line anywhere in a `.typ` file as
a deferred content request. Run the `typst-ai-process` skill to process all markers
in a file at once.

```typst
// !AI description: explain the chain rule, mention the common mistake
// !AI example: worked example for product rule with a pitfall
// !AI exercise: level-4 and level-3 problems for integration by parts
// !AI quiz: quick check on radian vs degree
// !AI theorem: state the mean value theorem
```

Types: `description` · `example` · `exercise` · `quiz` · `theorem`

## Hard constraints

- **NEVER** modify `#set`, `#show`, `#import`, or `#let` blocks
- **NEVER** change section structure or heading hierarchy
- **Preserve** all existing labels and cross-references (`@eq:label`, `@fig:label`, etc.)
- **Do not** add `#solution[]` content to `#problems[]` or `#quizzes[]` blocks

## Language style

- Plain English for undergraduate non-native speakers
- Short sentences. No idioms.
- Define every symbol at first use in a section
- For em-dash, use `foo---bar` (no spaces)

## Custom environments (all defined in `misho-text.typ`)

### Callout boxes
| Environment | Purpose |
|-------------|---------|
| `#remark[...]` | General remarks, gray left-border |
| `#be-careful[...]` | Warning about common mistakes, red left-border |
| `#fail-safe[...]` | Recovery hint when a student gets confused, small gray text |
| `#advanced-note[...]` | Optional deeper content, small purple text |

### Theorem-like (auto-numbered per chapter)
| Environment | Purpose |
|-------------|---------|
| `#theorem(title: none)[...]` | Formal theorem, blue border |
| `#example(title: none)[...]` | Worked example, green border |
| `#solution[...]` | Solution to the preceding `#example`, green border (no counter step) |

### Exercise blocks
| Environment | Purpose |
|-------------|---------|
| `#quizzes[...]` | Short inline check questions; items use `` `4` `` level prefix |
| `#problems[...]` | Exercise set at end of section; items use level prefix |

Problem levels: `` `4` `` mandatory · `` `3` `` standard · `` `2` `` advanced · `` `1` `` challenge · `` `9` `` drill

### Layout helpers
| Helper | Purpose |
|--------|---------|
| `#h-enum(cols: N)[+ ... + ...]` | Multi-column numbered list |
| `#no-num($...$)` | Display math without equation number |
| `#tab[...]` | Indented block |
| `#make-indent` | Manual paragraph indent |
| `#ornament-skip` | Decorative section break |
| `#keyword[word]` | Emphasised term + index entry |
| `#blank` | Blank box (fill-in-the-blank exercises) |
| `#TODO[...]` | Highlighted to-do note |

### Color/text helpers
`#EMPH`, `#GRAY`, `#BLUE`, `#PINK`, `#GREEN`, `#RED`, `text-sf(...)`, `text-tt(...)`

## Math helpers (`physica.typ`)

| Function | Meaning |
|----------|---------|
| `dv(f, x)` | $\frac{df}{dx}$ |
| `dv(f, x, x)` | $\frac{d^2f}{dx^2}$ |
| `dv(x)f` | $\frac{d}{dx}f$ (operator form) |
| `pdv(f, x)` | $\frac{\partial f}{\partial x}$ |
| `eval(expr)` | $\left. \text{expr} \right\|$ (evaluation bar) |

Typical usage: `$eval(f'(x))_(x=a)$`, `$dv(f, x, style: "horizontal")$`
