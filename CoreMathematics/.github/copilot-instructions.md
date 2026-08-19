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
// !AI d: explain the chain rule, mention the common mistake
// !AI e: worked example for product rule with a pitfall
// !AI p: level-4 and level-3 problems for integration by parts
// !AI q: quick check on radian vs degree
// !AI t: state the mean value theorem
```

Types: `d` (description) · `e` (example+solution) · `p` (problems) · `q` (quiz) · `t` (theorem)

## Editorial philosophy

This lecture note has a distinctive and deliberate pedagogical character. Read this section carefully before editing anything.

### Who is the reader?

First-year university physics or physical-science students in their **second semester**. They have completed basic calculus. Many are non-native English speakers. They are not mathematics majors; they need tools, not full rigor.

The author writes with a warm, slightly humorous tone ("Birds sing, fish swim, flowers bloom, stars twinkle, and university students calculate derivatives."; "we are lazy!"). Do not sanitize this voice. Keep the first person, keep the humor, keep the direct address to the student.

### The book's central idea: drill for fluency, logic for correctness

This is explicitly **not** a math textbook. It is a **drill book** with logical scaffolding. Two goals run through every chapter:

1. **Fluency**: students must reach the point where basic calculations feel automatic. Drill problems (`9` level) are the backbone. Every chapter has them. They are never "just more of the same"---they are structured to build muscle memory and expose traps.

2. **Logical correctness**: students must stop writing things that "look right" and start writing things that *are* true. Chapter 3 (Logic) is the pivot of the whole book: it teaches implication ($\Rightarrow$), equivalence ($\Leftrightarrow$), necessary/sufficient conditions, and what "solving an equation" formally means. Every later chapter applies this framework---definitions are marked `#definition`, derived facts are marked `#theorem`, and the distinction is never blurred.

When writing or reviewing content, ask: *does this help a student become both faster and more careful?* If it only does one, it is incomplete.

### Definitions vs. theorems: the core distinction

The book explicitly teaches students to separate **definitions** (human choices, not provable) from **theorems** (logical consequences, provable). This is introduced early in Chapter 3 and carried consistently:

- The definition of $\sqrt{a}$ is a *choice* (the positive root), not a theorem.
- $a^x$ for irrational $x$ is *defined* via limits, step by step, not "it's obvious."
- The imaginary unit $\mathtt{i}$ is *defined* as a symbol with $\mathtt{i}^2 = -1$, not "the square root of $-1$."

**Never** write a definition as if it were a theorem, and **never** label a conventional choice as a derived result. When adding a new definition, model it on the existing ones: state the domain carefully, give the symbol with `:=`, and identify what is being *chosen* versus what *follows*.

### Physics grounding throughout

This is math *for physicists*. Every concept should have a physical interpretation nearby:
- Derivatives are rates of change *and* slopes of tangents *and* limits.
- Radians are natural because $(sin x)' = \cos x$ only works in radians.
- Units are *part of* the number, not decoration---$m = 110\,\text{g}$, never $m = 110$.
- Vectors are arrows *first*, lists of numbers *second*, abstract elements *third*.
- Complex numbers lead toward Euler's formula, bra-ket notation, and quantum mechanics.

When writing examples or problems, prefer **physics-motivated contexts** (kinetic energy, electric field, oscillation, error analysis) over purely abstract algebra.

### Handling edge cases and domain restrictions explicitly

The author is meticulous about what is and is not defined:
- $\sqrt{x}$ for $x < 0$: deliberately not defined (and there is a `#be-careful` block about it).
- $a^x$ for $a < 0$ and non-integer $x$: deferred with a table summarizing what is and isn't covered.
- $0^0$: noted as "not considered (but sometimes $0^0 := 1$)."
- The "parallel" direction ambiguity for vectors: flagged and the word avoided.

When adding content, **state the domain**. Do not silently assume $x > 0$ or $a \neq 0$. If the formula breaks at a boundary, say so---with a `#be-careful` or a domain qualifier.

### The `#be-careful` / `#fail-safe` / `#advanced-note` system

These three callout boxes encode three different author intentions:

- **`#be-careful`**: a *specific, common wrong move* that students make. Not a vague warning---it should point to one concrete mistake (e.g., "do not confuse $\sin^{-1} x$ with $1/\sin x$"). Use sparingly; one per confusing point.
- **`#fail-safe`**: what to do *after* a student is already lost. Gives a simpler entry point (e.g., "set $a = 3$ and see if @eq:d1 makes sense"). Use when the surrounding text is genuinely hard for beginners.
- **`#advanced-note`**: content beyond the course scope, for curious or advanced students. Mathematicians' objections, physicist shorthand, subtleties that would derail the main text. Never required for understanding the core material.

Do not turn every remark into a `#be-careful`. Reserve it for traps that actually hurt students.

### Exercise design philosophy

Exercises are the *core* of this document (the preface says so explicitly). Design principles:

- **Quizzes** (`#quizzes`) appear mid-text, right after a concept is introduced. They are mandatory, quick checks---"did you actually read and understand that sentence?" Almost always level `4`.
- **Problems** (`#problems`) appear at the end of sections or chapters. Level `4` is the minimum bar for passing. Level `3` builds confidence. Level `2` is for A+ students. Level `1` is research-flavored. Level `9` is drill.
- **Drills** are not random. Group them by trap (trailing-zero, dominant-term, precision-loss, etc.) in order of increasing subtlety. A student who finishes a drill group should notice a *pattern*, not just a count.
- **Blank-fill problems** (`#blank`) are used for rules and identities that students must memorize. They appear in quizzes and low-level problems.
- **Problems that expose logical errors** (find the mistake in this "solution") are a recurring pattern. They connect back to Chapter 3.

### Voice and writing style

- Address the student directly: "You may write...", "Sho thinks...", "Please be careful."
- The author refers to himself as "Sho." Do not change this to "the author" or "we."
- Use "we" only for mathematical reasoning shared with the student ("we define...", "we can show...").
- Sentences are short. Avoid relative clauses stacked on relative clauses.
- Never use idioms (non-native speakers).
- Define every new symbol the moment it appears. Do not write $\delta_{jk}$ and define it two sentences later.
- For display math that is not central enough to deserve an equation number, use `#no-num($...$)`.
- Avoid the word "obviously" and "clearly"---what is clear to the author is often not clear to the student.

### Notation consistency

Notation changes must be applied **globally** across all files. A mismatch between chapters is more confusing for students than any single local error. Before introducing or changing notation, check all chapter files.

Key notations to respect:
- Vectors: $\vec{v}$ (arrow notation, `vc(v)`), never boldface in the main text.
- Imaginary unit: `#ii` ($\mathtt{i}$, upright), never $i$.
- Euler's number: `#ee` ($\mathtt{e}$, upright), never plain $e$.
- Units: `#unit(...)`, always upright; italic for quantities, upright for units.
- Derivatives: `dv(f, x)` from physica.typ; the notation $f'(x)$ is also used and both are valid.

### What to fix freely vs. what to propose first

When reviewing chapters, apply this priority order:

1. **Mathematical errors** (wrong sign, wrong condition, wrong formula) — fix immediately.
2. **Typos and grammar** — fix immediately.
3. **Notation inconsistencies** — fix immediately, globally.
4. **Clarity and language** (confusing wording, undefined symbols, wrong variable names) — fix immediately.
5. **Pedagogy** (missing motivation, abrupt transitions, misleading examples) — fix if the change is local and conservative; otherwise propose first.
6. **Structural changes** (reordering sections, moving exercise blocks, splitting theorems) — **always propose to the author first**. The author may have reasons for the current structure, and structural changes that seem obvious may be reverted.

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
| `#hint[text]` | Inline hint inside exercise items, e.g. `#hint[Use the chain rule]` |

### Theorem-like (auto-numbered per chapter)
| Environment | Purpose |
|-------------|---------|
| `#theorem(title: none)[...]` | Formal theorem, blue border |
| `#definition(title: none)[...]` | Named definition, blue border (same style as theorem) |
| `#example(title: none)[...]` | Worked example, green border |
| `#solution[...]` | Solution to the preceding `#example`, green border (no counter step) |
| `#proof[...]` | Proof block (indented, ends with QED mark) |

### Exercise blocks
| Environment | Purpose |
|-------------|---------|
| `#quizzes[...]` | Short inline check questions; items use `` `4` `` level prefix |
| `#problems[...]` | Exercise set at end of section; items use level prefix |

Problem levels: `` `4` `` mandatory · `` `3` `` standard · `` `2` `` advanced · `` `1` `` challenge · `` `9` `` drill

### Layout helpers
| Helper | Purpose |
|--------|---------|
| `#h-enum(cols: N)[+ ... + ...]` | Multi-column numbered list (horizontal) |
| `#v-enum(cols: N)[+ ... + ...]` | Multi-column numbered list (vertical/reading-order) |
| `#no-num($...$)` | Display math without equation number |
| `#tab[...]` | Indented block |
| `#make-indent` | Manual paragraph indent |
| `#divider()` | Decorative ornamental section break (flower + line) |
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

## Global math constants and helpers (`misho-text.typ`)

| Symbol/Function | Meaning |
|-----------------|---------|
| `#ii` | Imaginary unit (upright $\mathrm{i}$) |
| `#ee` | Euler's number (upright $\mathrm{e}$) |
| `#EE(x)` | Scientific notation multiplier $\times 10^x$ (use `#EE(3)` for $\times 10^3$) |
| `#TT` | Transpose symbol (thin upright T, as in $A^{\mathrm{T}}$) |
| `#unit(body)` | Upright physics unit, e.g. `#unit("kg")` or `#unit($m/s^2$)` |

## Chapter-defined macros

Each chapter file defines its own macros at the top. Key ones used across chapters:

### `5-vector.typ`
| Macro | Meaning |
|-------|---------|
| `vc(v)` | Arrow vector $\vec{v}$ |
| `va(v)` | Magnitude $|\vec{v}|$ |
| `vcu(v)` | Unit vector $\hat{v}$ |
| `dm(a; b; c)` | Display column vector |
| `vector-three-ways` | Reusable enum of 3 interpretations of vectors |

### `6-complex.typ`
| Macro | Meaning |
|-------|---------|
| `Arg` | Principal argument operator $\mathrm{Arg}$ |
| `cip(a, b)` | Complex inner product $\langle\vec{a}|\vec{b}\rangle$ |
| `lbk(x, y)` | Loose bra-ket $\langle x | y \rangle$ |
| `vk(x)` | Ket of a vector $|\vec{x}\rangle$ |
| `cop(x, y)` | Outer product $|\,x\rangle\langle y\,|$ |

Note: `#ii` (imaginary unit) and `#ee` (Euler's number) are global helpers in `misho-text.typ`, not chapter-local.

### `7-matrix.typ`
| Macro | Meaning |
|-------|---------|
| `mx(...)` | Matrix with round brackets `mat(..args)` |

## Chapter keys

| Key | Chapter | Status |
|-----|---------|--------|
| `chap:deriv` | 1 — Derivatives | complete |
| `chap:units` | 2 — Units & Significant Figures | complete |
| `chap:logic` | 3 — Logic | complete |
| `chap:pow` | 4 — Powers & Logarithms | complete |
| `chap:vector` | 5 — Vectors | complete |
| `chap:complex` | 6 — Complex Numbers | complete |
| `chap:matrix` | 7 — Matrices | complete |
| *(planned)* | Vector Calculus (grad, div, curl) | not yet written |
| *(planned)* | Ordinary Differential Equations | not yet written |
| *(planned)* | Probability & Error Analysis | not yet written |
| *(planned)* | Linear Algebra (abstract vector spaces) | not yet written (`x-algebra.typ` is an early draft) |

`6-matrix.typ` is a superseded draft; the active file is `7-matrix.typ`.
