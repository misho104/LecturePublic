#import "misho-text.typ": *
#import "physica.typ": dv, pdv  // cspell: disable-line
#import "5-vector.typ": dm, va, vc, vcu, vip, vxp
#import "6-complex.typ": Arg
#import "2-units.typ": writing, writings
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

#let jacobian(a, b, c, d, e, f) = math.mat(..(d, e, f).map(i => (a, b, c).map(j => $pdv(#i, #j)$)))


After we introduced vectors in @chap:vector, we took a long journey through complex numbers, complex vectors, and matrices.
Those abstract structures are essential for modern physics, but at the end of the day, we physicists live in the real world: the three-dimensional space $RR^3$.

In this chapter, we return to that world.
We will focus on vectors in $RR^3$, i.e., arrows in our three-dimensional space, and study #keyword[vector calculus]:
how to apply the tools of calculus (derivatives and integrals) to such vectors.
The central objects will be #keyword[scalar fields] and #keyword[vector fields], which we introduce first.

#restriction[
  In this chapter, vectors are real and three-dimensional ($in RR^3$) unless otherwise stated. Also, we will assume all functions are smooth enough (or "friendly to physicists"); we do not consider functions with singularities, discontinuities, or other "pathological" behaviors.]
#advanced-note[
  Mathematically, all functions in this chapter are assumed to be #keyword(key: "C2", display: $C^2$)[class $#math-thick-sf[C]^#math-thick-sf[2]$].
  A function is called $C^p$ if we can calculate its $p$-th partial derivative in any combinations and the derivatives are all continuous.
  So, we assume $px^2 f$, $px py f$, $py px f$, ..., and $pz^2 f$ are all existent and continuous.
  This is a sufficient condition to ensure the symmetry of second derivatives, $partial_i partial_j f = partial_j partial_i f$ #cite(supplement: [pp. 732--733], <Hubbard5e>).
]

In this section, we introduce the short-hand notation for partial derivatives,
$
  px = pdv(, x), quad py = pdv(, y), quad pz = pdv(, z); quad "we also use"quad partial_1 = px, quad partial_2 = py, quad partial_3 = pz.
$
For example, $px(3x + 2x y + y + 1) = pdv(, x)(3x + 2x y + y + 1)=3+2y$.
#quizzes[
  + With $f(x,y)=x^3 + 4x^2 + 5x y^2 + 7y^2$, calculate the following.
    #h-enum(cols: 5)[
      + $px f$
      + $py f$
      + $px py f$
      + $py px f$
      + $px^2 f$
    ]
]




= Scalar fields and Vector fields <sec:fields>

You already know functions like $f(x) = x^2$: one number in, one number out.
It is natural to extend the idea to "many numbers in, many numbers out". For example,

- $v(t) = mat(2t; 1-t^2; 0)$ ... one number in, three numbers (= a vector) out.

- $T(x, y, z) = sqrt(x^2 + y^2 + z^2)$ ... three numbers in, one number out.

- $vc(F)(x, y, z) = mat(3x+2y; y + z; x+y+z)=mat(3, 2, 0; 0, 1, 1; 1, 1, 1)mat(x; y; z)$ ... three numbers in, three numbers out.

Here, if you recall the concept of position vectors ($->$ @sec:vec-pos), you notice that the input $(x,y,z)$ may represent a point in space. Namely, we can understand the above functions as

- $T(x, y, z) = sqrt(x^2 + y^2 + z^2)$ ... a function that assigns a scalar value $T$ for each position $(x, y, z)$,

- $vc(F)(x, y, z) = mat(3x+2y; y + z; x+y+z)$ ... a function that assigns a vector value $vc(F)$ for each position $(x, y, z)$,

and they are called #keyword[scalar field] and #keyword[vector field], respectively. Or, more formally,


#definition(title: "Scalar field and Vector field")[
  #no-shift[$
    "A" #keyword[scalar field] "is a function" f: RR^3 -> RR, quad (x,y,z) |-> f(x,y,z).
  $]
  #no-shift[$
    "A" #keyword[vector field] "is a function" vc(F): RR^3 -> RR^3, quad (x,y,z) |-> vc(F)(x,y,z) = mat(F_1 (x,y,z); F_2 (x,y,z); F_3 (x,y,z)).
  $]
  They assign a scalar or a vector, respectively, to every point in some region of the space.
]<def:field>

Here we have used a mathematical notation, $f: RR^3 -> RR$, which means $f$ accepts an element of $RR^3$ and returns an element of $RR$.
For physicists, however, it is more important to notice the physical meaning: $f(x,y,z)$ and $vc(F)(x,y,z)$ *assigns* some value to each point. For example...

#quizzes[
  + Choose scalar fields. Choose vector fields.
    #h-enum(cols: 2)[
      + Velocity of a car
      + Wind velocity in Kaohsiung
      + Water velocity in a sea
      + PM2.5 density in Kaohsiung air
      + Air temperature in a room
      + Age of people in Kaohsiung
      + Population in cities in Taiwan
      + Air pressure in the atmosphere
      + Electric field in a space
      + Voltage at points in a circuit
    ]
]
Among them, wind velocity in a city, water velocity in a sea, and electric field in a space are vector fields; PM2.5 density and air temperature, and air pressure are scalar fields.
Velocity of a car is a vector but not a vector field since it is just for a single point, not for every point in a space.
Similarly, age of people, population of cities, and voltage at points in a circuit are scalars but not scalar fields.

#quizzes[
  + #kill-line()
    + Assume $vc(F)(x,y,z)$ is a vector field. How about its $x$-component $F_1(x,y,z)$? #hint[It is a scalar field. Explain why.]
    + How about "wind speed in Kaohsiung"? Is it a scalar field or a vector field?
]
#definition(title: "Fields and Position vectors")[
  For a field, we often use position vector $vc(r)$ to express the input numbers:

  - a scalar field $f(x,y,z)$ is also written $f(vc(r))$.
  - a vector field $vc(F)(x,y,z)$ is also written $display(vc(F)(vc(r)))$, $display(mat(F_1\(vc(r)\); F_2\(vc(r)\); F_3\(vc(r)\)))$, or $display(mat(F_1(x,y,z); F_2(x,y,z); F_3(x,y,z))).$

  In addition, we often write $F_x$, $F_y$, $F_z$ instead of $F_1$, $F_2$, $F_3$. So,

  - a vector field $vc(F)(x,y,z)$ is written $display(vc(F)(vc(r)))$, $display(mat(F_x\(vc(r)\); F_y\(vc(r)\); F_z\(vc(r)\)))$, or $display(mat(F_x (x,y,z); F_y (x,y,z); F_z (x,y,z))).$
]

#be-careful[
  Do not confuse the two "$x$"s in $F_x (x,y,z)$. The first $x$ is just a function name ($=F_1$), while the second $x$ is a variable: the $x$-coordinate of a position. In other words,
  #RED[$vc(F)(5,7,9)=mat(F_5 (5,7,9); F_7 (5,7,9); F_9 (5,7,9))$] is incorrect, but
  $vc(F)(5,7,9)=mat(F_x (5,7,9); F_y (5,7,9); F_z (5,7,9))$.
]


#advanced-note(breakable: false)[
  In mathematics, we use the following notation to express a function $f$:
  #{
    set text(top-edge: "cap-height", bottom-edge: "baseline")
    writings(
      box: (true, false, true),
      align: horizon,
      column-gutter: 1em,
      grid(
        columns: 5,
        align: center + top,
        column-gutter: 2mm,
        row-gutter: 2mm,

        $f:$, $RR^3$, $-->$, $RR$, none,
        none, rotate(-90deg, $in$), [], rotate(-90deg, $in$), none,
        none, $vc(r)$, $arrow.r.long.bar$, $f(vc(r))$, $= |vc(r)|^2$,
      ),
      "or equivalently,",
      $f: RR^3 --> RR, quad vc(r) arrow.r.long.bar f(vc(r))=|vc(r)|^2.$,
    )
  }
  This means that the function $f$
  - can accept any element of $RR^3$ as an input,
  - returns an element of $RR$ as an output,
  - returns $f(vc(r))=|vc(r)|^2$ if an input $vc(r) in RR^3$ is given.
  As declared, the output $|vc(r)|^2$ is an element of $RR$.

  In general, for a function $f: A-->B$, we call $A$ the #keyword[domain]; $f$ needs to accept any elements of $A$.
  Meanwhile, the output does not have to cover all of $B$, but a subset of $B$, called #keyword[image].
  For example, if we consider $h(x) = x^(-2)$, we cannot write $h: RR --> RR$ because we cannot accept $x=0$. Instead, we write
  #no-num[$h: RR without {0} --> RR, quad x arrow.r.long.bar x^(-2) .$]
  The #EMPH[domain] of $h$ is $RR without {0}$ and the #EMPH[image] is $RR^+ = {y in RR | y>0}$ since $1\/x^2$ is always positive.
]


#problems[
  + `1` Assume $x in RR$ and $z in CC$. Write the following functions as given in the first box of the above "advanced note". Find its domain and image.

    #h-enum(cols: 6)[
      + $x^2$
      + $ln(x)$
      + $sqrt(x)$
      + $(x+2)^2$
      + $overline(z^2)$
      + $|z|^2$
    ]
]


= Gradient, Divergence, Curl, and Laplacian <sec:vc-nabla>
We can analyze scalar and vector fields by derivatives and integrals.
For derivatives, the following operations are useful.
#definition(title: "Gradient")[
  #let pdv(f, x) = $partial #f\/partial #x$
  For a scalar field $f: RR^3 -> RR$, the #keyword[gradient] of $f$, #writing[$grad f$] or #writing[$nab f$], is defined by
  $
    grad f := mat(pdv(f, x); pdv(f, y); pdv(f, z)) = mat(px f; py f; pz f).
  $<eq:vc-grad-def>
]<def:gradient>
#quizzes[
  + #kill-line()
    + In this definition, we did not write the argument $(x,y,z)$ for simplicity. Write the equation @eq:vc-grad-def with the argument $(x,y,z)$ explicitly.
    + $grad f$ is a vector field. Explain why.
    + Let $f(x,y,z)=x(x+y)^2 + 2z$. Calculate $grad f$. Also, calculate $grad f$ at the origin $(0,0,0)$.
]

#definition(title: "Divergence and Curl")[
  For a vector field $vc(F): RR^3 -> RR^3$, the #keyword[divergence], #writing[$div vc(F)$] or #writing[$nab dot vc(F)$], is defined by
  $
    div vc(F) := pdv(F_x, x) + pdv(F_y, y) + pdv(F_z, z) = sum_(k=1)^3 partial_k F_k
  $<eq:vc-div-def>
  and the #keyword[curl], #writing[$curl vc(F)$] or #writing[$nab times vc(F)$], is defined by
  #let pdv(f, x) = $partial #f\/partial #x$
  $
    curl vc(F) := mat(pdv(F_z, y) - pdv(F_y, z); pdv(F_x, z) - pdv(F_z, x); pdv(F_y, x) - pdv(F_x, y)) = mat(py F_z - pz F_y; pz F_x - px F_z; px F_y - py F_x).
  $<eq:vc-curl-def>
  Curl is also called #keyword(display: "rotation (vector calculus)")[rotation] and written by #writing[$op("rot") vc(F)$] in some textbooks.
]<def:div-curl>
#quizzes[
  + #kill-line()
    + Again, write @eq:vc-div-def and @eq:vc-curl-def with the argument $(x,y,z)$ explicitly.
    + $grad f$ is a vector field. How about $div vc(F)$ and $curl vc(F)$?
    + Let $vc(F)(x,y,z)=mat(x^2+y^2; x y z; z^2)$. Calculate $div vc(F)$ and $curl vc(F)$. Also, calculate $div vc(F)$ and $curl vc(F)$ at the point $(1,1,1)$.
]

#definition(title: "Laplacian")[
  #let pdv0(f, x) = $partial_#x #f$
  #let pdv2(f, x) = $partial^2_#x #f$
  #let lp(f) = $pdv2(#f, x) + pdv2(#f, y) + pdv2(#f, z)$
  For a scalar field $f(vc(r))$, the #keyword[Laplacian] of $f$, #writing[$laplace f$] or #writing[$nabla^2 f$], is defined by
  $
    laplace f := div(grad f) = div mat(pdv0(f, x); pdv0(f, y); pdv0(f, z)) = lp(f).
  $<eq:vc-laplacian-scalar>
  We may also consider laplacian for a vector field $vc(F)$:
  $
    laplace vc(F) := mat(laplace F_x; laplace F_y; laplace F_z)=
    mat(lp(F_x); lp(F_y); lp(F_z)).
  $<eq:vc-laplacian-vector>
]<def:laplacian>
#quizzes[
  + #kill-line()
    + Again, write @eq:vc-laplacian-scalar with the argument $(x,y,z)$ explicitly.
    + Calculate $div(grad f)$ and check that it is equal to $px^2 f + py^2 f + pz^2 f$.
    + Calculate $laplace f$ for $f(x,y,z)=x(x+y)^2 + z^2$.
]
We are going to analyze the properties of these operations and their physical meanings, but before that, we prepare some notations in the next section.

= Kronecker, Levi-Civita, and Nabla <sec:vc-index>
In @chap:matrix we defined the #keyword[Kronecker delta] (see @eq:mat-kronecker)
#no-num[$
  delta_(i j) := cases(1 "if" i=j",", 0 "if" i !=j",") quad "where " i, j in {1,2,3} quad #text[(recall that we are focusing on $RR^3$).]
$]
Here we introduce the #keyword[Levi-Civita symbol] $epsilon_(i j k)$:
$
  & epsilon_(1 2 3) = epsilon_(2 3 1) = epsilon_(3 1 2) = +1, \
  & epsilon_(1 3 2) = epsilon_(2 1 3) = epsilon_(3 2 1) = -1, \
  & epsilon_(i j k) = 0 "if any two indices are equal".
$
#quizzes[
  + Calculate the following.
    #h-enum(cols: 5)[
      + $epsilon_(123)$
      + $epsilon_(321)$
      + $display(sum_(a=1)^3 epsilon_(a 2 3))$
      + $display(sum_(a=1)^3sum_(b=1)^3 epsilon_(a b 3))$
      + $display(sum_(a=1)^3 a^2delta_(2 a))$
    ]
    #fail-safe[Just expand the summation: $sum_(a=1)^3 epsilon_(a 2 3) = epsilon_(1 2 3) + epsilon_(2 2 3) + epsilon_(3 2 3)$.]
]

#block(breakable: false)[
  This symbol allows us to write the cross product in a simple way:
  $
    vxp(A, B) = sum_(i=1)^3sum_(j=1)^3sum_(k=1)^3 epsilon_(i j k) vc(e)_i A_j B_k
  $<vc:vxp-levi-1>
  or, considering the $i$-th component of $vxp(A, B)$,
  $
    \(vxp(A, B)\)_i = sum_(j=1)^3 sum_(k=1)^3 epsilon_(i j k) A_j B_k.
    wide("very similar to" vip(A, B) = sum_(j=1)^3 sum_(k=1)^3 delta_(j k) A_j B_k.)
  $<vc:vxp-levi-2>
]
#proof[
  According to @def:va-comp, the $i$-th component of $vc(v)$ is given by $v_i = vc(e)_i dot vc(v)$; here $i=1, 2, 3$ means $i=x,y,z$, respectively.
  So, the $i$-th component of $vxp(A, B)$ is given by
  #no-num[$
    \(vxp(A, B)\)_i & = vc(e)_i dot (sum_(p=1)^3sum_(j=1)^3sum_(k=1)^3 epsilon_(p j k) vc(e)_p A_j B_k)
                      = sum_(p=1)^3sum_(j=1)^3sum_(k=1)^3 epsilon_(p j k) (vc(e)_i dot vc(e)_p) A_j B_k
                      = sum_(p=1)^3sum_(j=1)^3sum_(k=1)^3 epsilon_(p j k) delta_(i p) A_j B_k \
                    & = sum_(j=1)^3sum_(k=1)^3 epsilon_(i j k) A_j B_k. qed
  $]
]
#quizzes[
  + #kill-line()
    + Show @vc:vxp-levi-1. #hint[Just expand the right-hand side!]
    + Show @vc:vxp-levi-2. The proof is given above, but can you do it by yourself?
]

The Levi-Civita symbol satisfies the following identities:
#theorem(title: "Properties of Levi-Civita symbol")[
  #v-enum(cols: (1fr, 0.7fr), label-style: "(A)")[
    + $epsilon_(a b c) =
      epsilon_(b c a) =
      epsilon_(c a b) =
      -epsilon_(c b a) =
      -epsilon_(b a c) =
      -epsilon_(a c b)$
    + $display(sum_(i=1)^3 epsilon_(i a b) epsilon_(i x y) = delta_(a x) delta_(b y) - delta_(a y) delta_(b x).)$
    + $display(sum_(i,j=1)^3 epsilon_(i j a) epsilon_(i j x) = 2delta_(a x).)$
    + $display(sum_(i,j,k=1)^3 epsilon_(i j k) epsilon_(i j k) = 6.)$
    + $display(
        epsilon_(a b c)epsilon_(x y z)
        = det mat(
          delta_(a x), delta_(a y), delta_(a z); delta_(b x), delta_(b y), delta_(b z); delta_(c x), delta_(c y), delta_(c z)
        )
      )$
    + $display(
        epsilon_(a b c)
        = det mat(
          delta_(a 1), delta_(a 2), delta_(a 3); delta_(b 1), delta_(b 2), delta_(b 3); delta_(c 1), delta_(c 2), delta_(c 3)
        )
      )$
  ]]<thm:vc-levi-civita>
#quizzes[
  + #kill-line()
    + Simplify the following expressions:
      #h-enum(cols: 2)[
        + $epsilon_(123)delta_(11)+epsilon_(121)delta_(11)$
        + $sum_(a=1)^3 epsilon_(1 2 a) (delta_(1 a)+delta_(a 3))$
        + $sum_(a=1)^3 epsilon_(1 3 a) epsilon_(1 3 a)$
        + $epsilon_(a b c) - epsilon_(b a c) +2epsilon_(c b a)$
        + $sum_(a=1)^3 epsilon_(a x y) (delta_(a x) + delta_(a y) + delta_(a b))$
        + $sum_(a=1)^3 epsilon_(a b c) epsilon_(a 2 3)$
      ]
]

#problems[
  + `2` #kill-line()
    + Prove #thick-sf[(A)]--#thick-sf[(D)] of @thm:vc-levi-civita.
    + Show that $det M = sum_(i,j,k=1)^3 epsilon_(i j k) M_(1 i) M_(2 j) M_(3 k)$ for a $3 times 3$ matrix $M in CC^(3,3)$.
    + Show #thick-sf[(E)]. #hint[Use #thick-sf[(2)]. What $M$ should we use?]
    + Show #thick-sf[(F)]. #hint[Substitute #thick-sf[(E)] with $x=1$, $y=2$, $z=3$.]

  + `9`
    + $display(sum_(a=1)^3sum_(b=1)^3 delta_(a b))$
    + $display(sum_(a=1)^3sum_(b=1)^3 a delta_(a b))$
    + $display(sum_(a=1)^3sum_(b=1)^3 |epsilon_(a b 3)|)$
]

#advanced-note[
  The Levi-Civita symbol is related to the sign of a #keyword[permutation].
  A permutation is a rearrangement of elements in a list $(1,2,...,n)$, such as $(1234)->(4132)$.
  The simplest permutations are transpositions, a swap of two elements with the rest unchanged, such as $(1234)->(1432)$. Any permutation can be decomposed into a sequence of transpositions, and although neither the decomposition nor the number of transpositions is unique, it always turns out that the number is either always even or always odd.
  So, we can define the "sign" of a permutation $sigma$ as $op("sgn")sigma = +1$ $(-1)$ for an even (odd) permutation. Then,  can define the Levi-Civita symbol by $epsilon_(i j k) = op("sgn")sigma_((123)->(i j k))$.
]

With the above properties, it is easy to prove the following:

#let vt0(a, b) = $\(vc(#a) times vc(#b)\)$
#let vip0(a, b) = $\(vip(#a, #b)\)$
#theorem(title: "Properties of Levi-Civita symbol")[
  #v-enum(cols: 1, label-style: "(1)", v-sep: 2em)[
    + $vc(A) dot vt0(B, C) = vc(B) dot vt0(C, A) = vc(C) dot vt0(A, B)$ #h(2em) (scalar triple product)
    + $vc(A)times vt0(B, C) = vip0(A, C)vc(B)-vip0(A, B)vc(C)$ #h(2em) (vector triple product)
    + $vc(A) times vt0(B, C)
      +vc(B) times vt0(C, A)
      +vc(C) times vt0(A, B)=0$ #h(2em) (Jacobi identity)

  ]]<thm:vc-inner-cross>
#proof[
  #thick-sf[(1)] is obvious (why?) once we write $vc(A) dot vt0(B, C) = sum A_i vt0(B, C)_i = sum A_i epsilon_(i j k) B_j C_k$. For #thick-sf[(2)], we write
  #no-num[$
    vc(A)times vt0(B, C)
    = sum epsilon_(i j k) A_i vt0(B, C)_j vc(e)_k
    = sum epsilon_(i j k) A_i (epsilon_(j l m) B_l C_m) vc(e)_k
  $]
  using #thick-sf[(B)] of @thm:vc-levi-civita, and then use #thick-sf[(D)] of @thm:vc-levi-civita:
  #no-num[$
    sum epsilon_(i j k) A_i (epsilon_(j l m) B_l C_m) vc(e)_k
    = sum epsilon_(j k i) A_i (epsilon_(j l m) B_l C_m) vc(e)_k
    = sum (delta_(k l)delta_(i m)- delta_(k m)delta_(i l)) A_i B_l C_m vc(e)_k;
  $]
  so, please continue and complete these proofs in the next problems.
]
#problems[
  + `4` Using @thm:vc-levi-civita, prove #thick-sf[(A)] and #thick-sf[(B)] of @thm:vc-inner-cross.
  + `2` Prove #thick-sf[(C)] of @thm:vc-inner-cross. Also, prove
    $
      vt0(A, B) dot vt0(C, D) = vip0(A, C)vip0(B, D)-vip0(A, D)vip0(B, C).
    $
]

We also introduce one more notation, called #keyword[nabla]:
$
  nab = mat(partial_x; partial_y; partial_z)
  quad "with an abbreviation" quad
  partial_x = pdv(, x), quad
  partial_y = pdv(, y), quad
  partial_z = pdv(, z).
$
This notation is helpful to recall the definitions of gradient, divergence, and curl:
#no-num[$
  & grad f = mat(partial_x f; partial_y f; partial_z f) = nab f, wide
    div vc(F) = partial_x F_x + partial_y F_y + partial_z F_z = nab dot vc(F), wide
    curl vc(F) = nab times vc(F).
$]
#be-careful[
  Like $px$, $py$, and $pz$, we can understand $grad$, $div$, and $curl$ as operators. Meanwhil, it is a bit dangerous to regard $nab$ itself as an operator; Sho recommends you to consider it a "symbol" or "way of writing". Also, please _do not_ think $nab$ is a vector. It just looks like a vector, but it is not!

  However, the $nab$-notation is often abused, such as $\(vc(A) dot nab\)$: we can understood it as
  #no-num[$
    \(vc(A) dot nab\) f = mat(A_x; A_y; A_z) dot [mat(partial_x; partial_y; partial_z)f]
    = vc(A) dot \(nab f\) = A_x partial_x f + A_y partial_y f + A_z partial_z f,
  $]
  but sometimes you may be confused by such abuse.
  In general, when you see $nab$, you should carefully identify the author's intention.
]
We can express them in terms of Kronecker delta and Levi-Civita symbol:
#theorem[
  For a scalar field $f$ and a vector field $vc(F)$,
  $
    &grad f = sum_i vc(e)_i partial_i f, wide&
    &div vc(F) = sum_i partial_i F_i, wide&
    &curl vc(F) = sum_(i, j, k) epsilon_(i j k)vc(e)_i partial_j F_k,\
    &\(grad f)_i = partial_i f,&&&
    &\(curl vc(F)\)_i = sum_(j, k) epsilon_(i j k)partial_j F_k.
  $<eq:vc-nabla-in-component>
]
#quizzes[
  + Check @eq:vc-nabla-in-component. #hint[You just expand all the terms.]
]


Now, we are going to combine all the above to understand the properties and physical meanings of gradient, divergence, curl, and Laplacian.

= Geometrical Interpretations <sec:vc-geometrical>

First, let us recall what are the input and output types of the vector-calculus operators.
#theorem(type: "Summary", title: "Type rules for vector-calculus operators")[
  - #box(width: 2.2em)[$grad$] turns a scalar field into a vector field.
  - #box(width: 2.2em)[$div$] turns a vector field into a scalar field.
  - #box(width: 2.2em)[$curl$] turns a vector field into a vector field.
  - #box(width: 2.2em)[$laplace$] turns a scalar field into a scalar field and a vector field into a vector field.
]
#example[
  Consider $vc(r) = mat(x; y; z)$, and let $r = va(r).$ Then, $r=sqrt(x^2+y^2+z^2)$ and

  #no-num[
    $
      grad 1/r = nm 1/sqrt(x^2+y^2+z^2) = mat(-x\/(x^2+y^2+z^2)^(3\/2); -y\/(x^2+y^2+z^2)^(3\/2); -z\/(x^2+y^2+z^2)^(3\/2)) = -vc(r)/r^3,
    $
  ]
  i.e., $nab(1\/r) = -vc(r)\/r^3$. In this calculation, $vc(r)$ is not a vector; rather, we should understand it as a vector field, which receives a position and returns a vector. Similarly, $r$ and $1\/r$ should be regarded as scalar fields.
  The operation "$grad$" turns a scalar field $1\/r$ to a vector field $-vc(r)\/r^3$.

  Similarly, we can calculate $div vc(r)$ and $curl vc(r)$:
  #no-num[
    $
      div vc(r) = pdv(x, x) + pdv(y, y) + pdv(z, z) = 1+1+1 = 3, quad curl vc(r) = vc(0).
    $
  ]
  These $3$ and $vc(0)$ are understood as constant fields returning $3$ and $vc(0)$ for any position, respectively.
]<ex:vc-grad>

#quizzes[
  + Let $vc(r) = mat(x; y; z)$, $r=va(r)$, and $vc(a)=mat(1; -1; 2)$. Calculate the following if defined:
    #h-enum(cols: 4)[
      + $grad (1\/r)$
      + $grad r^2$
      + $grad(vc(a) dot vc(r))$
      + $div vc(a)$
      + $div(vc(a) times vc(r))$
      + $curl(vc(a)times vc(r))$
      + $laplace(vc(r) dot vc(r))$
      + $laplace(1\/r)$
    ]
]

#make-indent
Consider a scalar function $f(x,y,z)$ and its gradient $(grad f)(x,y,z)$; recall $grad f$ is a vector field, which means $grad f$ for a given point $vc(p)$ is a vector.
#theorem(title: "Meaning of Gradient")[
  Consider a scalar field $f(vc(r))$. Its #keyword[gradient] at a point $vc(p)$, which we write $(grad f)(vc(p))$, is a vector with

  - direction: the direction in which $f$ increases fastest from the point.
  - magnitude: the fastest rate of the increase.

  Also, if we consider the _isosurface_ (the two-dimensional surface surface on which the value of $f(vc(x))$ is the same as $f(vc(p))$), then $(grad f)(vc(p))$ is perpendicular to the isosurface at the point $vc(p)$.
]
The isosurface is also called _equivalue surface_ or, in mathematics, _level surface_.

#grid(
  columns: (1fr, auto),
  column-gutter: 1.5em,
  align: (top + left, horizon + center),
  [
    #make-indent
    To understand gradient, it is easier to consider a scalar field which has no dependence on $z$.
    Then, $\(grad f\)_z=pz f=0$ and we can draw the vectors on the $x y$-plane, as in the figure to the right.
    There, the black contours show the isosurface of $f$, i.e., the value of $f$ is the same at all the point on each line.
    The arrows show $grad f$ at representative points.

    You should observe the following properties:

    - $f$ is smaller in the central region; larger in the outer area.
    - $grad f$ is always perpendicular to the isosurface.
    - $|grad f|$ is larger in the left-hand side than the right-hand side, which means the "slope" is steeper in the left-hand side.
  ],
  image("figures/8-vc-grad.pdf", width: 55mm),
)
#quizzes[
  #grid(
    columns: (1fr, auto),
    column-gutter: 1.5em,
    align: (top + left, horizon + center),
    [
      + The figure to the right shows $grad f$ for a scalar field $f(x,y,z)$ drawn on $x y$-plane.
        We assume that $f$ is independent of $z$, so that $grad f$ has no $z$-component.

        + Try to draw contour lines describing the isosurface of $f$.
        + At what point is $f$ the largest?
        + At what point is $f$ the smallest?

      + In @ex:vc-grad we got $nab(r^(-1)) = -vc(r)\/r^3$. Try to visualize this vector field, $-vc(r)\/r^3$.
    ],
    block(fill: white, image("figures/8-vc-grad-ex1.pdf", width: 55mm)),
  )
]
#be-careful[
  Vector calculus is always on the three-dimensional space, so your imagination is crucial.
  If you feel difficulties in 3D visualization, search for videos, animations, or interactive applications on the internet; they will help your imagination.
]

The divergence and curl are considered for a vector field $vc(F)$, and thus it is difficult to visualize them here.
Rather, it is important to notice when the divergence and curl are positive, negative, or zero.

#example[Consider the following vector fields. _Because we use the right-handed Cartesian coordinate system_, the $z$-axis is perpendicular to the page, running toward you.
  #v(1em)
  #import "figures/8-vc-vector-field.typ": draw-vector-field
  #let dvf(f) = align(center, [#v(-.5em) #draw-vector-field(f, length: 1.45cm, s: 0.8)])
  #grid(
    columns: (1fr, 1fr, 1fr, 1fr),
    align: left,
    row-gutter: 2em,
    column-gutter: 0mm,
    [#thick-sf[(A)]#h(1em)$vc(F) = mat(1.5; 0.7; 0)$\ #dvf((x, y) => (1.5, 0.7))],
    [#thick-sf[(B)]#h(1em)$vc(F) = mat(1.5; x; 0)$ \ #dvf((x, y) => (1.5, x))],
    [#thick-sf[(C)]#h(1em)$vc(F) = mat(x; y; 0)$ \ #dvf((x, y) => (x, y))],
    [#thick-sf[(D)]#h(1em)$vc(F) = mat(-x; -y; 0)$ \ #dvf((x, y) => (-x, -y))],

    [#thick-sf[(E)]#h(1em)$vc(F) = mat(-y; x; 0)$ \ #dvf((x, y) => (-y, x))],
    [#thick-sf[(F)]#h(1em)$vc(F) = mat(y; -x; 0)$ \ #dvf((x, y) => (y, -x))],
    [#thick-sf[(G)]#h(1em)$vc(F) = mat(x^2+y^2; 2x y; 0)$ \ #dvf((x, y) => (x * x + y * y, 2 * x * y))],
    [#thick-sf[(H)]#h(1em)$vc(F) = mat(x^2-y^2; 2x y; 0)$ \ #dvf((x, y) => (x * x - y * y, 2 * x * y))],
  )
  If you calculate $div vc(F)$, you should notice
  - #thick-sf[(A)] and #thick-sf[(B)] has no divergence.
  - #thick-sf[(C)] has positive divergence at every point of $x y$-plane.
  - #thick-sf[(D)] has negative divergence at every point of $x y$-plane.
  These #thick-sf[(C)] and #thick-sf[(D)] are the typical situations for positive and negative divergence, respectively.

  For curl, you should notice
  - #thick-sf[(A)], #thick-sf[(C)], and #thick-sf[(D)] has no curl.
  - For #thick-sf[(E)], $curl vc(F)=mat(0; 0; 2)=2vc(e)_z$. Meanwhile, #thick-sf[(F)] has  $curl vc(F)=mat(0; 0; -2)=-2vc(e)_z$.
  You see some _rotation_ in #thick-sf[(E)] and #thick-sf[(F)]. What is the direction of the rotations?
  If you recall that we use the right-hand rule to describe the rotation, you can observe that $curl vc(F)$ gives the direction of rotation.
]<ex:vc-div-curl>
These are the typical cases and you can guess the divergence and curl from the visualizations.
However, in general, it is difficult to see the divergence and curl.
As a first learner, you should focus on the following points:

#theorem(type: "Summary", title: "Geometric properties of divergence and curl")[
  - $"div"=0$ means the flow is conserved _at the point_, without any source or sink.
  - $"div">0$ means the point has a source; some flow is coming out from the point.
  - $"div"<0$ means the point has a sink; some flow is absorbed at the point.
  - $"curl"!=0$ means the vector field has some rotational motion. The rotation direction is given by the right-hand rule with respect to the direction of curl.
]
#quizzes[
  + Calculate $div vc(F)$ and $curl vc(F)$ for each vector field in @ex:vc-div-curl. Can you find the following features?
    - #thick-sf[(B)] has some rotational movement.
    - #thick-sf[(E)] and #thick-sf[(F)] has no source or sink in this region.
    - In #thick-sf[(G)] and #thick-sf[(H)], some regions have sources of the flow and some regions have sinks of the flow.
    - In #thick-sf[(H)], there is one region that has a rotational movement, and there is another region that has a rotational movement in the opposite direction of the first region. Meanwhile, #thick-sf[(G)] has no rotational movement.
]

#theorem(title: "Vanishing combination")[
  $
    "For any scalar field" f, quad curl(grad f) = vc(0).\
    "For any vector field" vc(F), quad div\(curl vc(F)\)= 0.
  $
]
#quizzes[
  + Prove this theorem. You may assume $px py f=py px f$, etc.
]
#advanced-note[
  The equality $partial_i partial_j f = partial_j partial_i f$ holds because we have assumed the fields are in class $C^2$.
]

#block(breakable: false)[
  = Formulae in Vector calculus <sec:vc-formulae>
  Since $grad f$ is a vector field, we can apply "div" and "curl" to it; but then what will happen?
  #theorem(title: "Double derivatives")[
    For a scalar field $f$ and a vector field $vc(F)$,
    #grid(columns: (1fr, 1.5fr))[
      - #box(width: 4.5em, "curl grad:") $nab times \(nab f\)= vc(0)$.

      - #box(width: 4.5em, "div curl:")  $nab dot \(nab times vc(F)\) = 0$.
    ][
      - #box(width: 4.5em, "div grad:") $nab dot \(nab f\) = laplace f = px^2 f + py^2 f + pz^2 f.$

      - #box(width: 4.5em, "grad div:") $nab\(nab dot vc(F)\) = mat(
          px(px F_x+py F_y+pz F_z);
          py(px F_x+py F_y+pz F_z);
          pz(px F_x+py F_y+pz F_z)
        )$.
      - #box(width: 4.5em, "curl curl:") $nab times \(nab times vc(F)\) = nab \(nab dot vc(F)\)-laplace vc(F)$.

    ]
  ]
]

#quizzes[
  + We have three operations (div, curl, grad), so nine combinations are possible, but only the five are listed above. Why are the remaining four not shown?
  + Show the above five equations.
    #fail-safe(
      indent: false,
    )[Use @eq:vc-nabla-in-component. Notice that $vc(e)_i$ is a constant, so $partial_i vc(e)_j=vc(0)$.
    ]
]

We may have other formulae such as
#block[
  #let Div = $nab dot$
  #let DIV(x) = $Div vc(#x)$
  #let Cur = $nab times$
  #let CUR(x) = $Cur vc(#x)$
  #show "(": "("
  #show ")": ")"

  $ nab(f g) = f nab g + g nab f $<eq:vc-chain1>
  $ Div(f vc(F)) = f thick DIV(F) + (nab f) dot vc(F) $<eq:vc-chain2>
  $ Cur(f vc(F)) = f thick CUR(F) + (nab f) times vc(F) $<eq:vc-chain3>
  $ Div(vxp(F, G))= (CUR(F)) dot vc(G) - vc(F)dot (CUR(G)) $<eq:vc-chain4>
]
but usually you will not need them; instead, it is better to use @eq:vc-nabla-in-component and the chain rule.

#example[
  Recalling $\(vxp(F, G)\)_i=epsilon_(i j k)F_j G_k$, we can calculate
  #no-num[$
    nab dot \(vxp(F, G)\)
    = sum partial_i \(vxp(F, G)\)_i
    = sum partial_i \(epsilon_(i j k)F_j G_k\)
    = sum epsilon_(i j k)[(partial_i F_j)G_k + F_j (partial_i G_k)].
  $]
  Then, looking at @eq:vc-nabla-in-component carefully, we may obtain
  $sum epsilon_(i j k)(partial_i F_j)G_k = sum (curl F)_k G_k$
  and $sum epsilon_(i j k)F_j (partial_i G_k) = -sum F_j (curl G)_j$, which leads to
  #no-num[$
    nab dot \(vxp(F, G)\) = \(nab times vc(F)\)dot vc(G) - vc(F) dot \(nab times vc(G)\).
  $]

  Similarly, we can expand $nab times \(vxp(F, G)\)$ by
  #no-num[$
    \[nab times \(vxp(F, G)\)\]_a & = sum epsilon_(a b c) partial_b \(vxp(F, G)\)_c \
    & = sum epsilon_(a b c) partial_b \(epsilon_(c j k) F_j G_k\) \
    & = sum epsilon_(c a b)epsilon_(c j k) [\( partial_b F_j\) G_k + F_j \(partial_b G_k\)]\
    & = sum (delta_(a j)delta_(b k) - delta_(a k)delta_(b j)) [\( partial_b F_j\) G_k + F_j \(partial_b G_k\)]\
    & = sum [\( partial_b F_a\) G_b + F_a \(partial_b G_b\) - \( partial_b F_b\) G_a - F_b \(partial_b G_a\)]\
    & = sum [\( partial_b F_a\) G_b + F_a \(nab dot vc(G)\) - \(nab dot vc(F)\) G_a - F_b \(partial_b G_a\)].
  $]
]<ex:vc-component-wise-expansion>
#problems[
  + `4` Repeating @ex:vc-component-wise-expansion, prove @eq:vc-chain1 -- @eq:vc-chain4.
]


#example(title: "Divergence of the position field")[
  Compute $nabla dot vc(r)$ for $vc(r) = (x,y,z)^TT$.
]
#solution[
  $
    nabla dot vc(r) = pdv(x, x) + pdv(y, y) + pdv(z, z) = 1+1+1 = 3.
  $<eq:vc-div-r>
  Every point in space is a source: the field $vc(r)$ points away from the origin everywhere and grows in magnitude, so it "spreads out" at every point, consistently with the constant, positive divergence.
]

#example(title: "Curl of the position field")[
  Compute $nabla times vc(r)$ for $vc(r) = (x,y,z)^TT$.
]
#solution[
  $
    (nabla times vc(r))_x = pdv(z, y) - pdv(y, z) = 0-0=0,
  $<eq:vc-curl-r>
  and the other two components vanish the same way, since each component of $vc(r)$ depends on only one coordinate. So $nabla times vc(r) = vc(0)$: the position field does not rotate around any point, which matches the intuition that $vc(r)$ points straight out from the origin everywhere, with no swirl.
]


$nabla^2 f$ is a scalar field: it is the divergence of the gradient, i.e. "the gradient of $f$, then take its divergence." It appears everywhere in physics: the diffusion equation, the wave equation, and Laplace's equation $nabla^2 V = 0$ for the electric potential in charge-free regions all use it.


#example(title: "Laplacian of $1/r$")[
  Show that $nabla^2 (1\/r) = 0$ for $r != 0$.
]
#solution[
  $nabla(1\/r) = -vc(r)\/r^3$, with components $-x\/r^3, -y\/r^3, -z\/r^3$. Differentiate the $x$-component again with respect to $x$ (using the product rule, since $r$ depends on $x$):
  $
    pdv((), x) (-x/r^3) = -1/r^3 - x dot (-3) r^(-4) pdv(r, x) = -1/r^3 + (3x)/r^4 dot x/r = -1/r^3 + (3x^2)/r^5,
  $
  using $pdv(r, x) = x\/r$ (same calculation as in the gradient example, applied to $r$ itself instead of $1\/r$). Summing the analogous results for $y$ and $z$:
  $
    nabla^2 (1/r) = -3/r^3 + (3(x^2+y^2+z^2))/r^5 = -3/r^3 + (3r^2)/r^5 = -3/r^3+3/r^3 = 0,
  $
  for all $vc(r) != vc(0)$. This fact is the mathematical heart of why the electric potential of a point charge solves Laplace's equation everywhere except at the charge itself.
]

#quizzes[
  + `4` For $f(x,y,z) = x^2 y + z$, compute $nabla f$.
  + `4` For $vc(F) = (x^2, y^2, z^2)^TT$, compute $nabla dot vc(F)$.
  + `4` For $vc(F) = (-y,x,0)^TT$, compute $nabla times vc(F)$. What direction does the curl point in, and what does that tell you about the rotation of this field?
  + `4` True or false: $nabla dot vc(F)$ is a vector field. #hint[Check @def:div-curl again.]
]

#problems[
  + `4` Compute $nabla f$, $nabla dot vc(F)$, $nabla times vc(F)$, and $nabla^2 f$ for $f = x y z$ and $vc(F) = (y z, x z, x y)^TT$.
  + `3` Show directly (without using thm:curl-grad-zero) that $nabla times (nabla f) = vc(0)$ for $f(x,y,z) = x^3 y^2 + sin(z)$, by computing both $nabla f$ and its curl.
  + `3` Let $vc(F) = vc(r)\/r^3$ for $vc(r) != vc(0)$. Show $nabla dot vc(F) = 0$ for $r != 0$. #hint[This is the divergence-free electric field of a point charge, away from the charge itself.]
  + `2` Compute $nabla^2 f$ for $f = ln r$ (with $r = sqrt(x^2+y^2)$, i.e. treat this as a field on $RR^2$, ignoring $z$), and comment on where it is undefined.
  + `9` (drill: which operator, which output type) For each expression below, state whether it is defined, and if so, whether the result is a scalar field or a vector field: (a) $nabla f$, (b) $nabla times f$, (c) $nabla dot vc(F)$, (d) $nabla times (nabla dot vc(F))$, (e) $nabla (nabla dot vc(F))$, (f) $nabla dot vc(F) times nabla g$.
]





#be-careful[
  A very common slip is to write $vc(a) times (vc(b) times vc(c)) = (vc(a) times vc(b)) times vc(c)$, i.e. to assume the cross product is associative.
]

#problems[
  + `4` Compute $vc(a) times vc(b)$ for $vc(a) = (1,0,2)^TT$ and $vc(b) = (0,3,-1)^TT$ using eq:vc-cross-index directly (sum over $j,k$ by hand for each $i$), then check against the determinant formula from @chap:matrix.
  + `3` Prove the scalar triple product formula $vip(a, (vc(b) times vc(c))) = sum_(i,j,k) eps_(i j k) a_i b_j c_k$, and use it to show $vip(a, (vc(b) times vc(c))) = vip((vc(a) times vc(b)), c)$.
  + `2` Use thm:eps-delta to prove Lagrange's identity $va(vc(a) times vc(b))^2 = va(vc(a))^2 va(vc(b))^2 - vip(a, b)^2$.
  + `9` (drill: reading $eps$) Evaluate without a table: (a) $eps_(132)$, (b) $eps_(313)$, (c) $eps_(321)$, (d) $eps_(111)$.
  + `9` (drill: contracting one index) Simplify each sum: (a) $sum_k eps_(i j k) delta_(j k)$, (b) $sum_(j,k) eps_(i j k) eps_(l j k)$. #hint[For (b), use thm:eps-delta and then set $m=k$, summing over $k$ at the end.]
]


#theorem(title: "Vector calculus identities")[
  $
    nabla times (nabla f) &= vc(0) & #[(proved above, thm:curl-grad-zero)] \
    nabla dot (nabla times vc(F)) &= 0 & #[(proved above, thm:div-curl-zero)] \
    nabla (f g) &= f nabla g + g nabla f & \
    nabla dot (f vc(F)) &= f (nabla dot vc(F)) + vc(F) dot (nabla f) & \
    nabla times (f vc(F)) &= f (nabla times vc(F)) + (nabla f) times vc(F) & \
    nabla (vip(A, B)) &= (vc(A) dot nabla) vc(B) + (vc(B) dot nabla) vc(A) + vc(A) times (nabla times vc(B)) + vc(B) times (nabla times vc(A)) & \
    nabla dot (vc(A) times vc(B)) &= vc(B) dot (nabla times vc(A)) - vc(A) dot (nabla times vc(B)) & \
    nabla times (vc(A) times vc(B)) &= vc(A) (nabla dot vc(B)) - vc(B) (nabla dot vc(A)) + (vc(B) dot nabla) vc(A) - (vc(A) dot nabla) vc(B) & \
    nabla^2 vc(F) &= nabla (nabla dot vc(F)) - nabla times (nabla times vc(F)). &
  $<eq:vc-identities>
]<thm:vc-identities>
Here $(vc(A) dot nabla)$ denotes the scalar differential operator $A_x pdv((), x) + A_y pdv((), y) + A_z pdv((), z)$, applied componentwise to the vector field that follows it; it is *not* the same object as $nabla dot vc(A)$ (a scalar field), so keep the parentheses.

#quizzes[
  + `4` Using the fourth identity in @eq:vc-identities, simplify $nabla dot (r^2 vc(r))$ where $r = va(vc(r))$, given that $nabla dot vc(r) = 3$ (@eq:vc-div-r) and $nabla (r^2) = 2 r nabla r = 2vc(r)$.
  + `4` Why does the identity $nabla^2 vc(F) = nabla(nabla dot vc(F)) - nabla times (nabla times vc(F))$ make sense dimensionally, i.e. why is each side a vector field, not a scalar field?
]

#problems[
  + `3` Prove $nabla dot (f vc(F)) = f (nabla dot vc(F)) + vc(F) dot (nabla f)$ for the specific fields $f = x^2+y^2$ and $vc(F) = (z,z,x+y)^TT$: compute both sides directly and check they agree.
  + `2` Prove the identity $nabla dot (vc(A) times vc(B)) = vc(B) dot (nabla times vc(A)) - vc(A) dot (nabla times vc(B))$ using index notation (write $nabla dot (vc(A) times vc(B)) = sum_i pdv((), x_i) sum_(j,k) eps_(i j k) A_j B_k$, apply the product rule, and regroup).
  + `2` Use @eq:vc-identities to simplify $nabla times (f nabla f)$ (a curl of a field built from a single scalar field $f$). #hint[Which of the two terms in the fifth identity of @eq:vc-identities vanishes, and why?]
  + `1` Prove the identity $nabla times (vc(A) times vc(B)) = vc(A)(nabla dot vc(B)) - vc(B)(nabla dot vc(A)) + (vc(B) dot nabla) vc(A) - (vc(A) dot nabla) vc(B)$ using thm:eps-delta.
  + `9` (drill: which identity to reach for) For each target expression, name which line of @eq:vc-identities you would use first: (a) $nabla times (r^2 vc(F))$, (b) $nabla dot (nabla times (nabla f))$ (careful, this one is a trick), (c) $nabla (f^2)$.
]


#pagebreak()

= More Topics are Waiting for You

We have completed the overview of the *derivative* operations in vector calculus.
You will use them in _electromagnetism_, but there you will also need *integral* operations.
We postpone the discussions to the course _Mathematics and Codings on Physics_ #JA[（物理數學與數值方法）], which you will take in the next semester.

There, you will learn integrals about a scalar field $f(vc(r))$, such as
#no-num[$
    "line integral" integral f(vc(r)) dd s, quad
    "surface integral" integral.double f(vc(r)) dd A, quad
    "volume integral" integral.triple f(vc(r)) dd V,
  $
]
and define integrals about a vector field $vc(F)(vc(r))$:
#no-num[$
    "line integral" integral vc(F)(vc(r)) dot dd vc(s)
    , quad
    "surface integral" integral.double F(vc(r)) dot dd vc(A).
  $
]
These integrals are used to describe the #keyword[Maxwell equations] in electromagnetism,
#block[

  #let rt = $\(vc(r),t\)$
  $
    &integral.double_(partial V) vc(E)rt dot dd vc(A) = integral.triple_V (rho rt)/epsilon_0 dd V,quad&
    &integral_(partial S) vc(E)rt dot dd vc(s) = integral.double_S (-pdv(vc(B)rt, t)) dot dd vc(A),\
    &integral.double vc(B)rt dot dd vc(A) = 0,&
    &integral_(partial S) vc(B)rt dot dd vc(s) = integral.double_S mu_0 [vc(J)rt + epsilon_0 pdv(vc(E)rt, t)]dot dd vc(A),
  $
  or more precisely,
  $
    & nab dot vc(E)rt = (rho rt)/epsilon_0,wide && nab times vc(E)rt = -pdv(vc(B)rt, t), \
    & nab dot vc(B)rt = 0,                      && nab times vc(B)rt = mu_0 vc(J)rt + mu_0 epsilon_0 pdv(vc(E)rt, t).
  $
  You will learn these equations are related by the #keyword[Gauss's theorem] and #keyword[Stokes' theorem],
  $
    integral.double_(partial V) vc(F) dot dd vc(A) = integral.triple_V (nab dot vc(F)) dd V,quad
    integral_(partial S) vc(F) dot dd vc(s) = integral.double_S (nab times vc(F)) dot dd vc(A).
  $
]

#divider()

You will also need the #keyword[cylindrical coordinates] $(r, theta, z)$ and the #keyword[spherical coordinates] $(r,theta, phi)$ to analyze the Maxwell equations.
They are related to the #keyword[Cartesian coordinates] $(x,y,z)$ by
$
  "cylindrical:" quad & (x, y, z) = (r cos theta, r sin theta, zeta), \
    "spherical:" quad & (x, y, z) = (r sin theta cos phi, r sin theta sin phi, r cos theta),
$
and then, as the biggest challenge, you will convert the gradient, divergence, curl, and Laplacian, as well as $dd S$ and $dd V$, into these coordinates.
#remark[Usually the cylindrical coordinate is written by $(r,theta,z)$ because $z=zeta$ is unchanged, but here we use $zeta$ (zeta) to avoid confusion.]

This document does not go into these advanced topics, but just in case you are motivated to prepare for the next course, several exercises are left below.

#problems[
  + `1` Consider the cylindrical coordinates $(r, theta, zeta)$.
    + The $3times 3$ matrix $J=display(jacobian(r, theta, zeta, x, y, z))$, which we often write by $partial(x, y, z) / partial(r, theta, zeta)$, is called the #keyword[Jacobian matrix] of the coordinate change $(r,theta,zeta)->(x,y,z)$ and its determinant $det J$ is called #keyword[Jacobian]. Compute $J$ and confirm that $det J=r$.
      #be-careful(indent: false)[
        Be aware that we here regard $(r,theta,zeta)$ as the "old" coordinate and $(x,y,z)$ as the "new" coordinate. So, $x$, $y$, and $z$ are functions of $(r, theta, zeta)$, and thus $J$ is a function of $(r,theta,zeta)$.
      ]
    + Express $(r, theta, zeta)$ in terms of $(x, y, z)$. This gives the inverse transformation, $(x,y,z)->(r,theta,zeta)$. #hint[Your answer will contain $arctan(x\/y)$, but what is "arctan"?]
    + Let us $J'=display(jacobian(x, y, z, r, theta, zeta))$, i.e., the Jacobian matrix for the inverse transformation $(x,y,z)->(r,theta,zeta)$. Calculate $J'$ and $det J'$.
    + Confirm $J J'=I_3$. It means $J'$ is the inverse matrix of $J$, and thus $det J'=1\/det J$.
  + `1` Do the same calculation for the spherical coordinates $(r, theta, phi)$.
    + Calculate $J = partial(x, y, z) / partial(r, theta, phi)$ and confirm that $det J=r^2 sin theta$.
    + Express $(r, theta, phi)$ in terms of $(x, y, z)$.
    + Calculate $J'=partial(r, theta, phi) / partial(x, y, z)$ and $det J'$. Confirm $JJ'=I_3$ by the direct calculation.
]
#advanced-note[
  The #keyword[Jacobian] $det J$ is used to transform integrals. With its *absolute value* $lr(|det J|)$,
  $
    integral.triple f(x,y,z) dd x dd y dd z = integral.triple f(x,y,z) lr(|det partial(x, y, z) / partial(r, theta, phi)|) dd r dd theta dd phi quad "etc."
  $
  (note the absolute-value symbol!), where $f(x,y,z)$ in the second expression is written in terms of $(r, theta, phi)$.
]
#problems[
  + `1` We here compute the derivative operators in the cylindrical coordinates $(r, theta, zeta)$. Let us begin with the gradient. It should be
    $ nab f = vc(e)_x px f + vc(e)_y py f + vc(e)_z pz f
    = vc(e)_r #JA[●] + vc(e)_theta #JA[▲] + vc(e)_zeta #JA[■] $ and we want to find the unknown expressions #JA[●], #JA[▲], and #JA[■].
    + Express $px f$, $py f$, and $pz f$ in terms of $partial_r f$, $partial_theta f$, and $partial_zeta f$.
      #fail-safe(indent: false)[
        As $x$ is a function of $(r, theta, zeta)$, the chain rule $pdv(, x) =pdv(r, x) pdv(, r) + pdv(theta, x) pdv(, theta) + pdv(zeta, x) pdv(, zeta)$ serves.
      ]
    + The difficulty is that the meaning of $vc(e)_r$, $vc(e)_theta$, and $vc(e)_zeta$.
      They should be the unit vectors forming an orthonormal basis and $vc(e)_r$ should points in the positive $r$-direction.
      However, the positive $r$-direction depends on the position $(x,y,z)$, so $vc(e)_r$ (and thus $vc(e)_theta$) depends on the position, as shown in @fig:vc-cylinder.

      For point P$(x,y,z)$ or $(r,theta,zeta)$, the unit vectors are given by
      $
        vc(e)_r = vc(e)_x cos theta + vc(e)_y sin theta, quad
        vc(e)_theta = -vc(e)_x sin theta+vc(e)_y cos theta,quad
        vc(e)_zeta = vc(e)_z.
      $
      Express them in the matrix form. Confirm this is consistent with @fig:vc-cylinder. Express $vc(e)_r$ and $vc(e)_theta$ without using $r$ and $theta$. Confirm $(vc(e)_r, vc(e)_theta, vc(e)_zeta)$ form an orthonormal basis and obey the right-hand rule.
      #advanced-note(indent: false)[
        In general, $vc(e)_X$ has the same direction as $pdv(vc(r), X)$. Namely, we can obtain the basis vectors by  normalizing
        $
          pdv(vc(r), r) = pdv(, r)mat(r cos theta; r sin theta; zeta) = mat(cos theta; sin theta; 0),quad
          pdv(vc(r), theta) = mat(-r sin theta; r cos theta; 0),quad"and"quad
          pdv(vc(r), zeta) = mat(0; 0; 1).
        $
        This method is useful for the spherical coordinates.
      ]
    + Express $vc(e)_x$, $vc(e)_y$, and $vc(e)_z$ only with $theta$, $vc(e)_r$, $vc(e)_theta$, and $vc(e)_zeta$.
    + Substitute the above expressions into $nab f = vc(e)_x px f + vc(e)_y py f + vc(e)_z pz f$ and reach
      $
        nab f = vc(e)_r pdv(f, r) + vc(e)_theta/r pdv(f, theta) + vc(e)_zeta pdv(f, zeta).
      $

  + `1` Let us consider divergence in cylindrical coordinates. As divergence is for a vector field
    $vc(F) = F_x vc(e)_x + F_y vc(e)_y + F_z vc(e)_z = F_r vc(e)_r + F_theta vc(e)_theta + F_zeta vc(e)_zeta,$
    we should use $F_r$, $F_theta$, and $F_zeta$ instead of $F_x$, $F_y$, and $F_z$.
    So, what we need to calculate is
    $
      nab dot vc(F) = (vc(e)_r partial_r + (vc(e)_theta\/r) partial_theta + vc(e)_zeta partial_zeta) dot (F_r vc(e)_r + F_theta vc(e)_theta + F_zeta vc(e)_zeta).
    $
    + Calculate $partial_r vc(e)_r$, $partial_r vc(e)_theta$, $partial_r vc(e)_zeta$, $partial_theta vc(e)_r$, $partial_theta vc(e)_theta$, $partial_theta vc(e)_zeta$, $partial_zeta vc(e)_r$, $partial_zeta vc(e)_theta$, and $partial_zeta vc(e)_zeta$.
    + Confirm $display(nab dot vc(F) = 1/r partial_r (r F_r) + 1/r partial_theta F_theta + partial_zeta F_zeta)$
    + Find $nab times vc(F)$ and $laplace f$. Compare your answer with online resources.
]

#import "figures/8-vc-cylinder.typ": cylinder-fig
#import "figures/8-vc-vector-field.typ": draw-vector-field-eig

#figure(caption: [
  (left) The cylindrical coordinates, where the position of point P is described by $(r, theta, zeta)$.
  (right) The basis vector, $(vc(e)_r, vc(e)_theta, vc(e)_zeta)$, of the cylindrical coordinates.
  Since the direction of $vc(e)_r$ and $vc(e)_theta$ depends on the position, they are drawn for each point, described by a gray dot; $vc(e)_r$ are drawn in black and $vc(e)_theta$ are drawn in red. Meanwhile, $vc(e)_zeta$ is a constant vector $mat(0; 0; 1)$. Notice that $(vc(e)_r, vc(e)_theta, vc(e)_zeta)$ forms an orthonormal basis and obeys the #keyword[right-hand rule].
])[#grid(
  columns: 2,
  align: center + bottom,
  column-gutter: 5%,
  cylinder-fig, draw-vector-field-eig(length: 2cm, s: 1),
)]<fig:vc-cylinder>
