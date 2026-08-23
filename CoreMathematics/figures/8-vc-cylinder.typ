#import "@preview/cetz:0.5.2": canvas, draw  // cspell: disable-line


#let draw-cylinder(p, n, r, z0, z1) = {
  let panels = range(n).map(i => {
    let t0 = i / n * 2 * calc.pi * 1rad
    let t1 = (i + 1) / n * 2 * calc.pi * 1rad
    let depth = calc.cos((t0 + t1) / 2) + calc.sin((t0 + t1) / 2)
    (i, depth, t0, t1)
  })
  for panel in panels.sorted(key: k => k.at(0)) {
    // from farther panel
    let (i, _, t0, t1) = panel
    let a = p(r * calc.cos(t0), r * calc.sin(t0), z0)
    let b = p(r * calc.cos(t1), r * calc.sin(t1), z0)
    let c = p(r * calc.cos(t1), r * calc.sin(t1), z1)
    let d = p(r * calc.cos(t0), r * calc.sin(t0), z1)
    draw.line(a, b, c, d, close: true, fill: blue.transparentize(80%), stroke: none)
    draw.line(a, b, stroke: blue.transparentize(40%))
    draw.line(c, d, stroke: blue.transparentize(40%))
    if calc.rem(i, 2) == 0 {
      draw.line(a, d, stroke: blue.transparentize(80%))
    }
  }
}

#let proj(x, y, z, elev: 20deg, azim: -120deg) = {
  let xr = x * calc.cos(azim) - y * calc.sin(azim)
  let yr = x * calc.sin(azim) + y * calc.cos(azim)
  let u = xr
  let v = yr * calc.sin(elev) + z * calc.cos(elev)
  (u, v)
}

#let mid-point(a, b) = (a.zip(b).map(i => (i.at(0) + i.at(1)) / 2))

#let cylinder-fig = canvas(length: 2.5cm, {
  import draw: *
  let p = proj.with(elev: 17deg, azim: -110deg)

  draw-cylinder(p, 40, 1, 0, 1.3)

  let O = p(0, 0, 0)
  let Px = p(2, 0, 0)
  let Py = p(0, 1.5, 0)
  let Pz = p(0, 0, 2)

  let P = p(calc.cos(1.1), calc.sin(1.1), 1.3)
  let Pp = p(calc.cos(1.1), calc.sin(1.1), 0) // projection

  line(p(-1.3, 0, 0), Px, mark: (end: ">", fill: black), stroke: black)
  line(p(0, -1.2, 0), Py, mark: (end: ">", fill: black), stroke: black)
  line(p(0, 0, -.4), Pz, mark: (end: ">", fill: black), stroke: black)

  content(Px, $x$, anchor: "east", padding: 4pt)
  content(Py, $y$, anchor: "west", padding: 4pt)
  content(Pz, $z$, anchor: "south", padding: 4pt)

  line(O, Pp, stroke: (paint: blue, dash: "dashed"))

  line(p(0, 0, 1.3), P, stroke: (paint: blue, dash: "dashed"))
  line(Pp, P, stroke: (paint: blue, dash: "dashed"))

  let r_mid = proj(0.75, 0.6, 0)
  content(r_mid, text(fill: blue)[$theta$], anchor: "north", padding: 3pt)

  let arc-pts = range(0, 12, step: 1).map(t => p(calc.cos(t / 10), calc.sin(t / 10), 0))
  for i in range(arc-pts.len() - 1) {
    line(arc-pts.at(i), arc-pts.at(i + 1), stroke: blue + 3pt, mark: if i == arc-pts.len() - 2 { (end: ">") })
  }

  circle(P, radius: 0.05, fill: blue, stroke: none)
  circle(Pp, radius: 0.05, fill: gray, stroke: none)
  content(P, $P$, anchor: "south", padding: 4pt)
  content(p(0, 0, 1.3), text(fill: blue)[$zeta$], anchor: "east", padding: 4pt)
  content(mid-point(p(0, 0, 1.3), P), text(fill: blue)[$r$], anchor: "south", padding: 4pt)
})
