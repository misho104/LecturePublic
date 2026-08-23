#import "misho-text.typ": *
#import "physica.typ": dv, pdv  // cspell: disable-line
#import "5-vector.typ": dm, va, vc, vcu, vip, vxp
#import "6-complex.typ": Arg
#import "2-units.typ": writing, writings
#import "@preview/cetz:0.5.2": canvas, draw  // cspell: disable-line
// cspell: ignore Levi Civita

// Chapter-local macros
#let vt(a, b) = $vc(#a) times vc(#b)$
#let eps = $epsilon$ // Levi-Civita symbol shorthand
#let nab = $vc(nabla)$ // cspell: disable-line
#let grad = math.op("grad")
#let div = math.op("div")
#let curl = math.op("curl")
#let px = $partial_x$
#let py = $partial_y$
#let pz = $partial_z$
#let nm = $mat(px; py; pz)$


= Gauss's Divergence Theorem <sec:vc-gauss>

So far, $nabla dot vc(F)$ and $nabla times vc(F)$ are *local* quantities: they describe behaviour at a single point. Two theorems relate these local quantities to *global*, integrated quantities over a surface or volume. The first is Gauss's theorem.

Let $V subset RR^3$ be a solid region (a volume) and let $S$ be its boundary: a #keyword[closed surface] (one with no edge, like a sphere or the surface of a potato, as opposed to an open sheet like a disc). At each point of $S$, let $vcu(n)$ be the #keyword[outward unit normal] vector, and write $d vc(S) := vcu(n) thin d S$ for the vector surface element, where $d S$ is an infinitesimal patch of area on $S$.

#theorem(title: "Gauss's divergence theorem")[
  Let $vc(F)$ be a differentiable vector field on (an open region containing) $V union S$. Then
  $
    integral.surf_S vc(F) dot d vc(S) = integral.triple_V (nabla dot vc(F)) thin d V.
  $<eq:vc-gauss>
]<thm:gauss>

In words: the total #keyword[flux] of $vc(F)$ out through the closed surface $S$ (left side) equals the total "amount of source" of $vc(F)$ produced inside the volume $V$ (right side). If $vc(F)$ is a fluid velocity field, the left side is the net volume of fluid leaving $V$ per unit time; the right side adds up, over every point inside $V$, how much fluid is being created or destroyed there. The two must agree, since fluid cannot vanish or appear inside $V$ without eventually crossing the boundary $S$.

#align(center)[
  #canvas({
    let n = 80
    let blob_pts = range(0, n).map(i => {
      let t = i * 2 * calc.pi / n
      let rx = 1.7 + 0.15 * calc.cos(3 * t)
      let ry = 1.4 + 0.10 * calc.cos(2 * t + 0.5)
      (rx * calc.cos(t), ry * calc.sin(t))
    })
    draw.line(..blob_pts, close: true, stroke: (paint: c.gray, thickness: 1.0pt), fill: luma(245))
    draw.content((1.9, 0.5), text(size: 9pt, fill: c.gray)[$S$])
    draw.content((-0.4, 0.2), text(size: 9pt, fill: luma(100))[$V$])
    for deg in (0, 60, 120, 180, 240, 300) {
      let a = deg * calc.pi / 180
      let rx = 1.7 + 0.15 * calc.cos(3 * a)
      let ry = 1.4 + 0.10 * calc.cos(2 * a + 0.5)
      let (sx, sy) = (rx * calc.cos(a), ry * calc.sin(a))
      let nlen = 0.5
      draw.line(
        (sx, sy),
        (sx + nlen * calc.cos(a), sy + nlen * calc.sin(a)),
        mark: (end: "stealth", fill: c.blue, stroke: c.blue + 1.1pt, transform-shape: false),
        stroke: c.blue + 1.1pt,
      )
    }
    draw.content((0.1, 0.7), text(size: 8.5pt, fill: c.blue)[$nabla dot vc(F) > 0$])
    draw.content((0.0, -2.0), text(size: 7.5pt, fill: luma(80))[total flux out through $S$ = total source inside $V$])
  })
]

#advanced-note[
  The proof, in full, chops $V$ into a grid of tiny cubes, applies the definition of divergence to each cube (the flux out of a tiny cube of side $d x$ is, to leading order, $(nabla dot vc(F)) thin d x^3$), and observes that the flux through the internal faces shared by two neighbouring cubes cancels (what flows out of one cube flows into its neighbour), leaving only the flux through the faces on the outer boundary $S$. We do not carry out this limiting argument in detail here; it belongs to a course in analysis, not this drill book.
]

#example(title: "Gauss's theorem for the position field on a sphere")[
  Verify @eq:vc-gauss for $vc(F) = vc(r)$ and $V$ the solid ball of radius $R$ centred at the origin, with $S$ the sphere of radius $R$.
]
#solution[
  *Right side.* From @eq:vc-div-r, $nabla dot vc(r) = 3$ everywhere, so
  $
    integral.triple_V (nabla dot vc(r)) thin d V = 3 integral.triple_V d V = 3 dot (4/3 pi R^3) = 4 pi R^3.
  $
  *Left side.* On the sphere $S$ of radius $R$, the outward unit normal is $vcu(n) = vc(r)\/R$ (the position vector itself, normalised), and $vc(r) dot vcu(n) = vc(r) dot vc(r)\/R = R^2\/R = R$ (constant on $S$, since every point of $S$ has $va(vc(r)) = R$). So
  $
    integral.surf_S vc(r) dot d vc(S) = integral.surf_S R thin d S = R dot (4 pi R^2) = 4 pi R^3,
  $
  using that the total area of $S$ is $4 pi R^2$. Both sides equal $4 pi R^3$.
]

#example(title: "Gauss's law from Gauss's theorem")[
  In electrostatics, Gauss's law in integral form states that the electric flux through a closed surface $S$ equals the enclosed charge divided by $epsilon_0$:
  $
    integral.surf_S vc(E) dot d vc(S) = Q_"enc" / epsilon_0 = 1/epsilon_0 integral.triple_V rho thin dd V,
  $
  where $rho$ is the charge density. Derive the differential form $nabla dot vc(E) = rho\/epsilon_0$.
]
#solution[
  Apply @eq:vc-gauss to the left side:
  $
    integral.surf_S vc(E) dot d vc(S) = integral.triple_V (nabla dot vc(E)) thin dd V.
  $
  Combining with the integral law,
  $
    integral.triple_V (nabla dot vc(E)) thin dd V = integral.triple_V rho/epsilon_0 thin dd V.
  $
  This must hold for *every* choice of volume $V$, however small. Two functions whose integrals agree over every possible volume must be equal at every point (shrink $V$ to a tiny ball around any point $vc(p)$; the average value of each side over that tiny ball converges to the value at $vc(p)$). Hence $nabla dot vc(E) = rho\/epsilon_0$ at every point.
]

#quizzes[
  + `4` For a vector field with $nabla dot vc(F) = 0$ everywhere inside $V$, what does @eq:vc-gauss say about the total flux out of $S$?
  + `4` Why must the surface $S$ in Gauss's theorem be closed (no edge)? #hint[Try to picture the theorem applied to just half a sphere.]
]

#problems[
  + `4` Use Gauss's theorem to compute $integral.surf_S vc(F) dot d vc(S)$ for $vc(F) = (x,y,z)^TT$ and $S$ the surface of the cube $[0,1]^3$, without parametrising the six faces. #hint[Compute $nabla dot vc(F)$ and integrate over the cube.]
  + `3` Let $vc(F) = (x^3, y^3, z^3)^TT$ and let $V$ be the ball of radius $R$. Compute $integral.triple_V (nabla dot vc(F)) thin dd V$ using spherical coordinates (preview: see @sec:vc-curvilinear) or by symmetry with Cartesian coordinates, and interpret the flux.
  + `2` Explain, using Gauss's theorem, why a source-free vector field ($nabla dot vc(F) = 0$ everywhere) has zero total flux through *any* closed surface, even one shaped like a torus (donut).
]

= Stokes' Theorem <sec:vc-stokes>

Gauss's theorem related a volume integral to an integral over its boundary surface. Stokes' theorem plays the same role one dimension down: it relates a surface integral to an integral over the boundary *curve* of that surface.

Let $S$ be an #keyword[open surface] (one with an edge, e.g. a hemisphere or a disc, unlike the closed surfaces of the previous section), and let $C$ be its boundary curve. Orient $C$ using the #keyword[right-hand rule]: if the fingers of your right hand curl in the direction you traverse $C$, your thumb points in the direction of $d vc(S) = vcu(n) thin dd S$ on $S$.

#theorem(title: "Stokes' theorem")[
  Let $vc(F)$ be a differentiable vector field on (an open region containing) $S union C$. Then
  $
    integral.cont_C vc(F) dot d vc(l) = integral.surf_S (nabla times vc(F)) dot d vc(S),
  $<eq:vc-stokes>
  where $d vc(l)$ is the infinitesimal tangent vector along $C$, pointing in the direction of traversal.
]<thm:stokes>

In words: the total #keyword[circulation] of $vc(F)$ around the boundary curve $C$ (left side) equals the total curl of $vc(F)$ passing through the surface $S$ (right side). If $vc(F)$ is a fluid velocity field, the left side measures how much the fluid tends to rotate along the loop $C$; the right side adds up all the tiny local rotations (measured by the curl) over every point of the surface $S$ that $C$ bounds.

#align(center)[
  #canvas(length: 1cm, {
    let n = 60
    let oval_pts = range(0, n).map(i => {
      let t = i * 2 * calc.pi / n
      (1.4 * calc.cos(t), 0.7 * calc.sin(t))
    })
    draw.line(..oval_pts, close: true, stroke: (paint: c.gray, thickness: 0.8pt), fill: luma(240))
    draw.content((0, 0), text(size: 9pt, fill: luma(100))[$S$])
    draw.line(
      (0.0, 0.0),
      (0.0, 1.05),
      mark: (end: "stealth", fill: c.blue, stroke: c.blue + 1.3pt, transform-shape: false),
      stroke: c.blue + 1.3pt,
    )
    draw.content((0.15, 1.15), anchor: "west", text(fill: c.blue, size: 8.5pt)[$vcu(n)$])
    for (cx, cy) in ((-0.55, 0.0), (0.55, 0.0)) {
      let nr = 0.22
      let arc_pts2 = range(0, 20).map(i => {
        let t = i * 1.7 * calc.pi / 19
        (cx + nr * calc.cos(t), cy + nr * 0.6 * calc.sin(t))
      })
      draw.line(..arc_pts2, stroke: (paint: c.alt-a, thickness: 0.8pt))
      let te = 1.7 * calc.pi
      let tb = 1.65 * calc.pi
      draw.line(
        (cx + nr * calc.cos(tb), cy + nr * 0.6 * calc.sin(tb)),
        (cx + nr * calc.cos(te), cy + nr * 0.6 * calc.sin(te)),
        mark: (end: "stealth", fill: c.alt-a, stroke: c.alt-a + 0.8pt, transform-shape: false),
        stroke: c.alt-a + 0.8pt,
      )
    }
    draw.content((1.35, 0.55), anchor: "west", text(size: 8pt)[$nabla times vc(F)$])
    for k in (0, 15, 30, 45) {
      let t0 = k * 2 * calc.pi / 60
      let t1 = (k + 3) * 2 * calc.pi / 60
      draw.line(
        (1.42 * calc.cos(t0), 0.71 * calc.sin(t0)),
        (1.42 * calc.cos(t1), 0.71 * calc.sin(t1)),
        mark: (end: "stealth", fill: black, stroke: black + 1.1pt, transform-shape: false),
        stroke: black + 1.1pt,
      )
    }
    draw.content((1.52, 0.1), text(size: 8.5pt)[$C$])
    draw.content((0.0, -1.1), text(size: 7.5pt, fill: luma(80))[circulation around $C$ = total curl through $S$])
  })
]

#example(title: "Circulation of a rotation field")[
  Let $vc(F) = (-y,x,0)^TT$ and let $S$ be the disc of radius $R$ in the $x y$-plane centred at the origin, with $C$ its boundary circle traversed counterclockwise (viewed from $+z$). Verify @eq:vc-stokes.
]
#solution[
  *Right side.* From @eq:vc-curl-r, this field has $nabla times vc(F) = (0,0,2)^TT$ (a direct calculation: $pdv(F_y, x)-pdv(F_x, y) = 1-(-1) = 2$, and the other two components vanish). Since $d vc(S) = (0,0,1)^TT thin dd S$ on this disc (outward, i.e. $+z$, matching the right-hand rule for counterclockwise traversal),
  $
    integral.surf_S (nabla times vc(F)) dot d vc(S) = integral.surf_S 2 thin dd S = 2 dot (pi R^2) = 2 pi R^2.
  $
  *Left side.* Parametrise $C$ by $(x,y) = (R cos t, R sin t)$ for $t in [0, 2pi)$, so $d vc(l) = (-R sin t, R cos t, 0)^TT thin dd t$. On $C$, $vc(F) = (-R sin t, R cos t, 0)^TT$, so
  $
    vc(F) dot d vc(l) = R^2 sin^2 t + R^2 cos^2 t = R^2,
  $
  giving
  $
    integral.cont_C vc(F) dot d vc(l) = integral_0^(2pi) R^2 thin dd t = 2 pi R^2.
  $
  Both sides equal $2 pi R^2$.
]

#example(title: "Faraday's law from Stokes' theorem")[
  Faraday's law in integral form states $integral.cont_C vc(E) dot d vc(l) = -dv(Phi_B, t)$, where $Phi_B = integral.surf_S vc(B) dot d vc(S)$ is the magnetic flux through $S$. Use Stokes' theorem to derive the differential form $nabla times vc(E) = -pdv(vc(B), t)$.
]
#solution[
  Applying @eq:vc-stokes to the left side, $integral.cont_C vc(E) dot d vc(l) = integral.surf_S (nabla times vc(E)) dot d vc(S)$. Assuming the surface $S$ is fixed in time (does not move), $dv(Phi_B, t) = integral.surf_S pdv(vc(B), t) dot d vc(S)$. Substituting both into Faraday's law,
  $
    integral.surf_S (nabla times vc(E)) dot d vc(S) = -integral.surf_S pdv(vc(B), t) dot d vc(S).
  $
  As in the Gauss's law derivation, this holds for every choice of surface $S$, so the integrands must be equal at every point: $nabla times vc(E) = -pdv(vc(B), t)$.
]

#theorem(title: "Conservative fields are irrotational")[
  If $nabla times vc(F) = vc(0)$ everywhere on a surface $S$ bounded by a curve $C$, then $integral.cont_C vc(F) dot d vc(l) = 0$. Consequently, for such a field, the line integral $integral_(vc(p)_1)^(vc(p)_2) vc(F) dot d vc(l)$ between two points does not depend on the path chosen (as long as any two paths together bound a surface on which $nabla times vc(F) = vc(0)$); such a field is called #keyword[conservative].
]<thm:conservative>
#proof[
  The first claim is immediate from @eq:vc-stokes: the right side is an integral of $vc(0)$, hence $0$. For the second claim, let $C_1$ and $C_2$ be two paths from $vc(p)_1$ to $vc(p)_2$. The loop that goes along $C_1$ and back along $C_2$ reversed is a closed curve bounding some surface $S$; the circulation around it is $0$ by the first claim, and this circulation equals $integral_(C_1) vc(F) dot d vc(l) - integral_(C_2) vc(F) dot d vc(l)$, so the two path integrals are equal.
]
#remark[
  This is exactly why a conservative force (like gravity or the electrostatic force) has a well-defined potential energy: since $nabla times vc(F) = vc(0)$ for such forces, the work done moving between two points does not depend on the path taken.
]

#quizzes[
  + `4` For the field $vc(F) = (-y,x,0)^TT$ from the worked example, is $vc(F)$ conservative? Why or why not?
  + `4` Sho claims "if $integral.cont_C vc(F) dot d vc(l) = 0$ for one particular closed loop $C$, then $vc(F)$ is conservative." Is Sho right? #hint[Compare to @thm:conservative, which requires the statement for *every* loop, not just one.]
]

#problems[
  + `4` Verify Stokes' theorem for $vc(F) = (0,0,x y)^TT$ and $S$ the unit disc in the $x y$-plane. #hint[Compute $nabla times vc(F)$ first; it may make one side of the calculation trivial.]
  + `3` Show that $vc(F) = (2x y, x^2, 0)^TT$ is conservative by computing its curl, then find a scalar field $f$ with $vc(F) = nabla f$.
  + `2` Explain, using Stokes' theorem, why the circulation of $vc(F) = -y\/(x^2+y^2) thin vc(e)_x + x\/(x^2+y^2) thin vc(e)_y$ around a circle enclosing the origin does not depend on the radius of the circle, even though $nabla times vc(F) = vc(0)$ everywhere except at the origin (where $vc(F)$ is undefined). #hint[The theorem requires $vc(F)$ to be defined and differentiable on all of $S$, including its interior.]
]

= Curvilinear Coordinates: Cylindrical and Spherical <sec:vc-curvilinear>

Cartesian coordinates $(x,y,z)$ are not always the easiest choice. A solenoid (a coil of wire) has an axis of symmetry; a point charge or the hydrogen atom has a centre of symmetry. Writing the fields for these problems in $(x,y,z)$ obscures the symmetry and leads to unnecessarily messy algebra. #keyword[Cylindrical] and #keyword[spherical] coordinates are built to match these symmetries directly.

== Cylindrical Coordinates <sec:vc-cylindrical>

#definition(title: "Cylindrical coordinates")[
  Cylindrical coordinates $(r,phi,z)$ are related to Cartesian coordinates by
  $
    x = r cos phi, quad y = r sin phi, quad z=z,
  $<eq:vc-cyl-def>
  with domain $r >= 0$, $0 <= phi < 2pi$, $z in RR$.
]<def:cylindrical>
Here $r$ is the distance from the $z$-axis (not the distance from the origin---that will be the role of $r$ in spherical coordinates, a different quantity with an unfortunately shared letter) and $phi$ is the angle measured counterclockwise from the positive $x$-axis, viewed from $+z$.

At each point (away from the $z$-axis, where $r=0$ and $phi$ is undefined, since every angle gives the same point), define unit vectors $vcu(e)_r, vcu(e)_phi, vcu(e)_z$ pointing, respectively, in the direction of increasing $r$ (radially outward from the $z$-axis), increasing $phi$ (tangent to the circle of radius $r$, counterclockwise), and increasing $z$ (same as the Cartesian $vcu(e)_z$). In Cartesian components,
$
  vcu(e)_r = (cos phi, sin phi, 0)^TT, quad vcu(e)_phi = (-sin phi, cos phi, 0)^TT, quad vcu(e)_z = (0,0,1)^TT.
$<eq:vc-cyl-basis>
#be-careful[
  Unlike the fixed Cartesian basis $vcu(e)_x,vcu(e)_y,vcu(e)_z$, the cylindrical basis vectors $vcu(e)_r, vcu(e)_phi$ *depend on the point* (through $phi$): they rotate as you move around the $z$-axis. Do not treat $vcu(e)_r$ or $vcu(e)_phi$ as constant vectors when differentiating a field expressed in cylindrical components; this is a common source of sign errors.
]

#align(center)[
  #canvas(length: 1.1cm, {
    let pr = (X, Y, Z) => (X + Y * 0.45, Z - Y * 0.30)
    let axlen = 2.0
    let thin = 0.65pt
    draw.line(
      pr(0, 0, 0),
      pr(axlen, 0, 0),
      mark: (end: "stealth", fill: black, stroke: black + thin, transform-shape: false),
      stroke: black + thin,
    )
    draw.content((pr(axlen, 0, 0).at(0) + 0.18, pr(axlen, 0, 0).at(1)), text(size: 8pt)[$x$])
    draw.line(
      pr(0, 0, 0),
      pr(0, axlen, 0),
      mark: (end: "stealth", fill: black, stroke: black + thin, transform-shape: false),
      stroke: black + thin,
    )
    draw.content((pr(0, axlen, 0).at(0) + 0.18, pr(0, axlen, 0).at(1) - 0.05), text(size: 8pt)[$y$])
    draw.line(
      pr(0, 0, 0),
      pr(0, 0, axlen),
      mark: (end: "stealth", fill: black, stroke: black + thin, transform-shape: false),
      stroke: black + thin,
    )
    draw.content((pr(0, 0, axlen).at(0) + 0.05, pr(0, 0, axlen).at(1) + 0.18), text(size: 8pt)[$z$])
    let r_p = 1.3
    let phi_deg = 55.0
    let z_p = 1.3
    let phi = phi_deg * calc.pi / 180
    let Xp = r_p * calc.cos(phi)
    let Yp = r_p * calc.sin(phi)
    let Zp = z_p
    let sP = pr(Xp, Yp, Zp)
    let sP0 = pr(Xp, Yp, 0)
    let sO = pr(0, 0, 0)
    draw.line(sP0, sP, stroke: (paint: c.gray, thickness: 0.6pt, dash: "dashed"))
    draw.line(sO, sP0, stroke: (paint: c.blue, thickness: 0.9pt))
    let n_arc = 24
    let r_arc = 0.45
    let arc_pts = range(0, n_arc + 1).map(i => {
      let t = i * phi / n_arc
      pr(r_arc * calc.cos(t), r_arc * calc.sin(t), 0)
    })
    draw.line(..arc_pts, stroke: (paint: c.gray, thickness: 0.65pt))
    draw.circle(sP, radius: 0.07, fill: black, stroke: none)
    let mP = pr(Xp * 0.5, Yp * 0.5, 0)
    draw.content((mP.at(0) + 0.05, mP.at(1) - 0.22), text(fill: c.blue, size: 8pt)[$r$])
    let zM = pr(Xp, Yp, z_p * 0.5)
    draw.content((zM.at(0) + 0.18, zM.at(1)), text(fill: c.gray, size: 8pt)[$z$])
    let phiM = pr(r_arc * calc.cos(phi * 0.55), r_arc * calc.sin(phi * 0.55), 0)
    draw.content((phiM.at(0) + 0.08, phiM.at(1) - 0.18), text(fill: c.gray, size: 8pt)[$phi$])
    draw.content((sP.at(0) + 0.18, sP.at(1) + 0.12), text(size: 8.5pt)[$P$])
    let blen = 0.60
    let er_end = pr(Xp + blen * calc.cos(phi), Yp + blen * calc.sin(phi), Zp)
    draw.line(
      sP,
      er_end,
      mark: (end: "stealth", fill: c.blue, stroke: c.blue + 1.2pt, transform-shape: false),
      stroke: c.blue + 1.2pt,
    )
    draw.content((er_end.at(0) + 0.12, er_end.at(1) + 0.05), text(fill: c.blue, size: 8pt)[$vcu(e)_r$])
    let ef_end = pr(Xp + blen * (-calc.sin(phi)), Yp + blen * calc.cos(phi), Zp)
    draw.line(
      sP,
      ef_end,
      mark: (end: "stealth", fill: c.alt-a, stroke: c.alt-a + 1.2pt, transform-shape: false),
      stroke: c.alt-a + 1.2pt,
    )
    draw.content((ef_end.at(0) - 0.05, ef_end.at(1) + 0.16), text(fill: c.alt-a, size: 8pt)[$vcu(e)_phi$])
    let ez_end = pr(Xp, Yp, Zp + blen)
    draw.line(
      sP,
      ez_end,
      mark: (end: "stealth", fill: c.green, stroke: c.green + 1.2pt, transform-shape: false),
      stroke: c.green + 1.2pt,
    )
    draw.content((ez_end.at(0) + 0.14, ez_end.at(1) + 0.05), text(fill: c.green, size: 8pt)[$vcu(e)_z$])
  })
]

The #keyword[scale factors] $h_r = 1$, $h_phi = r$, $h_z = 1$ measure how much physical distance corresponds to a unit change in each coordinate (moving by $d phi$ at radius $r$ covers an arc length $r thin d phi$, hence $h_phi = r$). The volume element is
$
  d V = r thin d r thin d phi thin d z.
$<eq:vc-cyl-volume>
The gradient, divergence, and Laplacian take the form
$
          nabla f & = pdv(f, r) vcu(e)_r + 1/r pdv(f, phi) vcu(e)_phi + pdv(f, z) vcu(e)_z, \
  nabla dot vc(F) & = 1/r pdv((r F_r), r) + 1/r pdv(F_phi, phi) + pdv(F_z, z), \
        nabla^2 f & = 1/r pdv((), r) (r pdv(f, r)) + 1/r^2 pdv(f, phi, 2) + pdv(f, z, 2).
$<eq:vc-cyl-ops>
(The curl in cylindrical coordinates exists too but Sho will spare you the formula here; look it up when a specific problem needs it, and use the Cartesian definition to re-derive it if you must.)

#example(title: "Laplacian of $ln r$ in cylindrical coordinates")[
  For $f = ln r$ (a field on the plane, independent of $phi$ and $z$; $r > 0$), compute $nabla^2 f$ using @eq:vc-cyl-ops.
]
#solution[
  Since $f$ does not depend on $phi$ or $z$, only the first term of the Laplacian survives:
  $
    nabla^2 f = 1/r pdv((), r) (r pdv((ln r), r)) = 1/r pdv((), r) (r dot 1/r) = 1/r pdv((1), r) = 1/r dot 0 = 0,
  $
  for all $r > 0$. Compare this to trying the same calculation directly in Cartesian coordinates, where $ln r = 1/2 ln(x^2+y^2)$: it can be done, but the cylindrical route above is much shorter, precisely because $f$ only depends on $r$.
]

== Spherical Coordinates <sec:vc-spherical>

#definition(title: "Spherical coordinates")[
  Spherical coordinates $(r,theta,phi)$ are related to Cartesian coordinates by
  $
    x = r sin theta cos phi, quad y = r sin theta sin phi, quad z = r cos theta,
  $<eq:vc-sph-def>
  with domain $r >= 0$, $0 <= theta <= pi$, $0 <= phi < 2pi$.
]<def:spherical>
Here $r$ is the distance from the origin, $theta$ is the #keyword[polar angle] measured from the positive $z$-axis, and $phi$ is the same #keyword[azimuthal angle] as in cylindrical coordinates.

#align(center)[
  #canvas(length: 1.1cm, {
    let pr = (X, Y, Z) => (X + Y * 0.45, Z - Y * 0.30)
    let axlen = 2.0
    let thin = 0.65pt
    draw.line(
      pr(0, 0, 0),
      pr(axlen, 0, 0),
      mark: (end: "stealth", fill: black, stroke: black + thin, transform-shape: false),
      stroke: black + thin,
    )
    draw.content((pr(axlen, 0, 0).at(0) + 0.18, pr(axlen, 0, 0).at(1)), text(size: 8pt)[$x$])
    draw.line(
      pr(0, 0, 0),
      pr(0, axlen, 0),
      mark: (end: "stealth", fill: black, stroke: black + thin, transform-shape: false),
      stroke: black + thin,
    )
    draw.content((pr(0, axlen, 0).at(0) + 0.18, pr(0, axlen, 0).at(1) - 0.05), text(size: 8pt)[$y$])
    draw.line(
      pr(0, 0, 0),
      pr(0, 0, axlen),
      mark: (end: "stealth", fill: black, stroke: black + thin, transform-shape: false),
      stroke: black + thin,
    )
    draw.content((pr(0, 0, axlen).at(0) + 0.05, pr(0, 0, axlen).at(1) + 0.18), text(size: 8pt)[$z$])
    let r_p = 1.5
    let theta_deg = 50.0
    let phi_deg = 55.0
    let theta = theta_deg * calc.pi / 180
    let phi = phi_deg * calc.pi / 180
    let Xp = r_p * calc.sin(theta) * calc.cos(phi)
    let Yp = r_p * calc.sin(theta) * calc.sin(phi)
    let Zp = r_p * calc.cos(theta)
    let sP = pr(Xp, Yp, Zp)
    let sO = pr(0, 0, 0)
    draw.line(sO, sP, stroke: (paint: c.gray, thickness: 0.6pt, dash: "dashed"))
    let n_arc = 24
    let r_phi = 0.4
    let arc_phi = range(0, n_arc + 1).map(i => {
      let t = i * phi / n_arc
      pr(r_phi * calc.cos(t), r_phi * calc.sin(t), 0)
    })
    draw.line(..arc_phi, stroke: (paint: c.gray, thickness: 0.65pt))
    let r_th = 0.55
    let arc_theta = range(0, n_arc + 1).map(i => {
      let t = i * theta / n_arc
      pr(r_th * calc.sin(t) * calc.cos(phi), r_th * calc.sin(t) * calc.sin(phi), r_th * calc.cos(t))
    })
    draw.line(..arc_theta, stroke: (paint: c.gray, thickness: 0.65pt))
    draw.circle(sP, radius: 0.07, fill: black, stroke: none)
    let rM = pr(Xp * 0.5, Yp * 0.5, Zp * 0.5)
    draw.content((rM.at(0) + 0.18, rM.at(1)), text(fill: c.gray, size: 8pt)[$r$])
    let phiM = pr(r_phi * calc.cos(phi * 0.5), r_phi * calc.sin(phi * 0.5), 0)
    draw.content((phiM.at(0) + 0.05, phiM.at(1) - 0.18), text(fill: c.gray, size: 8pt)[$phi$])
    let tM = pr(
      r_th * calc.sin(theta * 0.5) * calc.cos(phi),
      r_th * calc.sin(theta * 0.5) * calc.sin(phi),
      r_th * calc.cos(theta * 0.5),
    )
    draw.content((tM.at(0) + 0.12, tM.at(1) + 0.08), text(fill: c.gray, size: 8pt)[$theta$])
    draw.content((sP.at(0) + 0.18, sP.at(1) + 0.1), text(size: 8.5pt)[$P$])
    let blen = 0.60
    let er_end = pr(
      Xp + blen * calc.sin(theta) * calc.cos(phi),
      Yp + blen * calc.sin(theta) * calc.sin(phi),
      Zp + blen * calc.cos(theta),
    )
    draw.line(
      sP,
      er_end,
      mark: (end: "stealth", fill: c.blue, stroke: c.blue + 1.2pt, transform-shape: false),
      stroke: c.blue + 1.2pt,
    )
    draw.content((er_end.at(0) + 0.10, er_end.at(1) + 0.10), text(fill: c.blue, size: 8pt)[$vcu(e)_r$])
    let et_end = pr(
      Xp + blen * calc.cos(theta) * calc.cos(phi),
      Yp + blen * calc.cos(theta) * calc.sin(phi),
      Zp - blen * calc.sin(theta),
    )
    draw.line(
      sP,
      et_end,
      mark: (end: "stealth", fill: c.alt-a, stroke: c.alt-a + 1.2pt, transform-shape: false),
      stroke: c.alt-a + 1.2pt,
    )
    draw.content((et_end.at(0) + 0.12, et_end.at(1) - 0.10), text(fill: c.alt-a, size: 8pt)[$vcu(e)_theta$])
    let ef_end = pr(
      Xp - blen * calc.sin(phi),
      Yp + blen * calc.cos(phi),
      Zp,
    )
    draw.line(
      sP,
      ef_end,
      mark: (end: "stealth", fill: c.green, stroke: c.green + 1.2pt, transform-shape: false),
      stroke: c.green + 1.2pt,
    )
    draw.content((ef_end.at(0) - 0.08, ef_end.at(1) + 0.16), text(fill: c.green, size: 8pt)[$vcu(e)_phi$])
  })
]

#be-careful[
  This course follows the *physics convention*: $theta$ is the polar angle (from the $z$-axis, ranging over $[0,pi]$) and $phi$ is the azimuthal angle (around the $z$-axis, ranging over $[0,2pi)$). Many mathematics textbooks swap these two letters, calling the polar angle $phi$ and the azimuthal angle $theta$. When you read a formula from an unfamiliar source, check its convention before trusting the symbols; do not assume $theta$ always means the same angle.
]

The basis vectors $vcu(e)_r, vcu(e)_theta, vcu(e)_phi$ point in the directions of increasing $r$ (radially outward), increasing $theta$ (tangent to a meridian, "southward"), and increasing $phi$ (tangent to a circle of latitude, "eastward"), respectively; like the cylindrical basis, they depend on the point. The scale factors are $h_r = 1$, $h_theta = r$, $h_phi = r sin theta$ (a small change $d phi$ sweeps an arc length $r sin theta thin dd phi$, since the circle of latitude at polar angle $theta$ has radius $r sin theta$, not $r$). The volume element is
$
  dd V = r^2 sin theta thin d r thin d theta thin d phi.
$<eq:vc-sph-volume>
The gradient, divergence, and Laplacian take the form
$
  nabla f &= pdv(f, r) vcu(e)_r + 1/r pdv(f, theta) vcu(e)_theta + 1/(r sin theta) pdv(f, phi) vcu(e)_phi, \
  nabla dot vc(F) &= 1/r^2 pdv((r^2 F_r), r) + 1/(r sin theta) pdv((sin theta thin F_theta), theta) + 1/(r sin theta) pdv(F_phi, phi), \
  nabla^2 f &= 1/r^2 pdv((), r) (r^2 pdv(f, r)) + 1/(r^2 sin theta) pdv((), theta) (sin theta pdv(f, theta)) + 1/(r^2 sin^2 theta) pdv(f, phi, 2).
$<eq:vc-sph-ops>

#example(title: "Laplacian of $1/r$ in spherical coordinates")[
  Recompute $nabla^2 (1\/r)$ for $r != 0$, this time using @eq:vc-sph-ops, and compare to the Cartesian calculation earlier in this chapter.
]
#solution[
  Since $f = 1\/r$ depends on $r$ alone, only the first term survives:
  $
    nabla^2 (1/r) = 1/r^2 pdv((), r) (r^2 pdv((1\/r), r)) = 1/r^2 pdv((), r) (r^2 dot (-1/r^2)) = 1/r^2 pdv((-1), r) = 1/r^2 dot 0 = 0,
  $
  for all $r > 0$. This matches @eq:vc-laplacian-scalar computed directly in Cartesian coordinates, but the spherical route takes three short lines instead of a page of product-rule bookkeeping. This is the entire point of using curvilinear coordinates: match the coordinate system to the symmetry of the problem, and the calculation becomes easy.
]

#quizzes[
  + `4` Convert the Cartesian point $(1,1,0)$ to cylindrical coordinates $(r,phi,z)$.\ Convert\ Convert
  + `4` Convert the Cartesian point $(0,0,2)$ to spherical coordinates $(r,theta,phi)$. #hint[This point lies on the positive $z$-axis; what is $theta$ there?]
  + `4` In spherical coordinates, which coordinate ranges over $[0,pi]$ and which ranges over $[0,2pi)$?
]

#problems[
  + `4` Convert the point $(x,y,z) = (0,3,4)$ to both cylindrical and spherical coordinates.
  + `3` Compute the volume of a sphere of radius $R$ by integrating the volume element @eq:vc-sph-volume over the full domain of $theta$ and $phi$, and check you recover $4/3 pi R^3$.
  + `3` A scalar field depends only on the cylindrical radius, $f = f(r)$. Show that $nabla^2 f = 1/r dv(, r)(r dv(f, r))$, a special case of @eq:vc-cyl-ops with no $phi$- or $z$-dependence, and use it to solve $nabla^2 f = 0$ for $f(r)$ (up to two constants of integration). #hint[This is the electric potential between two coaxial cylinders.]
  + `2` Using @eq:vc-sph-ops, verify that $f = 1\/r^2$ does *not* satisfy $nabla^2 f = 0$ for $r>0$ (unlike $f=1\/r$). Compute $nabla^2(1\/r^2)$ explicitly.
  + `9` (drill: reading off scale factors) State the scale factor $h$ for each coordinate: (a) $h_z$ in cylindrical, (b) $h_phi$ in cylindrical, (c) $h_theta$ in spherical, (d) $h_r$ in spherical.
]
