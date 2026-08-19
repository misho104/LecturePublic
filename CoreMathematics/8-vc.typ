#import "misho-text.typ": *
#import "physica.typ": dv, pdv  // cspell: disable-line
#import "5-vector.typ": dm, va, vc, vcu, vip
// cspell: ignore Levi Civita

// Chapter-local macros
#let vt(a, b) = $vc(#a) times vc(#b)$
#let eps = $epsilon$ // Levi-Civita symbol shorthand

#restriction[This chapter assumes all fields are sufficiently smooth (continuously differentiable as many times as we need). We work in Cartesian coordinates $x_1=x$, $x_2=y$, $x_3=z$ unless stated otherwise.]

This chapter is about how derivatives interact with vectors. A car's temperature sensor gives you one number per point in space---a #keyword[scalar field]. The wind around the car gives you a vector at every point---a #keyword[vector field]. Physics is full of both, and physics equations (Maxwell's equations, the Navier--Stokes equation, the diffusion equation) are written using a small set of derivative operations on these fields: the gradient, the divergence, and the curl. This chapter teaches you to compute with them quickly and to understand what they mean.

= Index Notation: Kronecker Delta and Levi-Civita Symbol <sec:vc-index>

In @chap:matrix we defined the #keyword[Kronecker delta]
$
  delta_(i j) := cases(1 "if" i=j",", 0 "if" i != j.)
$<eq:vc-kronecker>
for $i, j in {1,2,3}$ (we restrict to three indices in this chapter, since we work in $RR^3$). You have already used $delta_(i j)$ to write orthonormality of a basis compactly. Now we introduce a second symbol that lets us write cross products, and later curls, without drawing a $3 times 3$ determinant every time.

#definition(title: "Levi-Civita symbol")[
  For $i,j,k in {1,2,3}$, define
  $
    eps_(i j k) := cases(
      +1 & "if" (i,j,k) "is an even permutation of" (1,2,3)",",
      -1 & "if" (i,j,k) "is an odd permutation of" (1,2,3)",",
      quad 0 & "if any two of" i,j,k "are equal.",
    )
  $<eq:vc-levicivita>
]<def:levi-civita>
"Even permutation" means you reach $(i,j,k)$ from $(1,2,3)$ by swapping pairs an even number of times; "odd" means an odd number of swaps. Concretely,
$
  eps_(123) = eps_(231) = eps_(312) = +1, quad eps_(132) = eps_(213) = eps_(321) = -1,
$
and $eps_(i j k) = 0$ whenever two of the three indices coincide, e.g. $eps_(112) = eps_(233) = 0$. There are $27$ possible triples $(i,j,k)$ with $i,j,k in {1,2,3}$; only $6$ of them are nonzero.

#remark[
  A quick way to remember the sign: $eps_(i j k)$ flips sign every time you swap two neighbouring indices. Starting from $eps_(123)=+1$, swapping the last two gives $eps_(132) = -1$, swapping the first two of that gives $eps_(312) = +1$, and so on.
]

#quizzes[
  + `4` Compute $eps_(213)$, $eps_(321)$, $eps_(122)$, and $eps_(231)$.
  + `4` Is $eps_(i j k) = eps_(j k i)$ true for all $i,j,k$? #hint[This is a cyclic permutation, not a swap of two indices.]
]

== Cross Product and the $eps$-$delta$ Identity <sec:vc-eps-delta>

Recall from @chap:matrix (@eq:mat-vec3) that for $vc(a), vc(b) in RR^3$,
$
  vc(a) times vc(b) = mat(a_2 b_3 - a_3 b_2; a_3 b_1 - a_1 b_3; a_1 b_2 - a_2 b_1).
$
Using $eps_(i j k)$, the $i$-th component of this vector is written compactly as
$
  (vc(a) times vc(b))_i = sum_(j=1)^3 sum_(k=1)^3 eps_(i j k) a_j b_k.
$<eq:vc-cross-index>
#example(title: "Checking the first component")[
  Verify @eq:vc-cross-index for $i=1$.
]
#solution[
  Only terms with $eps_(1 j k) != 0$ survive: these are $(j,k) = (2,3)$, giving $eps_(123) = +1$, and $(j,k)=(3,2)$, giving $eps_(132)=-1$. So
  $
    sum_(j,k) eps_(1 j k) a_j b_k = eps_(123) a_2 b_3 + eps_(132) a_3 b_2 = a_2 b_3 - a_3 b_2,
  $
  which matches the first component of $vc(a) times vc(b)$ above.
]

The real power of index notation shows up when you need to simplify an expression with two cross products, like the "BAC-CAB" formula $vc(a) times (vc(b) times vc(c))$. The following identity is the tool that makes such calculations mechanical instead of painful.

#theorem(title: "The $eps$-$delta$ identity")[
  For all $i,j,l,m in {1,2,3}$,
  $
    sum_(k=1)^3 eps_(i j k) eps_(k l m) = delta_(i l) delta_(j m) - delta_(i m) delta_(j l).
  $<eq:vc-eps-delta>
]<thm:eps-delta>
#advanced-note[
  A full proof checks all $3^4 = 81$ combinations of $(i,j,l,m)$ by cases, which is tedious but elementary; both sides vanish unless $\{i,j\} = \{l,m\}$ as sets, and then a short case check confirms the two remaining cases $i=l,j=m$ and $i=m,j=l$. Sho will not reproduce all 81 cases here---this is a drill book, not an encyclopedia---but you can verify a handful of cases yourself to build confidence.
]

#example(title: "Deriving the BAC-CAB rule")[
  Use @eq:vc-eps-delta to show that for $vc(a),vc(b),vc(c) in RR^3$,
  $
    vc(a) times (vc(b) times vc(c)) = vc(b) (vip(a,c)) - vc(c) (vip(a,b)).
  $<eq:vc-bac-cab>
]
#solution[
  Write the $i$-th component using @eq:vc-cross-index twice, first for the outer product and then for $(vc(b) times vc(c))_k$:
  $
    (vc(a) times (vc(b) times vc(c)))_i
    = sum_(j,k) eps_(i j k) a_j (vc(b) times vc(c))_k
    = sum_(j,k) eps_(i j k) a_j sum_(l,m) eps_(k l m) b_l c_m.
  $
  Reorder the sums and group the two $eps$ factors that share the index $k$:
  $
    = sum_(j,l,m) a_j b_l c_m sum_k eps_(i j k) eps_(k l m).
  $
  Now $eps_(k l m) = eps_(l m k)$ (a cyclic permutation does not change the sign, see the quiz above), so $sum_k eps_(i j k) eps_(l m k) = sum_k eps_(i j k) eps_(k l m)$ still matches the pattern in @thm:eps-delta with the roles $(i,j,l,m) mapsto (i,j,l,m)$. Applying @eq:vc-eps-delta:
  $
    = sum_(j,l,m) a_j b_l c_m (delta_(i l) delta_(j m) - delta_(i m) delta_(j l)).
  $
  The Kronecker deltas collapse the sums: $delta_(i l)$ forces $l=i$, and $delta_(j m)$ forces $m=j$, giving the term $sum_j a_j b_i c_j = b_i sum_j a_j c_j = b_i vip(a,c)$. The second term similarly gives $-c_i vip(a,b)$. Adding them:
  $
    (vc(a) times (vc(b) times vc(c)))_i = b_i vip(a,c) - c_i vip(a,b),
  $
  which is exactly the $i$-th component of @eq:vc-bac-cab.
]
#be-careful[
  A very common slip is to write $vc(a) times (vc(b) times vc(c)) = (vc(a) times vc(b)) times vc(c)$, i.e. to assume the cross product is associative. It is *not*. The two sides differ in general; only @eq:vc-bac-cab (with $vc(a)$ acting on the *inner* product) is correct for the left-hand form. If you need the other grouping, apply @eq:vc-bac-cab after rewriting $(vc(a) times vc(b)) times vc(c) = -vc(c) times (vc(a) times vc(b))$.
]

#problems[
  + `4` Compute $vc(a) times vc(b)$ for $vc(a) = (1,0,2)^TT$ and $vc(b) = (0,3,-1)^TT$ using @eq:vc-cross-index directly (sum over $j,k$ by hand for each $i$), then check against the determinant formula from @chap:matrix.
  + `3` Prove the scalar triple product formula $vip(a, (vc(b) times vc(c))) = sum_(i,j,k) eps_(i j k) a_i b_j c_k$, and use it to show $vip(a,(vc(b) times vc(c))) = vip((vc(a) times vc(b)),c)$.
  + `2` Use @thm:eps-delta to prove Lagrange's identity $va(vc(a) times vc(b))^2 = va(vc(a))^2 va(vc(b))^2 - vip(a,b)^2$.
  + `9` (drill: reading $eps$) Evaluate without a table: (a) $eps_(132)$, (b) $eps_(313)$, (c) $eps_(321)$, (d) $eps_(111)$.
  + `9` (drill: contracting one index) Simplify each sum: (a) $sum_k eps_(i j k) delta_(j k)$, (b) $sum_(j,k) eps_(i j k) eps_(l j k)$. #hint[For (b), use @thm:eps-delta and then set $m=k$, summing over $k$ at the end.]
]

= Scalar and Vector Fields <sec:vc-fields>

You already know functions like $f(x) = x^2$: one number in, one number out. Physics needs richer objects: quantities that depend on *where* you are in space.

#definition(title: "Scalar field")[
  A #keyword[scalar field] is a function
  $
    f: RR^3 -> RR, quad (x,y,z) |-> f(x,y,z),
  $
  assigning a single real number to every point of (a region of) space.
]<def:scalar-field>

#definition(title: "Vector field")[
  A #keyword[vector field] is a function
  $
    vc(F): RR^3 -> RR^3, quad (x,y,z) |-> vc(F)(x,y,z) = (F_x (x,y,z), F_y (x,y,z), F_z (x,y,z))^TT,
  $
  assigning a vector to every point of (a region of) space.
]<def:vector-field>

The distinction matters more than it looks. A scalar field has *no direction*: temperature at a point is just a number, $20 #unit("°C")$, not an arrow. A vector field has both magnitude and direction at each point: wind velocity at a point is "$8 unit(m/s)$ towards the north-east," not just "$8$."

#h-enum(cols: 2)[
  + Temperature $T(x,y,z)$ in a room --- scalar field.
  + Air pressure $p(x,y,z)$ in the atmosphere --- scalar field.
  + Electric potential $V(x,y,z)$ --- scalar field.
  + Electric field $vc(E)(x,y,z)$ --- vector field.
  + Gravitational field $vc(g)(x,y,z)$ --- vector field.
  + Fluid velocity $vc(v)(x,y,z)$ in a river --- vector field.
]

#remark[
  A field is a *function of position*, not a single vector or number. Writing $vc(F)$ for a vector field and $vc(a)$ for a fixed vector both use an arrow, but $vc(F)$ secretly depends on $(x,y,z)$ while $vc(a)$ does not. Keep this distinction in your head even when the notation does not show it explicitly.
]

We say a field is #keyword[differentiable] at a point if all its partial derivatives (with respect to $x$, $y$, $z$; for a vector field, of each component) exist and are continuous near that point. Informally: the field has no jumps, kinks, or infinite spikes there. We will not need a more precise definition in this drill book; when a formula like $1\/r$ blows up at $r=0$, we simply exclude that point from the domain, as you already do for ordinary derivatives.

#quizzes[
  + `4` Classify as scalar or vector field: (a) the density $rho(x,y,z)$ of a fluid, (b) the magnetic field $vc(B)(x,y,z)$, (c) the height $h(x,y)$ of a mountain above sea level, (d) the acceleration $vc(a)(x,y,z)$ of a falling particle at position $(x,y,z)$.
  + `4` Sho says "the wind speed (not velocity) at each point of the atmosphere is a scalar field." Is Sho right? #hint[Speed is the magnitude of a vector; a magnitude is a single number.]
]

#problems[
  + `4` Give one physics example each of a scalar field and a vector field not already listed above.
  + `3` The function $f(x,y,z) = 1\/sqrt(x^2+y^2+z^2)$ is a scalar field. State its domain explicitly (where is it *not* defined?).
  + `9` (drill: scalar vs. vector) For each quantity, write "scalar" or "vector": kinetic energy density, momentum density, stress at a point in a solid (skip if unfamiliar), voltage, current density, humidity.
]

= The Nabla Operator: Gradient, Divergence, Curl, Laplacian <sec:vc-nabla>

We now introduce the central character of this chapter, the symbol $nabla$ (pronounced "nabla" or "del"). It looks like a vector, and we manipulate it *as if* it were one, but you should know from the start that it is not.

#definition(title: "Nabla operator")[
  $
    nabla := mat(pdv((), x); pdv((), y); pdv((), z)).
  $<eq:vc-nabla-def>
]<def:nabla>

#be-careful[
  $nabla$ is *not* a vector of numbers. It is a #keyword[vector of differential operators]: each entry is an instruction "take the partial derivative with respect to this variable," waiting for a field to act on. Writing $nabla$ alone, without a field to its right, is meaningless---compare to writing "$dv(,x)$" with nothing to differentiate. Do not add $nabla$ to an ordinary vector $vc(a)$ (e.g. $nabla + vc(a)$ makes no sense) and do not treat $nabla dot vc(a)$ for constant $vc(a)$ as anything but $0$ (since every derivative of a constant is $0$).
]

$nabla$ combines with scalar and vector fields in three ways, giving three new fields.

== Gradient <sec:vc-grad>

#definition(title: "Gradient")[
  For a scalar field $f: RR^3 -> RR$, the #keyword[gradient] of $f$ is the vector field
  $
    nabla f := mat(pdv(f,x); pdv(f,y); pdv(f,z)).
  $<eq:vc-grad-def>
]<def:gradient>

The gradient turns a scalar field into a vector field: at each point, it collects the three partial derivatives into a vector. Geometrically, $nabla f$ at a point $vc(p)$ points in the direction in which $f$ increases *fastest*, and its magnitude $va(nabla f)$ is exactly that fastest rate of increase. If you walk in any other direction, $f$ changes more slowly. A second geometric fact: $nabla f$ is perpendicular to the #keyword[level surface] of $f$ through $vc(p)$ (the surface $f(x,y,z) = f(vc(p))$, e.g. a single contour line on a topographic map, thickened to a surface in 3D).

#example(title: "Gradient of $1/r$")[
  Let $r := va(vc(r)) = sqrt(x^2+y^2+z^2)$ for $vc(r) = (x,y,z)^TT != vc(0)$. Compute $nabla (1\/r)$.
]
#solution[
  $
    pdv((1\/r), x) = pdv((x^2+y^2+z^2)^(-1\/2), x) = -1/2 (x^2+y^2+z^2)^(-3\/2) dot 2x = -x/r^3,
  $
  and similarly for $y, z$. So
  $
    nabla (1/r) = mat(-x\/r^3; -y\/r^3; -z\/r^3) = -vc(r)/r^3 = -vcu(r)/r^2,
  $<eq:vc-grad-1-over-r>
  where $vcu(r) = vc(r)\/r$ is the unit vector pointing radially outward. This formula is *not* defined at $vc(r) = vc(0)$, where $r=0$ and division by zero occurs; the domain is $RR^3 without {vc(0)}$.
]
#remark[
  You will recognise @eq:vc-grad-1-over-r from electrostatics: the electric field of a point charge is $vc(E) = -nabla V$ with $V prop 1\/r$, and the result is the familiar $vc(E) prop vcu(r)\/r^2$.
]

== Divergence <sec:vc-div>

#definition(title: "Divergence")[
  For a vector field $vc(F) = (F_x, F_y, F_z)^TT$, the #keyword[divergence] of $vc(F)$ is the scalar field
  $
    nabla dot vc(F) := pdv(F_x,x) + pdv(F_y,y) + pdv(F_z,z).
  $<eq:vc-div-def>
]<def:divergence>

The divergence turns a vector field into a scalar field. At a point $vc(p)$, $nabla dot vc(F)$ measures how much the field "spreads outward" from $vc(p)$: if $vc(F)$ is the velocity field of a fluid, $nabla dot vc(F) (vc(p)) > 0$ means fluid is being created (a source) at $vc(p)$ or, more precisely, that more fluid flows out of a tiny volume around $vc(p)$ than flows in; $nabla dot vc(F)(vc(p)) < 0$ means fluid is disappearing there (a sink); $nabla dot vc(F) = 0$ everywhere means the fluid is #keyword[incompressible] (what flows in always equals what flows out).

#example(title: "Divergence of the position field")[
  Compute $nabla dot vc(r)$ for $vc(r) = (x,y,z)^TT$.
]
#solution[
  $
    nabla dot vc(r) = pdv(x,x) + pdv(y,y) + pdv(z,z) = 1+1+1 = 3.
  $<eq:vc-div-r>
  Every point in space is a source: the field $vc(r)$ points away from the origin everywhere and grows in magnitude, so it "spreads out" at every point, consistently with the constant, positive divergence.
]

== Curl <sec:vc-curl>

#definition(title: "Curl")[
  For a vector field $vc(F) = (F_x,F_y,F_z)^TT$, the #keyword[curl] of $vc(F)$ is the vector field
  $
    nabla times vc(F) := mat(pdv(F_z,y) - pdv(F_y,z); pdv(F_x,z) - pdv(F_z,x); pdv(F_y,x) - pdv(F_x,y))
    = det(mat(vc(e)_x, vc(e)_y, vc(e)_z; pdv((),x), pdv((),y), pdv((),z); F_x,F_y,F_z)),
  $<eq:vc-curl-def>
  where $vc(e)_x, vc(e)_y, vc(e)_z$ are the standard basis vectors and the determinant is expanded symbolically along the first row, exactly as with the ordinary cross product formula.
]<def:curl>

The curl turns a vector field into another vector field. It measures *local rotation*: if you place a tiny paddle wheel at a point $vc(p)$ and let the field push on it, the wheel spins with axis along $nabla times vc(F)(vc(p))$ (by the right-hand rule) and angular speed equal to $va(nabla times vc(F))\/2$ at that point. A field with $nabla times vc(F) = vc(0)$ everywhere is called #keyword[irrotational]: no tiny paddle wheel anywhere in it ever spins.

#example(title: "Curl of the position field")[
  Compute $nabla times vc(r)$ for $vc(r) = (x,y,z)^TT$.
]
#solution[
  $
    (nabla times vc(r))_x = pdv(z,y) - pdv(y,z) = 0-0=0,
  $
  and the other two components vanish the same way, since each component of $vc(r)$ depends on only one coordinate. So $nabla times vc(r) = vc(0)$: the position field does not rotate around any point, which matches the intuition that $vc(r)$ points straight out from the origin everywhere, with no swirl.
]<eq:vc-curl-r>

== Laplacian <sec:vc-laplacian>

#definition(title: "Laplacian")[
  For a scalar field $f$, the #keyword[Laplacian] of $f$ is
  $
    nabla^2 f := nabla dot (nabla f) = pdv(f,x,2) + pdv(f,y,2) + pdv(f,z,2).
  $<eq:vc-laplacian-scalar>
  For a vector field $vc(F)$, the #keyword[vector Laplacian] is the componentwise Laplacian
  $
    nabla^2 vc(F) := mat(nabla^2 F_x; nabla^2 F_y; nabla^2 F_z).
  $<eq:vc-laplacian-vector>
]<def:laplacian>

$nabla^2 f$ is a scalar field: it is the divergence of the gradient, i.e. "the gradient of $f$, then take its divergence." It appears everywhere in physics: the diffusion equation, the wave equation, and Laplace's equation $nabla^2 V = 0$ for the electric potential in charge-free regions all use it.

#example(title: "Laplacian of $1/r$")[
  Show that $nabla^2 (1\/r) = 0$ for $r != 0$.
]
#solution[
  From @eq:vc-grad-1-over-r, $nabla(1\/r) = -vc(r)\/r^3$, with components $-x\/r^3, -y\/r^3, -z\/r^3$. Differentiate the $x$-component again with respect to $x$ (using the product rule, since $r$ depends on $x$):
  $
    pdv((), x) (-x/r^3) = -1/r^3 - x dot (-3) r^(-4) pdv(r,x) = -1/r^3 + (3x)/r^4 dot x/r = -1/r^3 + (3x^2)/r^5,
  $
  using $pdv(r,x) = x\/r$ (same calculation as in the gradient example, applied to $r$ itself instead of $1\/r$). Summing the analogous results for $y$ and $z$:
  $
    nabla^2 (1/r) = -3/r^3 + (3(x^2+y^2+z^2))/r^5 = -3/r^3 + (3r^2)/r^5 = -3/r^3+3/r^3 = 0,
  $
  for all $vc(r) != vc(0)$. This fact is the mathematical heart of why the electric potential of a point charge solves Laplace's equation everywhere except at the charge itself.
]

#theorem(title: "A gradient has no curl")[
  For every twice-differentiable scalar field $f$,
  $
    nabla times (nabla f) = vc(0).
  $<eq:vc-curl-of-grad>
]<thm:curl-grad-zero>
#proof[
  The $x$-component of $nabla times (nabla f)$ is $pdv((nabla f)_z, y) - pdv((nabla f)_y, z) = pdv(f,z,y) - pdv(f,y,z)$ (mixed second partial derivatives). By Schwarz's theorem (symmetry of mixed partials, assumed throughout this chapter), $pdv(f,z,y) = pdv(f,y,z)$, so this component vanishes. The other two components vanish by the same argument, cycling through $x,y,z$.
]

#theorem(title: "The curl of a curl-source has no divergence")[
  For every twice-differentiable vector field $vc(F)$,
  $
    nabla dot (nabla times vc(F)) = 0.
  $<eq:vc-div-of-curl>
]<thm:div-curl-zero>
#proof[
  $
    nabla dot (nabla times vc(F)) = pdv((),x)(pdv(F_z,y) - pdv(F_y,z)) + pdv((),y)(pdv(F_x,z)-pdv(F_z,x)) + pdv((),z)(pdv(F_y,x)-pdv(F_x,y)).
  $
  Every mixed second partial derivative here, e.g. $pdv(F_z,x,y)$, appears exactly twice with opposite sign (once from each term that contains $F_z$), and by Schwarz's theorem the two mixed partials in each such pair are equal, so they cancel. All six terms cancel in pairs, leaving $0$.
]

#be-careful[
  @thm:curl-grad-zero and @thm:div-curl-zero are *theorems*, proved from Schwarz's symmetry of mixed partial derivatives---they are not extra axioms to memorise blindly, and they are not always true if $f$ or $vc(F)$ fails to be twice continuously differentiable somewhere in the domain (a common exception in physics is a field with a singularity, like $1\/r$ at $r=0$). Do not apply @eq:vc-curl-of-grad or @eq:vc-div-of-curl at a point where the field is not defined or not smooth.
]

#quizzes[
  + `4` For $f(x,y,z) = x^2 y + z$, compute $nabla f$.
  + `4` For $vc(F) = (x^2, y^2, z^2)^TT$, compute $nabla dot vc(F)$.
  + `4` For $vc(F) = (-y,x,0)^TT$, compute $nabla times vc(F)$. What direction does the curl point in, and what does that tell you about the rotation of this field?
  + `4` True or false: $nabla dot vc(F)$ is a vector field. #hint[Check @def:divergence again.]
]

#problems[
  + `4` Compute $nabla f$, $nabla dot vc(F)$, $nabla times vc(F)$, and $nabla^2 f$ for $f = x y z$ and $vc(F) = (y z, x z, x y)^TT$.
  + `3` Show directly (without using @thm:curl-grad-zero) that $nabla times (nabla f) = vc(0)$ for $f(x,y,z) = x^3 y^2 + sin(z)$, by computing both $nabla f$ and its curl.
  + `3` Let $vc(F) = vc(r)\/r^3$ for $vc(r) != vc(0)$. Show $nabla dot vc(F) = 0$ for $r != 0$. #hint[This is the divergence-free electric field of a point charge, away from the charge itself.]
  + `2` Compute $nabla^2 f$ for $f = ln r$ (with $r = sqrt(x^2+y^2)$, i.e. treat this as a field on $RR^2$, ignoring $z$), and comment on where it is undefined.
  + `9` (drill: which operator, which output type) For each expression below, state whether it is defined, and if so, whether the result is a scalar field or a vector field: (a) $nabla f$, (b) $nabla times f$, (c) $nabla dot vc(F)$, (d) $nabla times (nabla dot vc(F))$, (e) $nabla (nabla dot vc(F))$, (f) $nabla dot vc(F) times nabla g$.
]

= Vector Identities <sec:vc-identities>

The following identities let you simplify combinations of gradient, divergence, and curl without redoing an index calculation every time. Some are read off almost immediately from the definitions; others need the $eps$-$delta$ identity (@thm:eps-delta) or a careful product-rule bookkeeping. All assume $f,g$ are twice-differentiable scalar fields and $vc(A), vc(B), vc(F)$ are twice-differentiable vector fields, on whatever domain makes both sides defined.

#theorem(title: "Vector calculus identities")[
  $
    nabla times (nabla f) &= vc(0) & #[(proved above, @thm:curl-grad-zero)] \
    nabla dot (nabla times vc(F)) &= 0 & #[(proved above, @thm:div-curl-zero)] \
    nabla (f g) &= f nabla g + g nabla f & \
    nabla dot (f vc(F)) &= f (nabla dot vc(F)) + vc(F) dot (nabla f) & \
    nabla times (f vc(F)) &= f (nabla times vc(F)) + (nabla f) times vc(F) & \
    nabla (vip(A,B)) &= (vc(A) dot nabla) vc(B) + (vc(B) dot nabla) vc(A) + vc(A) times (nabla times vc(B)) + vc(B) times (nabla times vc(A)) & \
    nabla dot (vc(A) times vc(B)) &= vc(B) dot (nabla times vc(A)) - vc(A) dot (nabla times vc(B)) & \
    nabla times (vc(A) times vc(B)) &= vc(A) (nabla dot vc(B)) - vc(B) (nabla dot vc(A)) + (vc(B) dot nabla) vc(A) - (vc(A) dot nabla) vc(B) & \
    nabla^2 vc(F) &= nabla (nabla dot vc(F)) - nabla times (nabla times vc(F)). &
  $<eq:vc-identities>
]<thm:vc-identities>
Here $(vc(A) dot nabla)$ denotes the scalar differential operator $A_x pdv((),x) + A_y pdv((),y) + A_z pdv((),z)$, applied componentwise to the vector field that follows it; it is *not* the same object as $nabla dot vc(A)$ (a scalar field), so keep the parentheses.

#proof[
  We prove the third identity, $nabla(f g) = f nabla g + g nabla f$, since it is a direct application of the ordinary product rule. The $x$-component of the left side is $pdv((f g), x) = f pdv(g,x) + g pdv(f,x)$ by the product rule for ordinary partial derivatives. This equals the $x$-component of $f nabla g + g nabla f$. The same argument applies to the $y$- and $z$-components, proving the identity.
]
#proof[
  We prove the fourth identity, $nabla dot (f vc(F)) = f(nabla dot vc(F)) + vc(F) dot (nabla f)$. By definition,
  $
    nabla dot (f vc(F)) = pdv((f F_x),x) + pdv((f F_y),y) + pdv((f F_z),z).
  $
  Apply the product rule to each term: $pdv((f F_x),x) = f pdv(F_x,x) + F_x pdv(f,x)$, and similarly for $y,z$. Summing all three,
  $
    nabla dot (f vc(F)) = f (pdv(F_x,x) + pdv(F_y,y) + pdv(F_z,z)) + (F_x pdv(f,x) + F_y pdv(f,y) + F_z pdv(f,z)) = f(nabla dot vc(F)) + vc(F) dot (nabla f).
  $
]
#advanced-note[
  The remaining identities in @thm:vc-identities follow by the same style of calculation: expand every component using the definitions, apply the ordinary product rule to each partial derivative, and regroup terms. The two identities with $vc(A) times vc(B)$ additionally use the $eps$-$delta$ identity from @thm:eps-delta to simplify sums of two $eps$ symbols. Sho leaves these as problems below, since working through at least one of them yourself is the best way to trust the whole list.
]

#quizzes[
  + `4` Using the fourth identity in @eq:vc-identities, simplify $nabla dot (r^2 vc(r))$ where $r = va(vc(r))$, given that $nabla dot vc(r) = 3$ (@eq:vc-div-r) and $nabla (r^2) = 2 r nabla r = 2vc(r)$.
  + `4` Why does the identity $nabla^2 vc(F) = nabla(nabla dot vc(F)) - nabla times (nabla times vc(F))$ make sense dimensionally, i.e. why is each side a vector field, not a scalar field?
]

#problems[
  + `3` Prove $nabla dot (f vc(F)) = f (nabla dot vc(F)) + vc(F) dot (nabla f)$ for the specific fields $f = x^2+y^2$ and $vc(F) = (z,z,x+y)^TT$: compute both sides directly and check they agree.
  + `2` Prove the identity $nabla dot (vc(A) times vc(B)) = vc(B) dot (nabla times vc(A)) - vc(A) dot (nabla times vc(B))$ using index notation (write $nabla dot (vc(A) times vc(B)) = sum_i pdv((),x_i) sum_(j,k) eps_(i j k) A_j B_k$, apply the product rule, and regroup).
  + `2` Use @eq:vc-identities to simplify $nabla times (f nabla f)$ (a curl of a field built from a single scalar field $f$). #hint[Which of the two terms in the fifth identity of @eq:vc-identities vanishes, and why?]
  + `1` Prove the identity $nabla times (vc(A) times vc(B)) = vc(A)(nabla dot vc(B)) - vc(B)(nabla dot vc(A)) + (vc(B) dot nabla) vc(A) - (vc(A) dot nabla) vc(B)$ using @thm:eps-delta.
  + `9` (drill: which identity to reach for) For each target expression, name which line of @eq:vc-identities you would use first: (a) $nabla times (r^2 vc(F))$, (b) $nabla dot (nabla times (nabla f))$ (careful, this one is a trick), (c) $nabla (f^2)$.
]

= Gauss's Divergence Theorem <sec:vc-gauss>

So far, $nabla dot vc(F)$ and $nabla times vc(F)$ are *local* quantities: they describe behaviour at a single point. Two theorems relate these local quantities to *global*, integrated quantities over a surface or volume. The first is Gauss's theorem.

Let $V subset RR^3$ be a solid region (a volume) and let $S$ be its boundary: a #keyword[closed surface] (one with no edge, like a sphere or the surface of a potato, as opposed to an open sheet like a disc). At each point of $S$, let $vcu(n)$ be the #keyword[outward unit normal] vector, and write $d vc(S) := vcu(n) thin d S$ for the vector surface element, where $d S$ is an infinitesimal patch of area on $S$.

#theorem(title: "Gauss's divergence theorem")[
  Let $vc(F)$ be a differentiable vector field on (an open region containing) $V union S$. Then
  $
    integral.surf.double_S vc(F) dot d vc(S) = integral.triple_V (nabla dot vc(F)) thin d V.
  $<eq:vc-gauss>
]<thm:gauss>

In words: the total #keyword[flux] of $vc(F)$ out through the closed surface $S$ (left side) equals the total "amount of source" of $vc(F)$ produced inside the volume $V$ (right side). If $vc(F)$ is a fluid velocity field, the left side is the net volume of fluid leaving $V$ per unit time; the right side adds up, over every point inside $V$, how much fluid is being created or destroyed there. The two must agree, since fluid cannot vanish or appear inside $V$ without eventually crossing the boundary $S$.

#advanced-note[
  The proof, in full, chops $V$ into a grid of tiny cubes, applies the definition of divergence to each cube (the flux out of a tiny cube of side $dx$ is, to leading order, $(nabla dot vc(F)) thin dx^3$), and observes that the flux through the internal faces shared by two neighbouring cubes cancels (what flows out of one cube flows into its neighbour), leaving only the flux through the faces on the outer boundary $S$. We do not carry out this limiting argument in detail here; it belongs to a course in analysis, not this drill book.
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
    integral.surf.double_S vc(r) dot d vc(S) = integral.surf.double_S R thin dS = R dot (4 pi R^2) = 4 pi R^3,
  $
  using that the total area of $S$ is $4 pi R^2$. Both sides equal $4 pi R^3$.
]

#example(title: "Gauss's law from Gauss's theorem")[
  In electrostatics, Gauss's law in integral form states that the electric flux through a closed surface $S$ equals the enclosed charge divided by $epsilon_0$:
  $
    integral.surf.double_S vc(E) dot d vc(S) = Q_"enc" / epsilon_0 = 1/epsilon_0 integral.triple_V rho thin dV,
  $
  where $rho$ is the charge density. Derive the differential form $nabla dot vc(E) = rho\/epsilon_0$.
]
#solution[
  Apply @eq:vc-gauss to the left side:
  $
    integral.surf.double_S vc(E) dot d vc(S) = integral.triple_V (nabla dot vc(E)) thin dV.
  $
  Combining with the integral law,
  $
    integral.triple_V (nabla dot vc(E)) thin dV = integral.triple_V rho/epsilon_0 thin dV.
  $
  This must hold for *every* choice of volume $V$, however small. Two functions whose integrals agree over every possible volume must be equal at every point (shrink $V$ to a tiny ball around any point $vc(p)$; the average value of each side over that tiny ball converges to the value at $vc(p)$). Hence $nabla dot vc(E) = rho\/epsilon_0$ at every point.
]

#quizzes[
  + `4` For a vector field with $nabla dot vc(F) = 0$ everywhere inside $V$, what does @eq:vc-gauss say about the total flux out of $S$?
  + `4` Why must the surface $S$ in Gauss's theorem be closed (no edge)? #hint[Try to picture the theorem applied to just half a sphere.]
]

#problems[
  + `4` Use Gauss's theorem to compute $integral.surf.double_S vc(F) dot d vc(S)$ for $vc(F) = (x,y,z)^TT$ and $S$ the surface of the cube $[0,1]^3$, without parametrising the six faces. #hint[Compute $nabla dot vc(F)$ and integrate over the cube.]
  + `3` Let $vc(F) = (x^3, y^3, z^3)^TT$ and let $V$ be the ball of radius $R$. Compute $integral.triple_V (nabla dot vc(F)) thin dV$ using spherical coordinates (preview: see @sec:vc-curvilinear) or by symmetry with Cartesian coordinates, and interpret the flux.
  + `2` Explain, using Gauss's theorem, why a source-free vector field ($nabla dot vc(F) = 0$ everywhere) has zero total flux through *any* closed surface, even one shaped like a torus (donut).
]

= Stokes' Theorem <sec:vc-stokes>

Gauss's theorem related a volume integral to an integral over its boundary surface. Stokes' theorem plays the same role one dimension down: it relates a surface integral to an integral over the boundary *curve* of that surface.

Let $S$ be an #keyword[open surface] (one with an edge, e.g. a hemisphere or a disc, unlike the closed surfaces of the previous section), and let $C$ be its boundary curve. Orient $C$ using the #keyword[right-hand rule]: if the fingers of your right hand curl in the direction you traverse $C$, your thumb points in the direction of $d vc(S) = vcu(n) thin dS$ on $S$.

#theorem(title: "Stokes' theorem")[
  Let $vc(F)$ be a differentiable vector field on (an open region containing) $S union C$. Then
  $
    integral.cont_C vc(F) dot d vc(l) = integral.surf.double_S (nabla times vc(F)) dot d vc(S),
  $<eq:vc-stokes>
  where $d vc(l)$ is the infinitesimal tangent vector along $C$, pointing in the direction of traversal.
]<thm:stokes>

In words: the total #keyword[circulation] of $vc(F)$ around the boundary curve $C$ (left side) equals the total curl of $vc(F)$ passing through the surface $S$ (right side). If $vc(F)$ is a fluid velocity field, the left side measures how much the fluid tends to rotate along the loop $C$; the right side adds up all the tiny local rotations (measured by the curl) over every point of the surface $S$ that $C$ bounds.

#example(title: "Circulation of a rotation field")[
  Let $vc(F) = (-y,x,0)^TT$ and let $S$ be the disc of radius $R$ in the $x y$-plane centred at the origin, with $C$ its boundary circle traversed counterclockwise (viewed from $+z$). Verify @eq:vc-stokes.
]
#solution[
  *Right side.* From @eq:vc-curl-r, this field has $nabla times vc(F) = (0,0,2)^TT$ (a direct calculation: $pdv(F_y,x)-pdv(F_x,y) = 1-(-1) = 2$, and the other two components vanish). Since $d vc(S) = (0,0,1)^TT thin dS$ on this disc (outward, i.e. $+z$, matching the right-hand rule for counterclockwise traversal),
  $
    integral.surf.double_S (nabla times vc(F)) dot d vc(S) = integral.surf.double_S 2 thin dS = 2 dot (pi R^2) = 2 pi R^2.
  $
  *Left side.* Parametrise $C$ by $(x,y) = (R cos t, R sin t)$ for $t in [0, 2pi)$, so $d vc(l) = (-R sin t, R cos t, 0)^TT thin dt$. On $C$, $vc(F) = (-R sin t, R cos t, 0)^TT$, so
  $
    vc(F) dot d vc(l) = R^2 sin^2 t + R^2 cos^2 t = R^2,
  $
  giving
  $
    integral.cont_C vc(F) dot d vc(l) = integral_0^(2pi) R^2 thin dt = 2 pi R^2.
  $
  Both sides equal $2 pi R^2$.
]

#example(title: "Faraday's law from Stokes' theorem")[
  Faraday's law in integral form states $integral.cont_C vc(E) dot d vc(l) = -dv(Phi_B, t)$, where $Phi_B = integral.surf.double_S vc(B) dot d vc(S)$ is the magnetic flux through $S$. Use Stokes' theorem to derive the differential form $nabla times vc(E) = -pdv(vc(B),t)$.
]
#solution[
  Applying @eq:vc-stokes to the left side, $integral.cont_C vc(E) dot d vc(l) = integral.surf.double_S (nabla times vc(E)) dot d vc(S)$. Assuming the surface $S$ is fixed in time (does not move), $dv(Phi_B,t) = integral.surf.double_S pdv(vc(B),t) dot d vc(S)$. Substituting both into Faraday's law,
  $
    integral.surf.double_S (nabla times vc(E)) dot d vc(S) = -integral.surf.double_S pdv(vc(B),t) dot d vc(S).
  $
  As in the Gauss's law derivation, this holds for every choice of surface $S$, so the integrands must be equal at every point: $nabla times vc(E) = -pdv(vc(B),t)$.
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
  + `3` Show that $vc(F) = (2xy, x^2, 0)^TT$ is conservative by computing its curl, then find a scalar field $f$ with $vc(F) = nabla f$.
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

The #keyword[scale factors] $h_r = 1$, $h_phi = r$, $h_z = 1$ measure how much physical distance corresponds to a unit change in each coordinate (moving by $d phi$ at radius $r$ covers an arc length $r thin d phi$, hence $h_phi = r$). The volume element is
$
  d V = r thin d r thin d phi thin d z.
$<eq:vc-cyl-volume>
The gradient, divergence, and Laplacian take the form
$
  nabla f &= pdv(f,r) vcu(e)_r + 1/r pdv(f,phi) vcu(e)_phi + pdv(f,z) vcu(e)_z, \
  nabla dot vc(F) &= 1/r pdv((r F_r),r) + 1/r pdv(F_phi,phi) + pdv(F_z,z), \
  nabla^2 f &= 1/r pdv((),r) (r pdv(f,r)) + 1/r^2 pdv(f,phi,2) + pdv(f,z,2).
$<eq:vc-cyl-ops>
(The curl in cylindrical coordinates exists too but Sho will spare you the formula here; look it up when a specific problem needs it, and use the Cartesian definition to re-derive it if you must.)

#example(title: "Laplacian of $ln r$ in cylindrical coordinates")[
  For $f = ln r$ (a field on the plane, independent of $phi$ and $z$; $r > 0$), compute $nabla^2 f$ using @eq:vc-cyl-ops.
]
#solution[
  Since $f$ does not depend on $phi$ or $z$, only the first term of the Laplacian survives:
  $
    nabla^2 f = 1/r pdv((),r) (r pdv((ln r),r)) = 1/r pdv((),r) (r dot 1/r) = 1/r pdv((1),r) = 1/r dot 0 = 0,
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

#be-careful[
  This course follows the *physics convention*: $theta$ is the polar angle (from the $z$-axis, ranging over $[0,pi]$) and $phi$ is the azimuthal angle (around the $z$-axis, ranging over $[0,2pi)$). Many mathematics textbooks swap these two letters, calling the polar angle $phi$ and the azimuthal angle $theta$. When you read a formula from an unfamiliar source, check its convention before trusting the symbols; do not assume $theta$ always means the same angle.
]

The basis vectors $vcu(e)_r, vcu(e)_theta, vcu(e)_phi$ point in the directions of increasing $r$ (radially outward), increasing $theta$ (tangent to a meridian, "southward"), and increasing $phi$ (tangent to a circle of latitude, "eastward"), respectively; like the cylindrical basis, they depend on the point. The scale factors are $h_r = 1$, $h_theta = r$, $h_phi = r sin theta$ (a small change $d phi$ sweeps an arc length $r sin theta thin dphi$, since the circle of latitude at polar angle $theta$ has radius $r sin theta$, not $r$). The volume element is
$
  dV = r^2 sin theta thin d r thin d theta thin d phi.
$<eq:vc-sph-volume>
The gradient, divergence, and Laplacian take the form
$
  nabla f &= pdv(f,r) vcu(e)_r + 1/r pdv(f,theta) vcu(e)_theta + 1/(r sin theta) pdv(f,phi) vcu(e)_phi, \
  nabla dot vc(F) &= 1/r^2 pdv((r^2 F_r),r) + 1/(r sin theta) pdv((sin theta thin F_theta),theta) + 1/(r sin theta) pdv(F_phi,phi), \
  nabla^2 f &= 1/r^2 pdv((),r) (r^2 pdv(f,r)) + 1/(r^2 sin theta) pdv((),theta) (sin theta pdv(f,theta)) + 1/(r^2 sin^2 theta) pdv(f,phi,2).
$<eq:vc-sph-ops>

#example(title: "Laplacian of $1/r$ in spherical coordinates")[
  Recompute $nabla^2 (1\/r)$ for $r != 0$, this time using @eq:vc-sph-ops, and compare to the Cartesian calculation earlier in this chapter.
]
#solution[
  Since $f = 1\/r$ depends on $r$ alone, only the first term survives:
  $
    nabla^2 (1/r) = 1/r^2 pdv((),r) (r^2 pdv((1\/r),r)) = 1/r^2 pdv((),r) (r^2 dot (-1/r^2)) = 1/r^2 pdv((-1),r) = 1/r^2 dot 0 = 0,
  $
  for all $r > 0$. This matches @eq:vc-laplacian-scalar computed directly in Cartesian coordinates, but the spherical route takes three short lines instead of a page of product-rule bookkeeping. This is the entire point of using curvilinear coordinates: match the coordinate system to the symmetry of the problem, and the calculation becomes easy.
]

#quizzes[
  + `4` Convert the Cartesian point $(1,1,0)$ to cylindrical coordinates $(r,phi,z)$.
  + `4` Convert the Cartesian point $(0,0,2)$ to spherical coordinates $(r,theta,phi)$. #hint[This point lies on the positive $z$-axis; what is $theta$ there?]
  + `4` In spherical coordinates, which coordinate ranges over $[0,pi]$ and which ranges over $[0,2pi)$?
]

#problems[
  + `4` Convert the point $(x,y,z) = (0,3,4)$ to both cylindrical and spherical coordinates.
  + `3` Compute the volume of a sphere of radius $R$ by integrating the volume element @eq:vc-sph-volume over the full domain of $theta$ and $phi$, and check you recover $4/3 pi R^3$.
  + `3` A scalar field depends only on the cylindrical radius, $f = f(r)$. Show that $nabla^2 f = 1/r dv(,r)(r dv(f,r))$, a special case of @eq:vc-cyl-ops with no $phi$- or $z$-dependence, and use it to solve $nabla^2 f = 0$ for $f(r)$ (up to two constants of integration). #hint[This is the electric potential between two coaxial cylinders.]
  + `2` Using @eq:vc-sph-ops, verify that $f = 1\/r^2$ does *not* satisfy $nabla^2 f = 0$ for $r>0$ (unlike $f=1\/r$). Compute $nabla^2(1\/r^2)$ explicitly.
  + `9` (drill: reading off scale factors) State the scale factor $h$ for each coordinate: (a) $h_z$ in cylindrical, (b) $h_phi$ in cylindrical, (c) $h_theta$ in spherical, (d) $h_r$ in spherical.
]
