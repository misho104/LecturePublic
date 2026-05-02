#import "@preview/cetz:0.3.4": canvas, draw
#import "@preview/meander:0.4.2"


#let x = figure(
  canvas(length: 1cm, {
    import draw: *
    let f = x => calc.pow(x, 4) / 50 + 0.5
    let pts = range(1, 14).map(x => ((x - 2) / 3)).map(x => (x, f(x)))
    let p = (2, f(2))
    let q = (3.5, f(3.5))
    line((-0.5, 0), (5.0, 0), mark: (end: "straight"))
    line((0, -0.8), (0, 4.5), mark: (end: "straight"))

    set-style(stroke: (paint: green, thickness: 1pt))
    line(..(1.2, 4).map(x => (x, 0.82 + (1.7875 * (x - 2)))))
    line(..(0.9, 4.8).map(x => (x, 0.82 + (1.3 * (x - 2)))), stroke: (dash: "dotted"))
    line(..(0.3, 4.9).map(x => (x, 0.82 + (0.9 * (x - 2)))), stroke: (dash: "dotted"))
    line(..(-0.5, 5).map(x => (x, 0.82 + (0.64 * (x - 2)))), stroke: (paint: black, dash: "densely-dashed"))
    set-style(stroke: (paint: black, thickness: 1.5pt, dash: none))
    catmull(..pts, tension: 0.5)
    //  line((1.0, 0.0), (4.3, 2.64), stroke: (paint: blue, thickness: 1pt))
    // content((4.4, 2.64), text(fill: blue)[tangent], anchor: "west")

    // Dotted guide lines
    set-style(stroke: (paint: luma(30%), dash: "dashed", thickness: 0.6pt))
    line((p.at(0), 0), p)
    line((q.at(0), 0), q)
    line(p, (q.at(0), p.at(1)))
    line((0, p.at(1)), p)
    line((0, q.at(1)), q)
    content((-0.1, p.at(1)), $f(x)$, anchor: "east")
    content((-0.1, q.at(1)), $f(x+ Delta x)$, anchor: "east")
    // Points P and Q
    set-style(stroke: none)
    circle(p, radius: 0.1, fill: black, name: "P")
    circle(q, radius: 0.1, fill: black, name: "Q")

    // Axis tick labels
    content((p.at(0), -0.18), $x$, anchor: "north")
    content((q.at(0), -0.18), $x+Delta x$, anchor: "north")

    // Leg labels
    //    content((2.5, 0.65), $Delta x$, anchor: "north")
    //  content((3.18, 1.3), $Delta f = f'(x) Delta x + dots$, anchor: "west")
  }),
)
#meander.reflow({
  meander.placed(right, dy: -3mm, boundary: meander.contour.margin(x: 8mm, y: 5mm), x)
  meander.container()
  meander.content[
    See the figure to the right.
    The two points $(x, f(x))$ and $(x+Delta x, f(x+Delta x))$ are shown, and the green line connects them.
    The slope of the green line is given by
    $(f(x+Delta x)-f(x))/((x+Delta x)-x)$
    Now, imagine we take $Delta x$ smaller and smaller. The slope becomes milder, and eventually, at the limit of $Delta x -> 0$, the slope approaches the "slope" at the point $x$, and we obtain the black dashed line, which is the tangent line of $f$ at $x$.
  ]
})

In short: *the derivative $f'(x)$ is the slope of the tangent line to the graph of $f$ at the point $x$.*

