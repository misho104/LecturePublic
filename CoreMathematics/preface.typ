#import "misho-text.typ": c-blue, c-dim-gray, c-gray, c-light-gray, default-metadata, set-page-style, text-sf, text-tt

#let preface(message: "", custom-metadata) = {
  let metadata = default-metadata + custom-metadata
  let _tp-rule(color: c-blue, thickness: 0.5pt) = line(
    length: 100%,
    stroke: thickness + color,
  )
  let revision = if (metadata.at("revision", default: "") != "") {
    text-sf(
      size: 14pt,
      fill: c-gray,
      metadata.revision + h(2mm) + sym.dash + h(2mm) + metadata.date.display("[month repr:long] [day], [year]"),
    )
  } else {
    metadata.date.display("[month repr:long] [day], [year]")
  }

  // vertical bar
  place(top + left, dx: -25mm, dy: -30mm, rect(width: 12mm, height: 297mm, fill: c-blue.lighten(20%), stroke: none))
  // top spacer
  v(28mm)
  // title block
  pad(left: 10mm, right: 0mm, {
    _tp-rule(color: c-blue, thickness: 1.2pt)
    v(40mm)
    _tp-rule(color: c-blue, thickness: 0.5pt)
    place(
      top + left,
      dx: 0mm,
      dy: if metadata.subtitle == "" { 19mm } else { 12mm },
      text(size: 38pt, weight: "bold", fill: black, metadata.title),
    )
    if metadata.subtitle != [] {
      place(top + left, dx: 5mm, dy: 30mm, text-sf(size: 14pt, fill: c-gray, style: "italic", metadata.subtitle))
    }
  })
  // author block
  v(8mm)
  pad(left: 10mm, {
    grid(
      columns: (1fr, auto),
      row-gutter: 6mm,
      text-sf(size: 20pt, weight: "bold", metadata.author), [],
      revision, [],
    )
  })
  // Abstract
  v(1fr)
  if message != [] {
    pad(left: 10mm, right: 10mm, {
      _tp-rule(color: c-light-gray, thickness: 0.4pt)
      v(5mm)
      text(
        size: 11pt,
        fill: c-gray,
        style: "italic",
        message,
      )
      v(5mm)
      _tp-rule(color: c-light-gray, thickness: 0.4pt)
    })
  }
  // Restore normal page style on the next page
  set-page-style("normal")
  pagebreak()

  [
    = Preface

    == Second level

    === Third level

  ]

  place(bottom + left, dx: 1.3mm, dy: 2.3mm, float: true, text-sf(size: 9pt, fill: c-gray)[
    #grid(
      columns: (23.7mm, auto),
      image("by-nc.pdf", width: 22mm),
      text(baseline: -.7mm, top-edge: 2.7mm)[This document is licensed under
        #link(
          "https://creativecommons.org/licenses/by-nc/4.0/",
        )[the Creative Commons CC--BY--NC 4.0 International Public License.]\
        You may use this document only if you do in compliance with the license.\
      ],
    )
    Visit https://github.com/misho104/LecturePublic for further information, updates, and to report issues.
  ])
}
