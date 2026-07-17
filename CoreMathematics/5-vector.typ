#import "misho-text.typ": *
#import "physica.typ": *

// Vector notation: arrow over symbol
#let vc(v) = $accent(v, arrow)$
// Unit vector: hat over symbol
#let vcu(v) = $accent(v, hat)$
// Zero vector
#let vzero = $accent(0, arrow)$

= What is a Vector?

You have likely seen vectors written as $(1, 2)$ or $mat(4; -3)$ in high school.
Let us forget that for now (we will return to it in @sec:components), and think from scratch.

#theorem(type: "Definition", title: "Vector (for physics)")[
  A #keyword[vector] is a physical quantity that has both #keyword[magnitude] and #keyword[direction].
]

We draw vectors as arrows. The length of the arrow represents the magnitude; the arrow points in the direction of the vector.

#theorem(type: "Definition", title: "Notation for vectors")[
  - We write vectors with an arrow over the symbol: $vc(v)$, $vc(F)$, $vc(a)$, $vc(p)$.
  - Their magnitudes are written as $|vc(v)|$, $|vc(F)|$, $|vc(a)|$, $|vc(p)|$.
  - In figures, vectors are drawn as arrows. The arrow's length is proportional to the magnitude.
]

#remark[
  In printed textbooks, vectors are often written in bold: $bold(v)$, $bold(F)$.
  When handwriting, always use the arrow notation $vc(v)$ so that you never confuse a vector with a scalar.
]

#be-careful[
  $v$ and $vc(v)$ are *completely different objects*.
  Just as $a$ and $B$ are unrelated, $v$ (a number) and $vc(v)$ (a vector) are unrelated.
  However, in physics, we are sometimes lazy and write $v$ to mean $|vc(v)|$ (the magnitude).
  Watch out for this in textbooks.
]

#theorem(type: "Definition", title: "Vector and scalar quantities")[
  - A #keyword[vector quantity] is a physical quantity with direction. It is described by a vector.
  - A #keyword[scalar quantity] is a physical quantity without direction. It is described by a number.
  - For a vector quantity $vc(A)$, its magnitude $|vc(A)|$ is a scalar quantity.
]

Some examples: *mass* $m$ is a scalar. *Temperature* $T$ can be positive or negative but is scalar (it has no direction). *Velocity* $vc(v)$ is a vector; its magnitude $|vc(v)|$ is the *speed* (scalar). *Force* $vc(F)$, *acceleration* $vc(a)$, *position* $vc(r)$, and *momentum* $vc(p)$ are all vectors. *Area* and *volume* are scalars.

#quizzes[
  + `4` Classify each quantity as a vector or a scalar.
    #h-enum(cols: 4)[
      + air pressure
      + wind velocity
      + wind speed
      + electric charge
      + position
      + distance
      + displacement
      + temperature
      + resistance
      + electric field
      + $vc(x)$
      + $x$
      + $|vc(x)|$
      + $v + |vc(x)|$
      + magnitude of $vc(v)$
      + direction of $vc(v)$
    ]
  + `4`
    + If $vc(a)$ is a vector, what does $|vc(a)|$ mean?
    + If $v$ is a scalar, what does $|v|$ mean?
    #fail-safe[These two are different. $|vc(a)|$ is the magnitude of a vector; $|v|$ is the absolute value of a number.]
]

#pagebreak()

= How to Describe Directions

When you describe a vector, you must specify both its magnitude and its direction.
The magnitude is easy: it is a non-negative number with a unit.
The direction is harder: you must describe it in words or with angles.

== Directions in words

In one dimension, a sign ($plus.minus$) is enough to specify direction.
But you must *declare which direction is positive*.

In two or three dimensions, the following English expressions are useful:

#align(center, table(
  columns: (auto, auto),
  stroke: none,
  align: (left, left),
  table.hline(),
  [*In the plane (horizontal):*], [leftward, rightward, upward, downward],
  [*Into/out of the page:*], [into the page / out of the page (= away from the page)],
  [*With compass directions:*], [northward, southward, eastward, westward, northwestward, ...],
  [*With axes defined:*], [in the positive $x$-direction, in the $+y$-direction, in the $-z$-direction],
  table.hline(),
))

#remark[
  Compass directions (north, south, ...) require you to *declare what "north" means* in your diagram.
  Axis directions require you to *draw and label the axes* first.
  Always make the reference clear.
]

Angles can also specify direction:
- $30°$ counterclockwise from the positive $x$-axis
- $45°$ west of north
- $10°$ above the horizontal

#be-careful[
  $45$ and $45°$ are *completely different*: $45°$ means 45 degrees, while $45$ (without the $°$) is always 45 radians.
  In particular, $cos 60° = 1/2$ but $cos 60 approx -0.95$.
  Always write the degree symbol when you mean degrees.
]

== Relationships between two vectors

When two vectors $vc(a)$ and $vc(b)$ have a specific angular relationship, we use these terms:

#align(center, table(
  columns: (auto, 1fr),
  stroke: none,
  align: (left, left),
  table.hline(),
  [angle $= 0°$:],    [$vc(a)$ is *in the same direction as* $vc(b)$.  Avoid "parallel" for this case (see below).],
  [angle $= 90°$:],   [$vc(a)$ is *perpendicular to* $vc(b)$.  Also: orthogonal to, normal to.],
  [angle $= 180°$:],  [$vc(a)$ is *anti-parallel to* $vc(b)$.  Also: opposite to, in the opposite direction.],
  table.hline(),
))

#remark[
  The word "parallel" is ambiguous: some people use it to mean $0°$, others use it to include both $0°$ and $180°$.
  To avoid confusion, say "in the same direction" for $0°$ and "anti-parallel" for $180°$.
]

#quizzes[
  + `4` #TODO[figure: grid with several vectors] Describe the direction of each vector in English. Then describe the relationship between the following pairs: ($vc(a)$ and $vc(b)$), ($vc(b)$ and $vc(c)$), ($vc(p)$ and $vc(q)$), ($vc(p)$ and $vc(r)$).
]

== Rotations

To describe the direction of a rotation, use *clockwise* and *counterclockwise* (as viewed from a specific direction). Always state the viewpoint clearly:

#tab[
  - counterclockwise as viewed from the positive $z$-axis
  - clockwise as viewed from $+x$ toward the origin
]

For rotations about an axis, the *right-hand rule* is the standard: align the right thumb with the axis; the fingers curl in the direction of rotation.

#pagebreak()

= Vector Operations

== Zero vector

There is a special vector with magnitude zero.

#theorem(type: "Definition", title: "Zero vector")[
  The #keyword[zero vector] $vzero$ has magnitude $0$ and no direction.
]

Note: $vzero$ is a vector and $|vzero| = 0$ is a scalar. They are different objects.

#quizzes[
  + `4` Explain the difference between $vzero$ and $0$. Explain why $|vzero| = 0$.
]

== Scalar multiplication

#theorem(type: "Definition", title: "Scalar multiplication")[
  If $vc(v)$ is a vector and $k$ is a real number, then $k vc(v)$ is defined as follows:
  - If $k > 0$: $k vc(v)$ has the same direction as $vc(v)$ and magnitude $k |vc(v)|$.
  - If $k < 0$: $k vc(v)$ is anti-parallel to $vc(v)$ and has magnitude $|k| |vc(v)|$.
  - If $k = 0$: $k vc(v) = vzero$.

  In summary: $|k vc(v)| = |k| |vc(v)|$.
]

#quizzes[
  + `4` Most students misread the formula $|k vc(v)| = |k| |vc(v)|$.
    Explain the meaning of $|k|$, $|vc(v)|$, and $|k vc(v)|$. Are they the same type of object?
    Then explain why $|k vc(v)| = |k| |vc(v)|$ holds.
    #fail-safe[$|k|$ is the absolute value of a number; $|vc(v)|$ is the magnitude of a vector. They are both non-negative scalars, but their meaning is different.]
]

== Vector addition

#theorem(type: "Definition", title: "Vector addition")[
  If $vc(a)$ and $vc(b)$ are vectors, $vc(a) + vc(b)$ is obtained by placing the *tail* of $vc(b)$ at the *head* of $vc(a)$; the sum is the arrow from the tail of $vc(a)$ to the head of $vc(b)$.

  #TODO[figure: parallelogram law / head-to-tail construction]
]

The following identities follow from these definitions: for vectors $vc(a)$, $vc(b)$, $vc(c)$ and real numbers $p$, $q$:
$
  vc(a) + vc(b) &= vc(b) + vc(a), &quad&
  vc(a) + vzero &= vc(a), \
  vc(a) + (vc(b) + vc(c)) &= (vc(a) + vc(b)) + vc(c), &quad&
  p vc(a) + q vc(a) &= (p+q) vc(a), \
  p vc(a) + p vc(b) &= p(vc(a) + vc(b)), &quad&
  |vc(a) + vc(b)| &<= |vc(a)| + |vc(b)|.
$ <vec-identities>

The last inequality is the #keyword[triangle inequality].

#quizzes[
  + `4` While $vc(a) + vc(a)$ and $2 vc(a)$ are the same vector, their meanings differ.
    Explain the difference based on the definitions above.
  + `4` When is $|vc(a) + vc(b)| = |vc(a)| + |vc(b)|$? When is $|vc(a) + vc(b)| = 0$?
]

#problems[
  + `4` #TODO[figure: grid with vectors $vc(a)$, $vc(b)$, $vc(c)$, $vc(p)$, $vc(q)$, $vc(r)$, $vc(A)$, $vc(B)$, $vc(e)_x$, $vc(e)_y$]
    Vectors are drawn on a grid with spacing 1.
    + Describe the direction and magnitude of each vector in English.
    + Describe the relationships between: ($vc(a)$ and $vc(b)$), ($vc(b)$ and $vc(c)$), ($vc(p)$ and $vc(q)$), ($vc(p)$ and $vc(r)$).
    + Describe $vc(a)$ using $vc(e)_x$ and a number. Describe $vc(b)$ and $vc(c)$ using $vc(e)_y$.
    + Describe $vc(A)$ and $vc(B)$ using $vc(e)_x$ and $vc(e)_y$.
    + Draw a vector that is normal to $vc(p)$ and has length $sqrt(8)$.

  + `3` Consider $vc(s)$ and $vc(t)$ with $|vc(s)| = 3$ and $|vc(t)| = 2$.
    + Do we know $|vc(s) + vc(t)|$? Explain why or why not.
    + Find the minimum and maximum values of $|vc(s) + vc(t)|$. When are they achieved?

  + `3` Try to explain, in words only (no coordinates), why each identity in @vec-identities is true. Base your explanation on the definitions of scalar multiplication and addition.
    #fail-safe[You are asked to argue geometrically, not algebraically. Think of how the arrows move.]
]

#pagebreak()

= Unit Vectors

#theorem(type: "Definition", title: "Unit vector")[
  A vector with magnitude 1 is called a #keyword[unit vector].
]

If $vc(a) != vzero$, the unit vector in the same direction as $vc(a)$ is
$
  vcu(a) = vc(a) / |vc(a)|.
$

#quizzes[
  + `4` Let $|vc(s)| = 3$ and $k$ be a real number.
    + Calculate the magnitudes of $2 vc(s)$, $-3 vc(s)$, $0 vc(s)$, and $vc(s) / |vc(s)|$.
    + Calculate the magnitude of $k vc(s)$ and $k^2 vc(s)$.
    + Is $|k vc(s)|$ always non-negative? Explain.
]

#problems[
  + `4` Let $vc(e)$ be a unit vector and $k$ a real number. Let $vc(a) != vzero$.
    + Find the magnitudes of $-3 vc(e)$, $k vc(e)$, $k^2 vc(e)/5$, and $-k vc(e)$.
    + Find the magnitudes of $vc(a)/|vc(a)|$, $k vc(a)/|vc(a)|$, and $-k vc(a)/|vc(a)|$.

  + `4` Let $|vc(a)| = 3$ and $k > 0$.
    + Find the unit vector in the same direction as $vc(a)$.
    + Find the vector in the same direction as $vc(a)$ with magnitude $6$.
    + Find the vector in the same direction as $vc(a)$ with magnitude $k$.
    + Find the unit vector anti-parallel to $vc(a)$.
    + Find the vector anti-parallel to $vc(a)$ with magnitude $k$.

  + `3` Consider two points A and B at distance $5$ apart.
    We write $arrow(A B)$ for the vector pointing from A to B.
    + Calculate $|arrow(A B)|$.
    + Find the unit vector in the direction of $arrow(A B)$.
    + Given $vc(F) = display(k / (4pi)) display(arrow(A B) / |arrow(A B)|^3)$, describe the direction and magnitude of $vc(F)$.
]

#pagebreak()

= Inner Product

We define the inner product using only magnitude and direction---no coordinates needed.

#theorem(type: "Definition", title: "Inner product (dot product)")[
  For vectors $vc(a)$ and $vc(b)$, the #keyword[inner product] (or #keyword[dot product]) is
  $
    vc(a) dot vc(b) := |vc(a)| |vc(b)| cos theta,
  $
  where $theta$ is the angle between $vc(a)$ and $vc(b)$.
]

From this definition, the following properties follow directly: for vectors $vc(a)$, $vc(b)$, $vc(c)$ and real number $k$:

#align(center, table(
  columns: (auto, 1fr),
  stroke: none,
  align: (left, left),
  [(1)], [$vc(a) dot vc(a) = |vc(a)|^2$, so $|vc(a)| = sqrt(vc(a) dot vc(a))$],
  [(2)], [$vc(a) dot vc(b) = vc(b) dot vc(a)$],
  [(3)], [$(k vc(a)) dot vc(b) = k (vc(a) dot vc(b))$],
  [(4)], [$vc(a) dot vc(b) = 0$ if $vc(a) = vzero$, $vc(b) = vzero$, or $vc(a) perp vc(b)$],
  [(4')], [If $vc(a) != vzero$, $vc(b) != vzero$, and $vc(a) dot vc(b) = 0$, then $vc(a) perp vc(b)$],
  [(5)], [$-|vc(a)| |vc(b)| <= vc(a) dot vc(b) <= |vc(a)| |vc(b)|$],
  [(6)], [$(vc(a) + vc(b)) dot vc(c) = vc(a) dot vc(c) + vc(b) dot vc(c)$],
))

Properties (4) and (4') together mean:
$
  vc(a) dot vc(b) = 0 quad <==> quad vc(a) = vzero "  or  " vc(b) = vzero "  or  " vc(a) perp vc(b).
$

#quizzes[
  + `4` Prove property (1) directly from the definition.
  + `4` Explain why properties (2), (3), (4), (4'), and (5) are correct.
  + `4` Explain why the following are true:
    + $(vc(a) + vc(b)) dot vc(a) = |vc(a)|^2 + vc(a) dot vc(b)$
    + $|vc(a) + vc(b)|^2 = |vc(a)|^2 + 2 vc(a) dot vc(b) + |vc(b)|^2$
]

#remark[
  Formula (b) in the quiz above is the *vector form of the cosine rule*. Compare it with the law of cosines from trigonometry.
]

#problems[
  + `3` Two vectors $vc(a)$ and $vc(b)$ satisfy $|vc(a)| = 2$, $|vc(b)| = 3$, and $vc(a) dot vc(b) = 3$.
    Let $x$, $y$, $p$, $q$ be real numbers.
    + Find the angle between $vc(a)$ and $vc(b)$.
    + Calculate $|vc(a) + vc(b)|$.
    + Calculate the magnitude of $4 vc(a) + 3 vc(b)$ and $x vc(a) + y vc(b)$.
    + Explain why $|x vc(a) + y vc(b)|^2$ is *not* in general equal to $x^2 + y^2$.

    Now let $vc(e)_1$ and $vc(e)_2$ satisfy $|vc(e)_1| = |vc(e)_2| = 1$ and $vc(e)_1 dot vc(e)_2 = 0$.
    + Find the angle between $vc(e)_1$ and $vc(e)_2$.
    + Explain why $(p vc(e)_1 + q vc(e)_2) dot (x vc(e)_1 + y vc(e)_2) = p x + q y$.
    + Explain why $|x vc(e)_1 + y vc(e)_2| = sqrt(x^2 + y^2)$.

  + `2` Three vectors $vc(A)$, $vc(B)$, $vc(C)$ satisfy $|vc(A)| = 2$, $|vc(B)| = 3$, $vc(A) dot vc(B) = 3sqrt(2)$, and $vc(A) dot vc(C) = -1$.
    + Find the angle between $vc(A)$ and $vc(B)$.
    + Calculate $|vc(A) + vc(B)|^2$, $|vc(A) - vc(B)|^2$, and $|2 vc(A) + 4 vc(B)|^2$.
    + Calculate $(vc(A) - 2 vc(B)) dot (2 vc(A) + vc(B) + vc(C)) + 2 vc(B) dot vc(C)$.
    + Find $k$ such that $|vc(A) + k vc(B)| = sqrt(10)$.
    + Find $c$ such that $vc(B) + c vc(C)$ is perpendicular to $vc(A)$.
]

#pagebreak()

= Cross Product <sec:cross>

The cross product produces a *vector* from two vectors.

#theorem(type: "Definition", title: "Cross product")[
  For vectors $vc(a)$ and $vc(b)$, the #keyword[cross product] $vc(a) times vc(b)$ is defined by:
  - It is a vector.
  - Its magnitude is $|vc(a) times vc(b)| = |vc(a)| |vc(b)| sin theta$, where $theta$ is the angle between $vc(a)$ and $vc(b)$.
  - If the magnitude is not zero, its direction is:
    - perpendicular to both $vc(a)$ and $vc(b)$;
    - such that $(vc(a), vc(b), vc(a) times vc(b))$ satisfies the right-hand rule.
]

The #keyword[right-hand rule]: hold your right hand so that your thumb points in the direction of $vc(a)$ and your index finger in the direction of $vc(b)$; your middle finger then points in the direction of $vc(a) times vc(b)$.

#TODO[figure: right-hand rule illustration]

The following properties follow from the definition: for vectors $vc(a)$, $vc(b)$, $vc(c)$ and real number $k$:

#align(center, table(
  columns: (auto, 1fr),
  stroke: none,
  align: (left, left),
  [(1)], [$vc(a) times vc(a) = vzero$],
  [(2)], [$vc(a) times vc(b) = -vc(b) times vc(a)$ ~~(anti-commutative)],
  [(3)], [$(vc(a) + vc(b)) times vc(c) = vc(a) times vc(c) + vc(b) times vc(c)$ ~~(distributive)],
  [(4)], [$0 <= |vc(a) times vc(b)| <= |vc(a)| |vc(b)|$],
  [(5)], [$(k vc(a)) times vc(b) = vc(a) times (k vc(b)) = k(vc(a) times vc(b))$],
  [(6)], [$vc(a) times vzero = vzero times vc(a) = vzero$],
  [(7)], [$vc(a) times vc(b) = vzero$ if $vc(a)$ and $vc(b)$ are parallel or anti-parallel],
  [(8)], [$vc(a) dot (vc(a) times vc(b)) = vc(b) dot (vc(a) times vc(b)) = 0$],
  [(9)], [$(vc(a) dot vc(b))^2 + |vc(a) times vc(b)|^2 = |vc(a)|^2 |vc(b)|^2$],
  [(10)], [$vc(a) dot (vc(b) times vc(c)) = vc(b) dot (vc(c) times vc(a)) = vc(c) dot (vc(a) times vc(b))$],
))

Property (9) is Lagrange's identity; it follows from $cos^2 theta + sin^2 theta = 1$.

#quizzes[
  + `4` Explain why properties (1), (2), (4), and (6)--(9) are valid. Use only the definition.
    #fail-safe[We skip the proof of (3) and (5) because they are more complicated.]
  + `4`
    + Explain why $(vc(a) + vc(b)) times vc(a) = -vc(a) times vc(b)$.
    + #TODO[figure reference] For the vectors in the figure: describe $vc(a) times vc(b)$, $vc(b) times vc(a)$, $vc(b) times vc(c)$, and $vc(a) times vc(p)$.
]

#problems[
  + `3` Three unit vectors $vc(e)_x$, $vc(e)_y$, $vc(e)_z$ satisfy
    $vc(e)_x times vc(e)_y = vc(e)_z$, $vc(e)_y times vc(e)_z = vc(e)_x$, $vc(e)_z times vc(e)_x = vc(e)_y$.
    + Calculate $vc(e)_x dot vc(e)_y$. Find all angles among $vc(e)_x$, $vc(e)_y$, $vc(e)_z$.
    + Expand $(a vc(e)_x + b vc(e)_y + c vc(e)_z) times (p vc(e)_x + q vc(e)_y + r vc(e)_z)$ and simplify.
]

#pagebreak()

= Vector/Scalar/Not

Let us summarize the operations on vectors.
With $k$ a real number and $vc(a)$, $vc(b)$ vectors:

#align(center, table(
  columns: (auto, auto, auto),
  stroke: none,
  align: (left, center, left),
  table.hline(),
  [*magnitude*],             [$|vc(a)|$],            [$arrow.r$ scalar],
  [*scalar multiplication*], [$k vc(a)$],             [$arrow.r$ vector],
  [*addition*],              [$vc(a) + vc(b)$],       [$arrow.r$ vector],
  [*inner product*],         [$vc(a) dot vc(b)$],     [$arrow.r$ scalar],
  [*cross product*],         [$vc(a) times vc(b)$],   [$arrow.r$ vector],
  table.hline(),
))

These five operations are the *only* operations defined on vectors.
Any complicated expression can be reduced to combinations of these five.
The following are *invalid*---they have no mathematical meaning:
$
  #RED[$vc(a)^2$], quad
  #RED[$1 / vc(a)$], quad
  #RED[$k + vc(a)$], quad
  #RED[$vc(a) vc(b)$], quad
  #RED[$sqrt(vc(a))$], quad
  #RED[$vc(a) / vc(a)$], quad
  #RED[$vc(a) dot vc(b) + vc(a) times vc(b)$].
$

#problems[
  + `4` For each expression, answer *V* if it is a vector, *S* if it is a scalar, and *N* if it is invalid.
    #h-enum(cols: 4)[
      + $3 + |vc(a)|$
      + $vc(a) - vc(b)$
      + $vc(a) vc(b)$
      + $vc(a) \/ vc(b)$
      + $3 vc(a)$
      + $vzero + 1$
      + $vzero$
      + $-vc(a)$
      + $|vc(a)|^(-1) vc(a)$
      + $vc(p) times (vc(q) times vc(r))$
      + $vc(p) dot (vc(q) times vc(r))$
      + $p (vc(q) times vc(r))$
      + $display(1 / (vc(x) + vc(y)))$
      + $display((x+y) / |vc(x) + vc(y)|)$
      + $display((vc(x) + vc(y)) / |vc(x) + vc(y)|)$
      + $display((vc(x) + vc(y)) / (vc(x) + vc(y)))$
      + $display(1 / (vc(a) dot vc(b))^2)$
      + $display(vc(a) / (vc(a) dot vc(b))^2)$
      + $display(1 / (vc(a))^2)$
      + $display(1 / |vc(a)|^2)$
    ]
]

#pagebreak()

= Axes and Components <sec:components>

So far, we have not used coordinates or components---all our results hold independent of any coordinate system. This is an important point: *vectors are independent of coordinate systems*.

In physics, our universe has no predefined $x$-, $y$-, or $z$-direction. We *choose* axes to make calculations easier.

The simplest coordinate system is the #keyword[Cartesian coordinate system].

#theorem(type: "Definition", title: "Right-handed Cartesian coordinate system")[
  We define unit vectors $vc(e)_x$, $vc(e)_y$, $vc(e)_z$ in the $+x$-, $+y$-, $+z$-directions. They satisfy
  $
    |vc(e)_x| = |vc(e)_y| = |vc(e)_z| = 1, quad
    vc(e)_x dot vc(e)_y = vc(e)_y dot vc(e)_z = vc(e)_z dot vc(e)_x = 0.
  $
  In a *right-handed* system, they also satisfy
  $
    vc(e)_x times vc(e)_y = vc(e)_z, quad
    vc(e)_y times vc(e)_z = vc(e)_x, quad
    vc(e)_z times vc(e)_x = vc(e)_y.
  $
  We always use right-handed coordinate systems.
]

#remark[
  In many textbooks, $vc(e)_x$, $vc(e)_y$, $vc(e)_z$ are written as $hat(i)$, $hat(j)$, $hat(k)$ or $bold(hat(i))$, $bold(hat(j))$, $bold(hat(k))$.
  They all refer to the same basis vectors.
]

After defining axes, we can express every vector in components.

#theorem(type: "Definition", title: "Components of a vector")[
  If a vector $vc(v)$ can be written as
  $
    vc(v) = A vc(e)_x + B vc(e)_y + C vc(e)_z,
  $
  then $A$, $B$, $C$ are the #keyword[components] of $vc(v)$, and we write
  $
    vc(v) = mat(A; B; C).
  $
]

#remark[
  In high school, you may have used the horizontal notation $(A, B, C)$.
  In university, use the vertical (column) form $mat(A; B; C)$, which is consistent with matrix notation.
]

Check: $vc(e)_x = mat(1;0;0)$, $vc(e)_y = mat(0;1;0)$, $vc(e)_z = mat(0;0;1)$.

With components, the operations become:

#align(center, table(
  columns: (auto, auto),
  stroke: none,
  align: (left, left),
  table.hline(),
  [Addition:], [$mat(A;B;C) + mat(P;Q;R) = mat(A+P; B+Q; C+R)$],
  [Scalar multiplication:], [$k mat(A;B;C) = mat(k A; k B; k C)$],
  [Inner product:], [$mat(A;B;C) dot mat(P;Q;R) = A P + B Q + C R$],
  [Magnitude:], [$|mat(A;B;C)| = sqrt(A^2 + B^2 + C^2)$],
  [Cross product:], [$mat(A;B;C) times mat(P;Q;R) = mat(B R - C Q; C P - A R; A Q - B P)$],
  table.hline(),
))

#be-careful[
  These component formulas are *consequences* of the definitions we gave earlier (scalar multiplication, addition, inner product, cross product), together with the fact that $vc(e)_x$, $vc(e)_y$, $vc(e)_z$ are mutually perpendicular unit vectors satisfying the right-hand rule.
  They are *not* new definitions.
]

#quizzes[
  + `4` Let $vc(a) = mat(1;2;0)$ and $vc(b) = mat(3;-1;2)$.
    + Calculate $vc(a) + vc(b)$, $2 vc(a) - vc(b)$.
    + Calculate $vc(a) dot vc(b)$. Find the angle between $vc(a)$ and $vc(b)$.
    + Calculate $|vc(a)|$ and $|vc(b)|$.
    + Calculate $vc(a) times vc(b)$. Verify it is perpendicular to both $vc(a)$ and $vc(b)$.
]

#problems[
  + `3` Let $vc(A) = mat(a;b;c)$ and $vc(B) = mat(p;q;r)$. Prove each formula in the table above. #fail-safe[Use the inner product and cross product properties from the previous sections, together with $vc(e)_x dot vc(e)_y = 0$, $vc(e)_x times vc(e)_y = vc(e)_z$, etc.]

  + `3` Let $vc(a) = mat(1;2;-1)$, $vc(b) = mat(3;0;2)$, $vc(c) = mat(-1;1;1)$.
    + Calculate $vc(a) dot vc(b)$, $|vc(a)|$, $|vc(b)|$, and the angle between $vc(a)$ and $vc(b)$.
    + Calculate $vc(a) times vc(b)$. Verify $|vc(a) times vc(b)|^2 + (vc(a) dot vc(b))^2 = |vc(a)|^2 |vc(b)|^2$.
    + Find the unit vector in the direction of $vc(a) + vc(b)$.
    + Find a real number $k$ such that $vc(a) + k vc(b)$ is perpendicular to $vc(c)$.

  + `2` Let $vc(v) = A vc(e)_x + B vc(e)_y + C vc(e)_z$.
    Show that $vc(v) dot vc(e)_x = A$, $vc(v) dot vc(e)_y = B$, $vc(v) dot vc(e)_z = C$.
    This means we can always "read off" the components by taking dot products with the basis vectors:
    $
      vc(v) = (vc(v) dot vc(e)_x) vc(e)_x + (vc(v) dot vc(e)_y) vc(e)_y + (vc(v) dot vc(e)_z) vc(e)_z.
    $
]

#pagebreak()

= Position Vectors

We can use vectors to describe the positions of points.

Fix a reference point O (the *origin*). For any point P, define the #keyword[position vector] of P as the vector $arrow(O P)$ pointing from O to P.

For points A and B with position vectors $vc(a) = arrow(O A)$ and $vc(b) = arrow(O B)$:
$
  arrow(A B) = vc(b) - vc(a), quad |arrow(A B)| = |vc(b) - vc(a)|.
$

#quizzes[
  + `4` #TODO[figure: three points A, B, C]
    Three points A, B, C are given. Choose an origin O (anywhere) and define $vc(a) = arrow(O A)$, $vc(b) = arrow(O B)$, $vc(c) = arrow(O C)$.
    + Draw $vc(a)$, $vc(b)$, $vc(c)$, and $vc(b) + vc(c)$.
    + Draw $vc(b) - vc(a)$ and $vc(a) - vc(c)$.
    + Express $|arrow(A B)|$ using $vc(a)$ and $vc(b)$.
]

#problems[
  + `3` Three points A, B, C have position vectors $vc(a)$, $vc(b)$, $vc(c)$ relative to origin O.
    + Find the position vector of the midpoint M of segment AB.
    + Let G be the centroid (geometric center) of triangle ABC. Show that $arrow(O G) = (vc(a) + vc(b) + vc(c))/3$.

  + `3` Let $vc(a) = mat(1;2;3)$ and $vc(b) = mat(4;0;-1)$.
    + Find the distance $|arrow(A B)|$ between the points A and B.
    + Find the position vector of the midpoint of AB.
    + Find the position vector of the point P that divides AB in ratio $1:2$ (closer to A).

  + `2` A particle moves so that its position vector at time $t$ is
    $vc(r)(t) = mat(cos t; sin t; t)$.
    + Calculate $|vc(r)(t)|$ at $t = 0$ and at $t = pi/2$.
    + Calculate the velocity vector $vc(v)(t) = dv(vc(r), t)$ by differentiating component-wise.
    + Show that $vc(r)(t) dot vc(v)(t)$ depends on $t$ and find its value.
    + Calculate $|vc(v)(t)|$.
]
