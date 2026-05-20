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

## Custom environments

### Callout boxes
- `#remark[...]` — general remark
- `#be-careful[...]` — warning about a common mistake
- `#fail-safe[...]` — recovery hint for confused students
- `#advanced-note[...]` — optional deeper content (small text)

### Theorem-like (auto-numbered per chapter)
- `#theorem(title: none)[...]` — formal theorem
- `#example(title: none)[...]` — worked example
- `#solution[...]` — solution to preceding `#example`

### Exercise blocks
- `#quizzes[...]` — inline check questions (items: `` `4` `` level prefix)
- `#problems[...]` — exercise set (items: level prefix)
- Problem levels: `` `4` `` mandatory · `` `3` `` standard · `` `2` `` advanced · `` `1` `` challenge · `` `9` `` drill

### Layout helpers
- `#h-enum(cols: N)[+ ... ]` — multi-column numbered list
- `#no-num($...$)` — display math without equation number
- `#tab[...]` — indented block
- `#make-indent` — manual paragraph indent
- `#ornament-skip` — decorative section break
- `#keyword[word]` — emphasised term + index entry
- `#blank` — blank fill-in box

## Math helpers (physica.typ)
- `dv(f, x)` → $df/dx$; `dv(x)f` → operator form; `dv(f, x, x)` → second derivative
- `pdv(f, x)` → partial derivative
- `eval(expr)` → evaluation bar $|$
- Typical: `$eval(f'(x))_(x=a)$`, `$dv(f, x, style: "horizontal")$`

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
