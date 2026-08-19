## Build

```sh
make          # compile lecture.pdf
make watch    # live-recompile on save
make o        # open PDF
```

## File structure

| File | Role |
|------|------|
| `lecture.typ` | Root document; imports chapters |
| `misho-text.typ` | All custom environments and template |
| `physica.typ` | Math helpers (`dv`, `pdv`, `eval`) |
| `N-topic.typ` | Chapter files (numbered) |

## Typst constraints
- NEVER modify `#set`, `#show`, `#import`, `#let` blocks
- NEVER change section structure or heading hierarchy
- Preserve all existing labels and cross-references (`@eq:`, `@fig:`, etc.)
- Do NOT add solutions inside `#problems[]` or `#quizzes[]` blocks

## What this book is

A **drill book**, not a math textbook. The goal is fluency (automatic calculation) *plus* logical correctness. Chapter 3 (Logic) is the backbone: it defines implication, equivalence, and what "solving an equation" really means. Every later chapter applies this framework.

**Definitions vs. theorems**: the book teaches students to separate *definitions* (human choices, marked `#definition`) from *theorems* (derived consequences, marked `#theorem`). Never blur this line when editing. A definition uses `:=` and states the domain explicitly.

**Physics grounding**: every concept has a physical motivation. Prefer physics-motivated examples (rates of change, forces, units, oscillation) over purely abstract algebra.

**Edge cases matter**: the author always states what is *not* defined ($\sqrt{x}$ for $x<0$, $a^x$ for $a<0$ and non-integer $x$, etc.). When adding content, state the domain and flag boundary cases with `#be-careful`.

**Author voice**: warm, slightly humorous, direct. The author refers to himself as "Sho." Keep "Sho" wherever it appears. Use short sentences, no idioms, define every symbol on first use.

**Exercise hierarchy**:
- `#quizzes` — quick mid-text checks, almost always level `4`
- `#problems` — section-end exercises; level `4` = pass bar; level `9` = structured drill
- Drills are grouped by *trap type*, not random. Order from simple to surprising.

**Callout boxes**:
- `#be-careful` — one specific, common student mistake
- `#fail-safe` — entry point for already-confused students
- `#advanced-note` — out-of-scope content for curious students; never required

## Custom environments

### Callout boxes
- `#remark[...]` — general remark
- `#be-careful[...]` — warning about a common mistake
- `#fail-safe[...]` — recovery hint for confused students
- `#advanced-note[...]` — optional deeper content (small text)
- `#hint[text]` — inline hint inside exercise items

### Theorem-like (auto-numbered per chapter)
- `#theorem(title: none)[...]` — formal theorem
- `#definition(title: none)[...]` — named definition (same blue style as theorem)
- `#example(title: none)[...]` — worked example
- `#solution[...]` — solution to preceding `#example`
- `#proof[...]` — proof block

### Exercise blocks
- `#quizzes[...]` — inline check questions (items: `` `4` `` level prefix)
- `#problems[...]` — exercise set (items: level prefix)
- Problem levels: `` `4` `` mandatory · `` `3` `` standard · `` `2` `` advanced · `` `1` `` challenge · `` `9` `` drill

### Layout helpers
- `#h-enum(cols: N)[+ ... ]` — multi-column numbered list (horizontal)
- `#v-enum(cols: N)[+ ... ]` — multi-column numbered list (vertical/reading-order)
- `#no-num($...$)` — display math without equation number
- `#tab[...]` — indented block
- `#make-indent` — manual paragraph indent
- `#divider()` — decorative ornamental section break (flower + line)
- `#keyword[word]` — emphasised term + index entry
- `#blank` — blank fill-in box

## Math helpers (physica.typ)
- `dv(f, x)` → $df/dx$; `dv(x)f` → operator form; `dv(f, x, x)` → second derivative
- `pdv(f, x)` → partial derivative
- `eval(expr)` → evaluation bar $|$
- Typical: `$eval(f'(x))_(x=a)$`, `$dv(f, x, style: "horizontal")$`

## Global math constants (misho-text.typ)
- `#ii` — imaginary unit (upright $\mathrm{i}$)
- `#ee` — Euler's number (upright $\mathrm{e}$)
- `#EE(x)` — `× 10^x` for scientific notation, e.g. `#EE(3)` → $\times 10^3$
- `#TT` — transpose symbol (thin upright T)
- `#unit(body)` — upright physics unit, e.g. `#unit("kg")` or `#unit($m/s^2$)`

## !AI marker system

Place `// !AI <type>: <instruction>` on its own line in any `.typ` file as a
deferred content request. Run the `typst-ai-process` skill to process all markers
in batch.

```typst
// !AI d: (d for description) explain the chain rule, mention the common mistake
// !AI e: (e for example)     worked example for product rule with a pitfall
// !AI p: (p for problem)     level-4 and level-3 problems for integration by parts
// !AI q: (q for quiz)        quick check on radian vs degree
// !AI t: (t for theorem)     state the mean value theorem
```

The skill finds every marker, generates the content, replaces the marker in-place,
and removes the comment. See `skills/typst-ai-process/skill.md` for full rules.

## Language style
- Plain English for undergraduate non-native speakers
- Short sentences. No idioms.
- Define every symbol at first use in a section
- For em-dash, use ASCII-style `foo---bar` without space
