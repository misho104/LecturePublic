// ============================================================
// misho-note.typ — port of MishoNote.cls
//
// Usage:
//   #import "misho-note.typ": *
//   #show: misho-note.with(title: "...", author: "...", ...)
//   // title page rendered automatically; body follows
//   #chapter[Chapter Title]
//   = Section heading
// ============================================================

// ── Compile-time datetime ─────────────────────────────────────
// Pass `--input time=HH:MM:SS` for a time component; otherwise 00:00:00.
#let now = {
  let t = datetime.today()
  let (h, m, s) = if "time" in sys.inputs { sys.inputs.time.split(":").map(int) } else { (0, 0, 0) }
  datetime(year: t.year(), month: t.month(), day: t.day(), hour: h, minute: m, second: s)
}

// ── Fonts ─────────────────────────────────────────────────────
#let _font-serif = "STIX Two Text"  // main body font             cspell: disable-line
#let _font-sans = "Roboto"          // sans-serif (scaled ×0.91)  cspell: disable-line
#let _font-mono = "Roboto Mono"     // monospace  (scaled ×0.85)  cspell: disable-line

// Scaled font helpers.
// Without arguments, size is read from the surrounding context and scaled.
// `size:` sets an explicit base size (still scaled). `true-size:` sets absolute (no scaling).
#let text-sf(true-size: none, size: none, ..args) = context text(
  font: _font-sans,
  size: if true-size != none { true-size } else { (if size != none { size } else { text.size }) * 0.91 },
  ..args,
)
#let text-tt(true-size: none, size: none, ..args) = context text(
  font: _font-mono,
  size: if true-size != none { true-size } else { (if size != none { size } else { text.size }) * 0.85 },
  ..args,
)

/* original idea was
#let text-tt(true-size: none, size: 1em, ..args) = text(
  font: _font-mono, size: if true-size != none { true-size } else { size * 0.85 }, .   .args)
  but improved according to Github copilot.
*/

#let dim = (
  tab: 2.5em, // default "tab-shift" \BaseTab
  shift: 15mm,
  label-width: 2.0em,
  label-sep: 0.5em,
  left-margin: 2.5em,
  indent: 17pt,
)

// ── Colors ────────────────────────────────────────────────────
// cspell:disable
#let c = (
  "gray": luma(50%), // \gray
  "light-gray": luma(80%), // \lightgray
  "dim-gray": luma(90%), // \dimgray
  "blue": rgb("#0e51c9"), // pBlue
  "pink": rgb("#ff45a0"), // pPink
  "green": rgb("#348d1b"), // pGreen
  "light-orange": rgb("#ffd69d"), // pLightOrange
  "light-purple": rgb("#aa78d6"), // pLightPurple
  "light-green": rgb("#00ffd0"), // pLightGreen
  "alt-a": rgb(100%, 20%, 0%), // AltDefA — red-orange (\RED, \C)
  "alt-b": rgb(15%, 50%, 70%), // AltDefB — steel blue (\C*), use sparingly
)
// cspell:enable

#let ornament-skip = [#parbreak()#block(spacing: 24pt, grid(
    columns: (1fr, 12.5em, 16pt, 12.5em, 1fr),
    align: (right, right, center, left, left).map(c => horizon + c),
    text(10pt)[☙],
    line(start: (0em, 0em), end: (12em, 0em), stroke: (cap: "round", paint: gradient.linear(white, black, white))),
    text(14pt)[✢],
    line(start: (0em, 0em), end: (12em, 0em), stroke: (cap: "round", paint: gradient.linear(white, black, white))),
    text(10pt)[❧],
  ))#parbreak()]


#let _enum-horizontal(
  cols: 1,
  label-width: dim.label-width,
  label-sep: dim.label-sep,
  label-style: (pf, cnt) => align(right, pf + text-sf[*\(#{ cnt("1") }\)*]),
  label-start: 0,
  prefixes: (),
  label-align: top,
  v-sep: 1em,
  h-sep: 0mm,
  inset: (:),
  ..items,
) = {
  let label_item = n => {
    if type(label-start) == counter {
      e => context (label-start.step(level: 2)) + context (label-start.display(e))
    } else if type(label-start) == int {
      e => context (counter("tmp").update(n + 1)) + context (counter("tmp").display(e))
    } else {
      assert(False, "invalid type for enum-counter")
    }
  }
  let numbered = items
    .pos()
    .enumerate()
    .map(((i, body)) => (label-style(prefixes.at(i, default: ""), label_item(i)), "", body))
  set par(first-line-indent: 0em, hanging-indent: 0em)
  grid(
    columns: range(cols).map(it => (label-width, label-sep, 1fr)).flatten(),
    column-gutter: h-sep,
    row-gutter: v-sep,
    align: (label-align, label-align, horizon),
    inset: (inset, 0em, 0em),
    ..numbered.flatten()
  )
}
#let h-enum(..args, cols: 4, body) = {
  show enum: it => _enum-horizontal(
    label-align: horizon,
    cols: cols,
    ..args,
    ..it.children.map(it => {
      it.body
    }),
  )
  body
}

// ── Page-style state ──────────────────────────────────────────
// The gray box visually covers the header rule on non-normal pages.
#let head-title-style(body) = text-sf(fill: c.light-gray, size: 9pt, body)
#let head-date-style(body) = text-tt(fill: c.dim-gray, size: 9pt, body)
#let head-number-style(body) = text-sf(weight: "bold", size: 12pt, body)

#let _page-style-default = (
  // left, right, page-num
  "title": none,
  "chapter": (
    none,
    ("@date", it => text-tt(fill: c.dim-gray, size: 9pt, it)),
    ("@number/@total", it => text-sf(weight: "bold", size: 12pt, it)),
  ),
  "normal": (
    ("@chapter-name", it => text-sf(fill: c.light-gray, size: 9pt, it)),
    ("@date", it => text-tt(fill: c.dim-gray, size: 9pt, it)),
    ("@number/@total", it => text-sf(weight: "bold", size: 12pt, it)),
  ),
)
#let _page-style = state("page-style", none)
#let set-page-style(option) = {
  if option in _page-style-default {
    _page-style.update(_page-style-default.at(option))
  }
}

// ── Gray title/chapter box ────────────────────────────────────
#let _draw-chapter-box(number, title) = {
  place(top + left, dx: 0mm, dy: -4.5mm, rect(width: 160mm, height: 32mm, fill: c.dim-gray, stroke: none))
  place(top + left, dx: 2mm, dy: -2.5mm, rect(width: 156mm, height: 10mm, fill: none, stroke: 0.4pt + black))
  place(
    top + left,
    dx: 6.3mm,
    dy: -2mm,
    box(fill: c.dim-gray, outset: 1mm, inset: (right: 1mm), text(size: 16pt, "Chapter "))
      + box(fill: c.dim-gray, outset: 1mm, text(size: 40pt, number)),
  )
  place(
    top + left,
    dx: 6.3mm,
    dy: 15.8mm,
    text-sf(size: 22pt, weight: 700, title),
  )
  v(32mm)
}

// ── Chapter command ───────────────────────────────────────────
// Inserts a chapter-opening page with a gray box.
// State is updated BEFORE pagebreak so the new page's header sees it.
// The hidden level-1 heading registers the chapter in #outline().
#let to-string(it) = {
  if type(it) == str {
    it
  } else if type(it) != content {
    str(it)
  } else if it.has("text") {
    it.text
  } else if it.has("children") {
    it.children.map(to-string).join()
  } else if it.has("body") {
    to-string(it.body)
  } else if it == [ ] {
    " "
  }
}
#let current-chapter = state("current-chapter", (0, "", ""))
#let chapter(title) = {
  set-page-style("chapter")
  pagebreak()
  heading(level: 1, title)
  let number = context (counter(heading).at(here()).at(0))
  _draw-chapter-box(number, title)
  current-chapter.update((number, title, [Chapter #number: #title]))
  set-page-style("normal")
  counter("problem").step()
  counter("quiz").step()
}

// Text-level styles
#let GRAY(body) = text(fill: c.gray, body)
#let BLUE(body) = text(fill: c.blue, body)
#let PINK(body) = text(fill: c.pink, body)
#let GREEN(body) = text(fill: c.green, body)
#let RED(body) = text(fill: c.alt-a, body)

#let EMPH(body) = text-sf(strong(body))
#let ZH = text.with(lang: "zh", script: "hant", region: "tw", font: "思源宋體")
#let JA = text.with(lang: "ja", script: "jpan", region: "jp", font: "Harano Aji Mincho") // cspell: disable-line



#let make-indent = h(dim.indent)








#let clr-example = rgb("#1a6b3c")   // forest green
#let clr-problem = rgb("#8b4513")   // saddle brown
#let clr-quiz = rgb("#1a62a8")   // medium blue
#let clr-theorem = rgb("#6b1a6b")   // royal purple

// ── Counters ────────────────────────────────────────────────
#let _env-ctr = counter("env")
#let _prob-ctr = counter("problem")
#let _quiz-ctr = counter("quiz")
#let _part-ctr = counter("part")

// ── Helpers ─────────────────────────────────────────────────

// Titled header box  (example / theorem)
#let _header-box(icon: "●", label: "Box", accent: black, body) = {
  _env-ctr.step()
  block(
    width: 100%,
    breakable: true,
    radius: 0pt,
    inset: 0pt,
    stroke: (top: 3pt + accent, rest: 0.7pt + accent.lighten(45%)),
    fill: accent.lighten(94%),
  )[
    #block(width: 100%, fill: accent.lighten(80%), inset: (x: 10pt, y: 6pt))[
      #text(fill: accent.darken(15%), weight: "bold", size: 10pt)[
        #icon #h(4pt) #label #h(3pt) #context _env-ctr.display()
      ]
    ]
    #line(length: 100%, stroke: 0.4pt + accent.lighten(45%))
    #block(inset: (x: 12pt, y: 10pt))[#body]
  ]
}
#let _header-only-box(label: "Box", text-style: (:), ..args) = {
  block(
    width: 100%,
    sticky: true,
    inset: (x: 0pt, top: 3mm, bottom: 1.5mm),
    below: 0mm,
    text(..text-style, h(4mm) + label),
    ..args,
  )
}

// Plain frame box  (problems / quizzes)
#let _plain-box(..args, body) = [
  #block(
    width: 100%,
    inset: (x: 4mm, top: 1.2em, bottom: 1em),
    breakable: true,
    radius: 0pt,
    below: 0mm,
    stroke: (..args.at("stroke", default: (:)), bottom: 0mm),
    ..args,
    body,
  )
  #block(
    width: 100%,
    height: 0.2em,
    ..args,
    stroke: (..args.at("stroke", default: (:)), top: 0mm),
  )
]

#let remark(..args, body) = {
  let accent = rgb(128, 128, 128)
  pad(left: dim.shift, _plain-box(
    fill: accent.lighten(80%),
    stroke: (left: 2mm + accent),
    ..args,
    [ #text-sf(weight: "bold", true-size: 11pt, "Remark: ") #body],
  ))
}
#let fail-safe(..args, body) = {
  let accent = rgb(128, 128, 128)
  pad(left: dim.shift, _plain-box(
    fill: accent.lighten(80%),
    inset: (x: 4mm, y: 2mm),
    ..args,
    [ #text-sf(weight: "bold", true-size: 9pt, "Fail safe note: ") #text(size: 9pt)[#body] ],
  ))
}

#let advanced-note(..args, body) = {
  let accent = c.light-purple
  pad(left: dim.shift, _plain-box(
    fill: accent.lighten(80%),
    inset: (x: 4mm, y: 2mm),
    ..args,
    [ #text-sf(weight: "bold", true-size: 9pt, "Advanced note: ") #text(size: 9pt)[#body] ],
  ))
}


// ── State flags (one per container type) ────────────────────
#let _enum-depth = state("_enum-depth", 0)

// ── Public API ───────────────────────────────────────────────



/// (a)(b)(c) sub-parts — use inside #problem or #quiz
#let subproblem(body) = {
  _part-ctr.step()
  grid(
    columns: (1.4em, 1fr),
    align: (top, top),
    context text(weight: "bold")[(#numbering("a", _part-ctr.get().first()))], body,
  )
  v(0.3em)
}

/// Solution section inside #example — ruled divider + label
#let solution(body) = {
  v(4pt)
  grid(
    columns: (auto, 1fr),
    align: horizon,
    column-gutter: 8pt,
    text(weight: "bold", style: "italic", size: 9.5pt, fill: clr-example.darken(5%))[Solution.],
    line(stroke: 0.6pt + clr-example.lighten(50%)),
  )
  v(6pt)
  body
}

/// Example box  (green, titled header)
#let example(title: none, body) = _header-box(
  icon: "📘",
  accent: clr-example,
  label: if title != none { "Example – " + title } else { "Example" },
  body,
)

/// Theorem box  (purple, titled header, italic body)
#let theorem(title: none, body) = _header-box(
  icon: "📐",
  accent: clr-theorem,
  label: if title != none { "Theorem – " + title } else { "Theorem" },
)[#emph(body)]

/// Proof  (slim grey left-bar, □ mark, no counter)
#let proof(body) = block(
  width: 100%,
  radius: 0pt,
  stroke: (left: 3pt + luma(170)),
  inset: (left: 10pt, y: 6pt),
)[
  #text(style: "italic")[#body] #h(1fr) #text(size: 12pt)[□]
]

#let level-symbols = (
  "4": JA(size: 9pt, "★"),
  "3": "***",
  "2": "**",
  "1": "*",
  "9": box(height: 6pt, move(dy: -5pt, "💪")), //
)

#let label-styles = (
  "problem": (pf, cn) => align(right, pf + text-sf[*#cn("1.1").*]),
  "quiz": (pf, cn) => align(right, pf + text-sf[*#cn(((..n) => str(n.pos().at(1)))).*]),
  "(1)": (pf, cn) => align(right, pf + text-sf[*(#cn("1"))*]),
)


#let _extract-levels(items) = array.zip(..items.map(it => if it.body.has("children")
  and it.body.children.first().func() == raw
  and (it.body.children.first().text.contains(regex("^\d+$"))) {
  (level-symbols.at(it.body.children.first().text, default: "?"), it.body.children.slice(1).join())
} else {
  ("", it.body)
}))

#let _problem-box(..args, label: "Problems", accent: red, indent: false, counter-name: "problem", body) = {
  pad(left: if indent { dim.shift } else { 0mm })[
    #_header-only-box(
      stroke: if indent { (left: 2mm + accent, bottom: 1pt + accent) } else {
        (bottom: 1pt + accent, rest: .5mm + accent)
      },
      fill: accent.lighten(80%),
      label: label,
      text-style: (
        fill: accent.saturate(50%),
        weight: "black",
        size: 16pt,
        tracking: 3pt,
        font: _font-sans,
      ),
    )
    #_plain-box(
      fill: accent.lighten(80%),
      stroke: if indent { (left: 2mm + accent) } else { (top: 0pt, rest: 0.5mm + accent) },
    )[
      #show enum: it => {
        _enum-depth.update(d => d + 1)
        let depth = _enum-depth.get()
        if depth == 0 {
          let c = _extract-levels(it.children)
          _enum-horizontal(
            label-start: counter(counter-name),
            label-width: dim.label-width + 3mm,
            label-sep: dim.label-sep,
            v-sep: 2em,
            label-style: label-styles.at(counter-name),
            prefixes: c.at(0),
            inset: (left: -20mm),
            ..args,
            ..c.at(1),
          )
        } else if depth > 0 {
          _enum-horizontal(
            label-width: 1.5em,
            label-start: 0,
            label-style: label-styles.at("(1)"),
            ..args,
            ..it.children.map(it => it.body),
          )
        }
        _enum-depth.update(d => d - 1)
      }
      #body
    ]
  ]
}

#let quizzes(..args, body) = _problem-box(
  label: "Quiz",
  accent: c.light-orange,
  indent: true,
  counter-name: "quiz",
  ..args,
  body,
)
#let problems(..args, body) = _problem-box(
  label: "Problems",
  accent: c.light-orange,
  indent: false,
  counter-name: "problem",
  ..args,
  body,
)

// ── Template ──────────────────────────────────────────────────
// Parameters:
//   title           — document title (string)
//   author          — author name (string)
//   date            — datetime; use `now` for the compile-time date
//   description     — PDF subject string (optional)
//   copyright-years — content shown as "© YEARS AUTHOR", e.g. [2024–2025]
//   license-url     — URL linked from the copyright line (optional)
#let default-metadata = (
  title: "Untitled",
  author: "Sho Iwamoto",
  date: now,
  subtitle: "",
  description: "",
  copyright-years: "",
)

#let misho-text(custom-metadata, body) = {
  let metadata = default-metadata + custom-metadata
  // ── PDF metadata ─────────────────────────────────────────
  set document(title: metadata.title, author: metadata.author, description: metadata.description, date: metadata.date)

  // ── Text & element styles ─────────────────────────────────
  set text(font: _font-serif, size: 11pt)
  show math.equation: set text(font: "STIX Two Math") // cspell:disable-line

  // hardcodes ×0.8 scaling for raw blocks; pre-multiply to get net ×0.85.
  show raw: it => text-tt(size: 1em / 0.8, it)
  show heading: it => text(font: _font-sans, it)
  show link: it => {
    let is-bare-url = (it.body.has("text") and (it.body.text.starts-with("http") or it.body.text.starts-with("mailto")))
    if is-bare-url { text-tt(fill: c.blue, it) } else { text(fill: c.blue, it) }
  }
  show math.equation.where(block: true): pad.with(left: 1cm)
  show math.equation.where(block: true): set align(left)
  set enum(
    indent: dim.left-margin - dim.label-sep - dim.label-width,
    body-indent: dim.label-sep,
    numbering: n => box(width: dim.label-width, align(right, text([#n.]))),
  )
  set list(
    indent: dim.left-margin - dim.label-sep - dim.label-width,
    body-indent: dim.label-sep,
    marker: ([•], [‣], [–]).map(n => box(width: dim.label-width, align(
      right,
      text([#n]),
    ))),
  )
  show list: it => {
    set par(first-line-indent: 1em, hanging-indent: 1em)
    it
  }
  show enum: it => {
    set par(first-line-indent: 1em, hanging-indent: 1em)
    it
  }

  set footnote(numbering: it => text-sf([\##it]))
  show footnote: set super(size: 8pt)
  show footnote.entry: set super(size: 8pt)

  // Level-1 headings are reserved for #chapter: invisible in body, visible in TOC.
  show heading.where(level: 1): it => none
  show heading.where(level: 2): set block(above: 30em / 18, below: 13em / 18)
  show heading.where(level: 3): set block(above: 20em / 14, below: 13em / 14)
  show heading.where(level: 4): set block(above: 20em / 11, below: 13em / 11)
  show heading.where(level: 2): set text(size: 18pt)
  show heading.where(level: 3): set text(size: 14pt)
  show heading.where(level: 4): set text(size: 11pt)
  set heading(offset: 1) // = → section (depth 2), == → subsection (depth 3), …
  set par(
    justify: true,
    first-line-indent: dim.indent,
    leading: 0.65em, // default
    justification-limits: (
      spacing: (min: 100% * 2 / 3, max: 150%), // default
      tracking: (min: -0.01em, max: 0.02em),
    ),
  )

  // ── Page layout ──────────────────────────────────────────
  set page(
    paper: "a4",
    margin: (left: 25mm, right: 25mm, top: 30mm, bottom: 30mm),
    header-ascent: 4mm,
    header: context {
      if _page-style.at(here()) == none { return }
      let header-dictionary = (
        "number": str(counter(page).get().first()),
        "total": str(counter(page).final().first()),
        "date": metadata.date.display("[day]-[month repr:short]-[year] [hour]:[minute]:[second]"), // cspell: disable-line
      )
      let header-content = _page-style
        .at(here())
        .map(
          it => {
            if it == none {} else {
              let value = it.at(0)
              let output = if value == "@chapter-name" {
                current-chapter.at(here()).at(2)
              } else {
                value.replace(regex("@(date|number|total)"), it => header-dictionary.at(it.captures.at(0)))
              }
              it.at(1)(output)
            }
          },
        )
      let left-content = header-content
      grid(
        columns: (2mm, 1fr, auto, 2mm),
        none,
        align(bottom, header-content.at(0)),
        align(bottom, header-content.at(1) + h(6mm) + header-content.at(2)),
        none,
      )
      v(-3.3mm)
      line(length: 100%, stroke: 0.7mm + c.light-gray)
    },
  )
  body
}
