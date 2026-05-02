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

#let no-num(content) = { math.equation(block: true, numbering: none, content) }

// ── Helpers ─────────────────────────────────────────────────

#let _box(
  indent: false,
  accent: white,
  above: auto,
  below: auto,
  stroke: (:), // left, right, top, bottom, middle
  inset: (:),
  call-out: true, // to change edge "bounds" and par accordingly
  head-box: (:), // cannot have stroke and inset
  main-box: (:), // cannot have stroke and inset
  icon: none,
  label: "Box",
  body,
) = {
  let fill = if accent == none { none } else { accent.lighten(80%) }
  let _s(key) = stroke.at(key, default: none)
  let inset = (left: 4mm, right: 4mm, top: 0.6em, bottom: 0.6em, middle-above: 1mm, middle-below: 2mm) + inset
  let _i(key) = inset.at(key, default: 0mm)
  set text(top-edge: "bounds", bottom-edge: "bounds") if call-out
  set par(leading: 0.43em) if call-out
  (it => if indent { pad(left: dim.shift, it) } else { it })[
    #if head-box != none {
      block(
        fill: fill,
        width: 100%,
        sticky: true,
        breakable: false,
        above: above,
        below: 0mm,
        inset: (left: _i("left"), right: _i("right"), top: _i("top"), bottom: _i("middle-above")),
        stroke: (left: _s("left"), right: _s("right"), top: _s("top")),
        // if icon box[#icon]
        ..head-box,
      )[ #if icon == none {
        label
      } else {
        box(width: 4em, icon) + label
      }]
    }
    #block(
      fill: fill,
      width: 100%,
      sticky: true,
      breakable: true,
      below: 0mm,
      inset: (
        left: _i("left"),
        right: _i("right"),
        top: _i(if head-box == none { "top" } else { "middle-below" }),
        bottom: _i("bottom"),
      ),
      stroke: (left: _s("left"), right: _s("right"), top: { _s(if head-box == none { "top" } else { "middle" }) }),
      ..main-box,
      body,
    )
    #block(
      fill: blue,
      width: 100%,
      below: below,
      breakable: false,
      stroke: (bottom: _s("bottom")),
    )[]
  ]
}

#let remark(..args, body) = {
  _box(indent: true, accent: c.gray, head-box: none)[
    #text-sf(weight: "bold", size: 11pt, "Remark: ") #body
  ]
}
#let be-careful(..args, body) = {
  _box(indent: true, accent: c.alt-a.desaturate(50%), head-box: none, stroke: (left: 2mm + c.alt-a))[
    #text-sf(weight: "bold", size: 11pt, "Be careful: ") #body
  ]
}
#let fail-safe(..args, body) = {
  _box(indent: true, accent: c.gray, head-box: none)[
    #text(size: 9pt)[#text-sf(weight: "bold", "Fail safe note: ") #body]
  ]
}

#let advanced-note(..args, body) = {
  _box(indent: true, accent: c.light-purple, head-box: none)[
    #text-sf(weight: "bold", true-size: 9pt, "Advanced note: ") #text(size: 9pt)[#body]
  ]
}

#let theorem(title: none, body) = [
  #let border = 1pt + c.blue
  #counter("env").step()
  #_box(
    accent: c.blue.lighten(40%),
    call-out: false,
    stroke: (top: border, bottom: border),
    inset: (top: 0.4em, middle-above: 0.4em, middle-below: 1em),
    head-box: (fill: c.blue),
    label: text-sf(fill: white, size: 11pt, weight: "bold")[
      #h(-.5em)
      Theorem #context [#current-chapter.get().at(0).#counter("env").display()]
      #if title != none [ #h(1em) (#title) ]
    ],
  )[#body]
]

#let example(title: none, body) = [
  #let border = 1pt + c.green
  #counter("env").step()
  #_box(
    call-out: false,
    stroke: (top: border, bottom: border, left: border, right: border),
    inset: (top: 0.4em, middle-above: 0.4em, middle-below: 1em),
    label: text-sf(fill: c.green, size: 11pt, weight: "bold")[
      Example #context [#current-chapter.get().at(0).#counter("env").display()]
      #if title != none [ #h(1em) (#title) ]
    ],
  )[#body]
]
#let solution(title: none, body) = [
  #let border = 1pt + c.green
  #_box(
    call-out: false,
    stroke: (top: border, bottom: border, left: border, right: border),
    inset: (top: 0.4em, middle-above: 0.4em, middle-below: 1em),
    above: 0mm,
    label: text-sf(fill: c.green, size: 11pt, weight: "bold")[
      Solution
      #if title != none [ #h(1em) (#title) ]
    ],
  )[#body]
]


// ── State flags (one per container type) ────────────────────
#let _enum-depth = state("_enum-depth", 0)

#let levels = (
  "4": JA(size: 9pt, "★"),
  "3": "***",
  "2": "**",
  "1": "*",
  "9": box(height: 6pt, move(dy: -5pt, "💪")), //
)

#let num-a = n => text-sf(strong([(#n)]))
#let num-b = n => text-sf(strong([#n]))
#let num-c = n => text-sf(strong([#n]))

)
#let _label-styles = (
  "problem": (pf, cn) => align(right, pf + text-sf[*#cn("1.1").*]),
  "quiz": (pf, cn) => align(right, pf + text-sf[*#cn(((..n) => str(n.pos().at(1)))).*]),
  "(1)": (pf, cn) => align(right, pf + text-sf[*(#cn("1"))*]),
)

#let _extract-levels(items) = array.zip(..items.map(it => if it.body.has("children")
  and it.body.children.first().func() == raw
  and (it.body.children.first().text.contains(regex("^\d+$"))) {
  (levels.at(it.body.children.first().text, default: "?"), it.body.children.slice(1).join())
} else {
  ("", it.body)
}))

#let _problem-box(t, body) = {
  let accent = c.light-orange
  _box(
    indent: t.indent,
    accent: accent,
    call-out: false,
    stroke: t.stroke,
    inset: (top: 2mm, middle-above: 1mm, middle-below: 3mm, bottom: 4mm),
    label: text-sf(
      fill: accent.saturate(50%),
      weight: "black",
      size: 17pt,
      tracking: 3pt,
      t.label,
    ),
  )[
    #show enum: it => {
      _enum-depth.update(d => d + 1)
      let depth = _enum-depth.get()
      if depth == 0 {
        let c = _extract-levels(it.children)
        _enum-horizontal(
          label-start: counter(t.counter-name),
          label-width: dim.label-width + 3mm,
          label-sep: dim.label-sep,
          v-sep: 2em,
          label-style: _label-styles.at(t.counter-name),
          prefixes: c.at(0),
          inset: (left: -20mm),
          ..c.at(1),
        )
      } else if depth > 0 {
        _enum-horizontal(
          label-width: 1.5em,
          label-start: 0,
          label-style: _label-styles.at("(1)"),
          ..it.children.map(it => it.body),
        )
      }
      _enum-depth.update(d => d - 1)
    }
    #body
  ]
}

#let quizzes(..args, body) = _problem-box(
  (
    stroke: (left: 2mm + c.light-orange, middle: .5pt + c.light-orange),
    label: "Quiz",
    indent: true,
    counter-name: "quiz",
  ),
  body,
)
#let problems(..args, body) = _problem-box(
  (
    stroke: (
      left: 2pt + c.light-orange,
      right: 2pt + c.light-orange,
      top: 2pt + c.light-orange,
      bottom: 2pt + c.light-orange,
      middle: 0.5pt + c.light-orange,
    ),
    label: "Problems",
    indent: false,
    counter-name: "problem",
  ),
  body,
)


#import "@preview/in-dexter:0.7.2": index
#let keyword(..args, key: none, content) = [
  #index(..args, if key == none { content } else { key }) #EMPH(content)]

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
  show link: it => underline(offset: .25em, it)
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
    set par(first-line-indent: 1em, hanging-indent: 0em)
    it
  }
  show enum: it => {
    set par(first-line-indent: 1em, hanging-indent: 0em)
    it
  }

  set footnote(numbering: it => text-sf([\##it]))
  show footnote: set super(size: 8pt)
  show footnote.entry: set super(size: 8pt)

  // Level-1 headings are reserved for #chapter: invisible in body, visible in TOC.
  show heading.where(level: 1): it => none
  show heading.where(level: 2): set block(above: 30em / 16, below: 13em / 16)
  show heading.where(level: 3): set block(above: 20em / 13, below: 13em / 13)
  show heading.where(level: 4): set block(above: 20em / 11, below: 13em / 11)
  show heading.where(level: 2): set text(size: 16pt)
  show heading.where(level: 3): set text(size: 13pt)
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
