#import "@preview/cetz:0.5.2": canvas, draw  // cspell: disable-line
#import "../misho-text.typ": c

#let draw-vector-field(f, length: 2cm, s: 1.0) = align(center, canvas(length: length, {
  let x = range(-6, 6).map(i => (i + 0.5) / 4.2 * s)
  let y = range(-6, 6).map(i => (i + 0.5) / 4.2 * s)
  draw.line((-1.45 * s, 0), (1.65 * s, 0), mark: (end: "straight"), stroke: 1pt + black.transparentize(30%))
  draw.line((0, -1.45 * s), (0, 1.65 * s), mark: (end: "straight"), stroke: 1pt + black.transparentize(30%))
  draw.content((1.55 * s, 0.25 * s), text(fill: black.transparentize(30%))[$x$])
  draw.content((0.25 * s, 1.55 * s), text(fill: black.transparentize(30%))[$y$])
  for i in x {
    for j in y {
      let (vx, vy) = f(i, j)
      let norm = calc.sqrt(vx * vx + vy * vy)
      draw.line((i - vx / 15, j - vy / 15), (i + vx / 15, j + vy / 15), stroke: blue, mark: (
        end: ">",
        fill: blue,
        scale: norm * 0.3 * s,
      ))
    }
  }
}))

#let draw-vector-field-eig(length: 2cm, s: 1.0) = align(center, canvas(length: length, {
  let x = range(-5, 5).map(i => (i + 0.5) / 3.6 * s)
  let y = range(-5, 5).map(i => (i + 0.5) / 3.6 * s)
  draw.line((-1.6 * s, 0), (1.65 * s, 0), mark: (end: ">", fill: black), stroke: 1pt + black.transparentize(30%))
  draw.line((0, -1.6 * s), (0, 1.65 * s), mark: (end: ">", fill: black), stroke: 1pt + black.transparentize(30%))
  draw.content((1.6 * s, 0.15 * s), text(fill: black.transparentize(30%))[$x$])
  draw.content((0.12 * s, 1.6 * s), text(fill: black.transparentize(30%))[$y$])
  for i in x {
    for j in y {
      let r = calc.sqrt(i * i + j * j)
      draw.line((i, j), (i + i / r / 4.5, j + j / r / 4.5), stroke: black, mark: (
        end: "straight",
        scale: 0.8 * s,
      ))
      draw.line((i, j), (i - j / r / 4.5, j + i / r / 4.5), stroke: c.alt-a, mark: (
        end: "straight",
        scale: 0.8 * s,
      ))
      draw.circle((i, j), radius: 0.04, fill: c.gray, stroke: none)
    }
  }
}))
