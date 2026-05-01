#import "misho-text.typ": c, default-metadata, set-page-style, text-sf, text-tt

#let title(custom-metadata, message) = {
  let metadata = default-metadata + custom-metadata
  let _tp-rule(color: c.blue, thickness: 0.5pt) = line(
    length: 100%,
    stroke: thickness + color,
  )
  let revision = if (metadata.at("revision", default: "") != "") {
    text-sf(
      size: 14pt,
      fill: c.gray,
      metadata.revision + h(2mm) + sym.dash + h(2mm) + metadata.date.display("[month repr:long] [day], [year]"),
    )
  } else {
    metadata.date.display("[month repr:long] [day], [year]")
  }

  // vertical bar
  place(top + left, dx: -25mm, dy: -30mm, rect(width: 12mm, height: 297mm, fill: c.blue.lighten(20%), stroke: none))
  // top spacer
  v(28mm)
  // title block
  pad(left: 10mm, right: 0mm, {
    _tp-rule(color: c.blue, thickness: 1.2pt)
    v(40mm)
    _tp-rule(color: c.blue, thickness: 0.5pt)
    place(
      top + left,
      dx: 0mm,
      dy: if metadata.subtitle == "" { 19mm } else { 12mm },
      text(size: 38pt, weight: "bold", fill: black, metadata.title),
    )
    if metadata.subtitle != [] {
      place(top + left, dx: 5mm, dy: 30mm, text-sf(size: 14pt, fill: c.gray, style: "italic", metadata.subtitle))
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
  pad(left: 10mm, right: 10mm, {
    _tp-rule(color: c.light-gray, thickness: 0.4pt)
    text(
      size: 10pt,
      fill: c.gray,
      style: "italic",
      message,
    )
    _tp-rule(color: c.light-gray, thickness: 0.4pt)
  })
  // Restore normal page style on the next page
  set-page-style("normal")
  pagebreak()
}

