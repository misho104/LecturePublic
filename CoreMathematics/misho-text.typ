// ============================================================
// misho-note.typ — Typst document class (port of MishoNote.cls)
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
#let _font-serif = "STIX Two Text"  // main body font
#let _font-sans = "Roboto"         // sans-serif (scaled ×0.91)
#let _font-mono = "Roboto Mono"    // monospace  (scaled ×0.85)

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

// ── Colors ────────────────────────────────────────────────────
#let c-gray = luma(50%)   // \gray
#let c-light-gray = luma(80%)   // \lightgray
#let c-dim-gray = luma(90%)   // \dimgray

#let c-blue = rgb("#0e51c9")  // pBlue
#let c-pink = rgb("#ff45a0")  // pPink
#let c-green = rgb("#348d1b")  // pGreen
#let c-light-orange = rgb("#ffd69d")  // pLightOrange
#let c-light-purple = rgb("#aa78d6")  // pLightPurple
#let c-light-green = rgb("#00ffd0")  // pLightGreen
#let c-alt-a = rgb(100%, 20%, 0%)  // AltDefA — red-orange (\RED, \C)
#let c-alt-b = rgb(15%, 50%, 70%)  // AltDefB — steel blue (\C*), use sparingly

// Color-emphasis commands (mirrors \GRAY, \BLUE, \PINK, \GREEN, \RED)
#let GRAY(body) = text(fill: c-gray, body)
#let BLUE(body) = text(fill: c-blue, body)
#let PINK(body) = text(fill: c-pink, body)
#let GREEN(body) = text(fill: c-green, body)
#let RED(body) = text(fill: c-alt-a, body)

// ── Page-style state ──────────────────────────────────────────
// The gray box visually covers the header rule on non-normal pages.
#let head-title-style(body) = text-sf(fill: c-light-gray, size: 9pt, body)
#let head-date-style(body) = text-tt(fill: c-dim-gray, size: 9pt, body)
#let head-pagenum-style(body) = text-sf(weight: "bold", size: 12pt, body)

#let _page-style-default = (
  // left, right, page-num
  "title": none,
  "chapter": (
    none,
    ("@date", it => text-tt(fill: c-dim-gray, size: 9pt, it)),
    ("@pagenum/@total", it => text-sf(weight: "bold", size: 12pt, it)),
  ),
  "normal": (
    ("@chapter-name", it => text-sf(fill: c-light-gray, size: 9pt, it)),
    ("@date", it => text-tt(fill: c-dim-gray, size: 9pt, it)),
    ("@pagenum/@total", it => text-sf(weight: "bold", size: 12pt, it)),
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
  place(top + left, dx: 0mm, dy: -4.5mm, rect(width: 160mm, height: 32mm, fill: c-dim-gray, stroke: none))
  place(top + left, dx: 2mm, dy: -2.5mm, rect(width: 156mm, height: 10mm, fill: none, stroke: 0.4pt + black))
  place(
    top + left,
    dx: 6.3mm,
    dy: -2mm,
    box(fill: c-dim-gray, outset: 1mm, inset: (right: 1mm), text(size: 16pt, "Chapter "))
      + box(fill: c-dim-gray, outset: 1mm, text(size: 40pt, number)),
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
}

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


  // Typst hardcodes ×0.8 scaling for raw blocks; pre-multiply to get net ×0.85.
  show raw: it => text-tt(size: 1em / 0.8, it)
  show heading: it => text-sf(it)
  show link: it => {
    let is-bare-url = (it.body.has("text") and (it.body.text.starts-with("http") or it.body.text.starts-with("mailto")))
    if is-bare-url { text-tt(fill: c-blue, it) } else { text(fill: c-blue, it) }
  }

  // Level-1 headings are reserved for #chapter: invisible in body, visible in TOC.
  show heading.where(level: 1): it => none
  show heading.where(level: 2): set block(above: 1.29em, below: 0.54em)
  show heading.where(level: 3): set block(above: 1.2em, below: 0.63em)
  show heading.where(level: 4): set block(above: 1.44em, below: 0.75em)
  show heading.where(level: 2): set text(size: 15.4pt)
  show heading.where(level: 3): set text(size: 13.2pt)
  show heading.where(level: 4): set text(size: 11pt)
  set heading(offset: 1) // = → section (depth 2), == → subsection (depth 3), …

  // ── Page layout ──────────────────────────────────────────
  set page(
    paper: "a4",
    margin: (left: 25mm, right: 25mm, top: 30mm, bottom: 30mm),
    header-ascent: 4mm,
    header: context {
      if _page-style.at(here()) == none { return }
      let header-dictionary = (
        "pagenum": str(counter(page).get().first()),
        "total": str(counter(page).final().first()),
        "date": metadata.date.display("[day]-[month repr:short]-[year] [hour]:[minute]:[second]"),
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
                value.replace(regex("@(date|pagenum|total)"), it => header-dictionary.at(it.captures.at(0)))
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
      line(length: 100%, stroke: 0.7mm + c-light-gray)
    },
  )
  body
}
