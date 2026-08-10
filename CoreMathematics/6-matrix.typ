#import "misho-text.typ": *

// Convenience: column vector macro
#let colvec(..args) = $mat(..args.pos().map(x => (x,)).join(";"))$

= What is a Matrix?

A #keyword[matrix] is a rectangular array of numbers, written inside brackets.
For example,
$
  mat(1, 2; 3, 4), quad mat(0, -1, 2; 5, 1, 0), quad mat(3; -1; 2).
$

The first has 2 rows and 2 columns: it is a $2 times 2$ matrix.
The second has 2 rows and 3 columns: a $2 times 3$ matrix.
The third is a $3 times 1$ matrix, which is just a column vector.

In general, an $m times n$ matrix $A$ has $m$ rows and $n$ columns.
We write its $(i, j)$-entry (row $i$, column $j$) as $A_(i j)$, so
$
  A = mat(
    A_(11), A_(12), dots.c, A_(1n);
    A_(21), A_(22), dots.c, A_(2n);
    dots.v, dots.v, dots.down, dots.v;
    A_(m 1), A_(m 2), dots.c, A_(m n)
  ).
$

The most important case in this course is $2 times 2$ and $3 times 3$ matrices.

#quizzes[
  + `4` State the size (number of rows and columns) of each matrix.
    #h-enum(cols: 4)[
      + $mat(1, 2; 3, 4)$
      + $mat(1, 0, 0; 0, 1, 0; 0, 0, 1)$
      + $mat(5; -2)$
      + $mat(1, 2, 3)$
      + $mat(1, 0; 0, 1; -1, 2)$
      + $mat(a, b; c, d; e, f)$
    ]
  + `4` For $A = mat(1, -2, 3; 0, 5, -1)$, find $A_(11)$, $A_(12)$, $A_(21)$, and $A_(23)$.
]

#pagebreak()

= Matrix Operations

== Addition and scalar multiplication

Two matrices of the *same size* can be added entry-by-entry.
A matrix can be multiplied by a scalar entry-by-entry.

$
  mat(a, b; c, d) + mat(p, q; r, s) = mat(a+p, b+q; c+r, d+s), qquad
  k mat(a, b; c, d) = mat(k a, k b; k c, k d).
$

#be-careful[
  You *cannot* add matrices of different sizes. $mat(1, 2; 3, 4) + mat(1, 0, 0; 0, 1, 0)$ is *undefined*.
]

#quizzes[
  + `4` Calculate.
    #h-enum(cols: 2)[
      + $mat(1, 2; 3, 4) + mat(5, -1; 0, 2)$
      + $3 mat(1, -1; 0, 2) - 2 mat(3, 0; -1, 1)$
      + $mat(1, 2, 3; 0, -1, 2) + mat(-1, 0, 1; 1, 1, -1)$
      + $mat(2; -1; 3) - mat(1; 2; -1)$
    ]
]

== Matrix multiplication

Matrix multiplication is more subtle.
The product $A B$ is defined only when the number of *columns* of $A$ equals the number of *rows* of $B$.
If $A$ is $m times n$ and $B$ is $n times p$, then $A B$ is $m times p$, with entries
$
  (A B)_(i j) = sum_(k=1)^n A_(i k) B_(k j).
$
In words: the $(i,j)$-entry of $A B$ is the dot product of the $i$-th row of $A$ with the $j$-th column of $B$.

#example(title: "2×2 multiplication")[
  $
    mat(1, 2; 3, 4) mat(5, 6; 7, 8)
    = mat(
      1 dot 5 + 2 dot 7, 1 dot 6 + 2 dot 8;
      3 dot 5 + 4 dot 7, 3 dot 6 + 4 dot 8
    )
    = mat(19, 22; 43, 50).
  $
]

#be-careful[
  Matrix multiplication is *not commutative* in general: $A B != B A$.
  Always keep track of the order!
]

#quizzes[
  + `4` Calculate each product, or state "undefined" if the sizes are incompatible.
    #h-enum(cols: 2)[
      + $mat(2, 1; 0, 3) mat(1, -1; 2, 0)$
      + $mat(1, -1; 2, 0) mat(2, 1; 0, 3)$
      + $mat(1, 2, 3) mat(4; 5; 6)$
      + $mat(4; 5; 6) mat(1, 2, 3)$
      + $mat(1, 0; 0, 1) mat(a, b; c, d)$
      + $mat(1, 2; 3, 4) mat(1, 0; 0, 1)$
    ]
  + `4` For which pairs is the product defined? What is the size of the result?
    #h-enum(cols: 2)[
      + $A$: $2 times 3$, $B$: $3 times 4$ --- compute $A B$?
      + $A$: $3 times 2$, $B$: $3 times 2$ --- compute $A B$?
      + $A$: $1 times n$, $B$: $n times 1$ --- compute $A B$ and $B A$?
    ]
]

== Matrix acting on vectors

The most important use of matrices in physics is as a *linear map*: a matrix $A$ transforms a vector $vc(x)$ into another vector $A vc(x)$, computed by matrix-vector multiplication.

For a $2 times 2$ matrix acting on a 2d column vector:
$
  mat(a, b; c, d) mat(x; y) = mat(a x + b y; c x + d y).
$

We write vectors in column form $mat(x; y)$ (consistent with matrix notation from @sec:components).

#quizzes[
  + `4` Let $A = mat(2, -1; 0, 3)$. Calculate $A vc(v)$ for each vector.
    #h-enum(cols: 4)[
      + $vc(v) = mat(1; 0)$
      + $vc(v) = mat(0; 1)$
      + $vc(v) = mat(2; -1)$
      + $vc(v) = mat(x; y)$
    ]
]

#pagebreak()

= The Identity and Zero Matrices

#theorem(type: "Definition", title: "Identity matrix")[
  The $n times n$ #keyword[identity matrix] $I$ (or $I_n$) has 1 on the diagonal and 0 elsewhere:
  $
    I_2 = mat(1, 0; 0, 1), quad I_3 = mat(1, 0, 0; 0, 1, 0; 0, 0, 1).
  $
  For any $n times n$ matrix $A$: $A I = I A = A$. For any column vector $vc(x)$: $I vc(x) = vc(x)$.
]

#theorem(type: "Definition", title: "Zero matrix")[
  The #keyword[zero matrix] $O$ has all entries equal to 0.
  For any matrix $A$ of compatible size: $A + O = A$ and $A O = O A = O$.
]

#remark[
  Do not confuse the zero matrix $O$ with the scalar $0$, or with the zero vector $vzero$.
  They are different objects.
]

#quizzes[
  + `4` Verify: $mat(1, 0; 0, 1) mat(a, b; c, d) = mat(a, b; c, d)$ and $mat(a, b; c, d) mat(1, 0; 0, 1) = mat(a, b; c, d)$.
  + `4` Find a $2 times 2$ matrix $A != O$ such that $A^2 = O$ (where $A^2 := A A$).
]

#pagebreak()

= Geometric Transformations in 2D <sec:geo-2d>

A $2 times 2$ matrix $A$ defines a linear map: it sends every point $(x, y)$ to the new point $A mat(x; y)$.
This gives us a geometric transformation of the plane.

== Scaling

The matrix $mat(s_x, 0; 0, s_y)$ scales the $x$-component by $s_x$ and the $y$-component by $s_y$:
$
  mat(s_x, 0; 0, s_y) mat(x; y) = mat(s_x x; s_y y).
$

Special cases:
- $s_x = s_y = k$: uniform scaling by factor $k$, i.e., $k I$.
- $s_x = -1$, $s_y = 1$: reflection in the $y$-axis.
- $s_x = 1$, $s_y = -1$: reflection in the $x$-axis.

#quizzes[
  + `4` What does each matrix do geometrically?
    #h-enum(cols: 4)[
      + $mat(2, 0; 0, 2)$
      + $mat(-1, 0; 0, 1)$
      + $mat(1, 0; 0, -1)$
      + $mat(-1, 0; 0, -1)$
    ]
]

== Rotation

A counterclockwise rotation by angle $theta$ is represented by the matrix
$
  R(theta) = mat(cos theta, -sin theta; sin theta, cos theta).
$ <rot-matrix>

#example(title: "Rotation by 90°")[
  With $theta = pi/2$: $cos(pi/2) = 0$, $sin(pi/2) = 1$, so
  $
    R(pi/2) = mat(0, -1; 1, 0).
  $
  Check: $mat(0, -1; 1, 0) mat(1; 0) = mat(0; 1)$ --- the $+x$ direction rotates to $+y$. ✓
]

#quizzes[
  + `4` Write the rotation matrix $R(theta)$ for each angle.
    #h-enum(cols: 4)[
      + $theta = 0$
      + $theta = pi$
      + $theta = -pi/2$
      + $theta = pi/4$
    ]
    Verify that each result makes geometric sense.

  + `4` Let $vc(v) = mat(3; 4)$. Apply $R(pi/2)$ to find the rotated vector. Verify that $|R(pi/2) vc(v)| = |vc(v)|$.
]

Why is this the rotation matrix? If a vector makes angle $phi$ with the $+x$-axis and has magnitude $r$, then
$mat(x; y) = mat(r cos phi; r sin phi)$.
After rotation by $theta$:
$
  R(theta) mat(r cos phi; r sin phi)
  = mat(cos theta dot r cos phi - sin theta dot r sin phi; sin theta dot r cos phi + cos theta dot r sin phi)
  = mat(r cos(phi + theta); r sin(phi + theta)).
$
The result has the same magnitude $r$ and angle $phi + theta$. This confirms @rot-matrix.

#problems[
  + `3` Verify the rotation matrix formula.
    + Check that $|R(theta) vc(v)| = |vc(v)|$ for any vector $vc(v) = mat(x; y)$.
    + Show that $R(theta_1) R(theta_2) = R(theta_1 + theta_2)$. What does this say geometrically?
    + Show that $R(-theta) = R(theta)^(-1)$, i.e., $R(theta) R(-theta) = I$.
    + Find $R(theta)^n$ for positive integer $n$.
]

== Reflection

The matrix representing reflection in the line through the origin at angle $theta/2$ from the $+x$-axis is
$
  mat(cos theta, sin theta; sin theta, -cos theta).
$

#example(title: "Reflections in coordinate axes")[
  - Reflection in the $x$-axis ($theta = 0$): $mat(1, 0; 0, -1)$. Check: $mat(1; 0) -> mat(1; 0)$ and $mat(0; 1) -> mat(0; -1)$. ✓
  - Reflection in the $y$-axis ($theta = pi$): $mat(-1, 0; 0, 1)$. ✓
  - Reflection in the line $y = x$ ($theta = pi/2$): $mat(0, 1; 1, 0)$.
    Check: $mat(1; 0) -> mat(0; 1)$ and $mat(0; 1) -> mat(1; 0)$. ✓
]

#quizzes[
  + `4` Write the reflection matrix for each case and verify with one test vector.
    #h-enum(cols: 2)[
      + Reflection in the line $y = 0$ (the $x$-axis).
      + Reflection in the line $y = -x$.
      + Reflection in the line at $45°$ from the $+x$-axis.
    ]
  + `4` What is the result of applying a reflection twice? Verify using the matrix.
]

#advanced-note[
  Every rotation matrix $R(theta)$ satisfies $det R(theta) = 1$; every reflection matrix satisfies $det = -1$.
  This determinant sign distinguishes orientation-preserving (rotation) from orientation-reversing (reflection) transformations.
  We will define the determinant in @sec:det.
]

#pagebreak()

= Determinant <sec:det>

For a $2 times 2$ matrix, the #keyword[determinant] is defined by
$
  det mat(a, b; c, d) = a d - b c.
$
We also write this as $|mat(a, b; c, d)|$.

For a $3 times 3$ matrix, the determinant is
$
  det mat(a, b, c; d, e, f; g, h, i) = a(e i - f h) - b(d i - f g) + c(d h - e g).
$
This is called *expansion along the first row*.

#example[
  $det mat(2, 3; 1, 4) = 2 dot 4 - 3 dot 1 = 8 - 3 = 5.$

  $det mat(1, 2, 0; -1, 3, 1; 0, 1, 2) = 1(3 dot 2 - 1 dot 1) - 2((-1) dot 2 - 1 dot 0) + 0 = 1 dot 5 - 2 dot (-2) = 9.$
]

#quizzes[
  + `4` Calculate each determinant.
    #h-enum(cols: 4)[
      + $det mat(3, 1; 2, 5)$
      + $det mat(0, -2; 3, 1)$
      + $det mat(-1, 2; 4, -8)$
      + $det mat(a, b; -b, a)$
      + $det mat(1, 0, 0; 0, 2, 0; 0, 0, 3)$
      + $det mat(0, 1, 0; 1, 0, 0; 0, 0, 1)$
      + $det mat(1, 1, 1; 0, 1, 1; 0, 0, 1)$
      + $det mat(1, 2, 3; 4, 5, 6; 7, 8, 9)$
    ]
]

The geometric meaning: $|det A|$ is the *area scaling factor* of the transformation defined by $A$.
If $det A = 0$, the transformation collapses the plane to a line or point (it is not invertible).

Key properties: for $n times n$ matrices $A$ and $B$,
$
  det(A B) = det(A) det(B), quad det(k A) = k^n det(A), quad det(A^top) = det(A),
$
where $A^top$ is the *transpose* of $A$ (rows and columns swapped).

#quizzes[
  + `4` Verify $det(A B) = det(A) det(B)$ for $A = mat(1, 2; 3, 4)$ and $B = mat(2, 0; 1, 3)$.
  + `4` Compute $det(R(theta))$ from @rot-matrix. Does the result agree with the geometric interpretation?
]

#pagebreak()

= Inverse Matrix

If $A B = B A = I$, then $B$ is the #keyword[inverse] of $A$, written $B = A^(-1)$.
Not every matrix has an inverse; $A$ is *invertible* if and only if $det A != 0$.

For a $2 times 2$ matrix:
$
  mat(a, b; c, d)^(-1) = 1/(a d - b c) mat(d, -b; -c, a), quad "provided" a d - b c != 0.
$ <inv-2x2>

#example[
  $mat(2, 3; 1, 4)^(-1) = 1/5 mat(4, -3; -1, 2) = mat(4/5, -3/5; -1/5, 2/5).$

  Check: $mat(2, 3; 1, 4) mat(4/5, -3/5; -1/5, 2/5) = mat(8/5-3/5, -6/5+6/5; 4/5-4/5, -3/5+8/5) = mat(1, 0; 0, 1) = I$. ✓
]

Geometrically, $A^(-1)$ is the *inverse transformation*: if $A$ rotates by $theta$, then $A^(-1)$ rotates by $-theta$.
If $A$ reflects in a line, then $A^(-1) = A$ (a reflection is its own inverse).

#quizzes[
  + `4` Find $A^(-1)$ for each matrix, or state that it does not exist.
    #h-enum(cols: 4)[
      + $mat(3, 1; 2, 1)$
      + $mat(2, 4; 1, 2)$
      + $mat(cos theta, -sin theta; sin theta, cos theta)$
      + $mat(k, 0; 0, k)$ ($k != 0$)
    ]
  + `4` If $A = mat(1, 2; 3, 4)$, verify that $A A^(-1) = I$ using @inv-2x2.
]

#problems[
  + `3` Solve each matrix equation for the unknown vector $vc(x) = mat(x; y)$.
    #h-enum(cols: 2)[
      + $mat(2, 1; 1, 1) mat(x; y) = mat(3; 2)$
      + $mat(3, -1; -1, 1) mat(x; y) = mat(5; 1)$
      + $mat(cos theta, -sin theta; sin theta, cos theta) mat(x; y) = mat(1; 0)$
    ]

  + `3` Let $A = mat(1, 1; 0, 1)$ (a *shear* matrix).
    + Find $A vc(v)$ for $vc(v) = mat(1; 0)$, $mat(0; 1)$, $mat(1; 1)$, $mat(a; b)$.
    + Find $A^(-1)$ and interpret geometrically.
    + Compute $A^n$ for positive integer $n$ and guess the pattern.

  + `2` Prove: if $A$ and $B$ are invertible $n times n$ matrices, then $(A B)^(-1) = B^(-1) A^(-1)$.
]

#pagebreak()

= Geometric Transformations in 3D

In 3D, $3 times 3$ matrices represent transformations of space.

== Rotations in 3D

Rotations in 3D are about an axis. The standard rotations by angle $theta$ about the coordinate axes are:

$
  R_x (theta) = mat(1, 0, 0; 0, cos theta, -sin theta; 0, sin theta, cos theta),
$ <rot-x>
$
  R_y (theta) = mat(cos theta, 0, sin theta; 0, 1, 0; -sin theta, 0, cos theta),
$ <rot-y>
$
  R_z (theta) = mat(cos theta, -sin theta, 0; sin theta, cos theta, 0; 0, 0, 1).
$ <rot-z>

Notice:
- $R_x(theta)$ fixes the $x$-axis and rotates the $y$-$z$ plane.
- $R_z(theta)$ has the same form as the 2D rotation matrix $R(theta)$.
- $R_y(theta)$ has a sign difference from the others---due to the right-hand rule.

#quizzes[
  + `4` Verify the following using @rot-x--@rot-z.
    #h-enum(cols: 1)[
      + $R_z(theta) mat(1; 0; 0) = mat(cos theta; sin theta; 0)$ and $R_z(theta) mat(0; 0; 1) = mat(0; 0; 1)$.
      + $R_y(pi/2) mat(1; 0; 0) = mat(0; 0; -1)$. Explain why the sign is $-1$.
    ]

  + `4` Compute $det(R_x(theta))$, $det(R_y(theta))$, $det(R_z(theta))$.
]

#remark[
  All rotation matrices in 3D satisfy $R R^top = I$ (called *orthogonal*) and $det R = 1$.
  Matrices satisfying $R R^top = I$ but with $det R = -1$ represent *improper rotations* (rotation combined with reflection).
]

== Reflections in 3D

Reflection in the $x$-$y$ plane sends $mat(x; y; z) -> mat(x; y; -z)$:
$
  mat(1, 0, 0; 0, 1, 0; 0, 0, -1).
$

Similarly, reflection in any coordinate plane corresponds to flipping one component.

#quizzes[
  + `4` Write the $3 times 3$ matrix for each transformation.
    #h-enum(cols: 2)[
      + Reflection in the $y$-$z$ plane ($x -> -x$).
      + Scaling: $x -> 2x$, $y -> 3y$, $z -> z$.
      + Rotation by $pi/2$ about the $z$-axis.
      + Rotation by $pi$ about the $x$-axis.
    ]
]

#problems[
  + `3` Let $R = R_z(theta_2) R_x(theta_1)$.
    + Compute $R$ explicitly as a $3 times 3$ matrix.
    + Show that $R R^top = I$.
    + Compute $det R$.

  + `3` A reflection in 3D about the plane perpendicular to the unit vector $vc(n) = mat(n_1; n_2; n_3)$ is given by
    $
      H = I - 2 vc(n) vc(n)^top.
    $
    ($vc(n) vc(n)^top$ is an outer product: a $3 times 3$ matrix with $(i,j)$-entry $n_i n_j$.)
    + Verify $H vc(n) = -vc(n)$ (the normal direction is flipped).
    + Verify $H vc(v) = vc(v)$ for any $vc(v)$ perpendicular to $vc(n)$.
    + Show $H^2 = I$.
    + Compute $det H$.

  + `2` Show that the composition of two reflections in 3D is a rotation.
    Concretely: let $H_1 = I - 2 vc(n)_1 vc(n)_1^top$ and $H_2 = I - 2 vc(n)_2 vc(n)_2^top$ where $|vc(n)_1| = |vc(n)_2| = 1$.
    Show that $det(H_1 H_2) = 1$.
    #fail-safe[Use the multiplicativity of the determinant and the result of the previous problem.]
]

#pagebreak()

= Linear Maps and Matrices

Every $m times n$ matrix $A$ defines a *linear map* $f: RR^n -> RR^m$ by $f(vc(x)) = A vc(x)$.
A map $f$ is *linear* if it satisfies:
$
  f(vc(x) + vc(y)) = f(vc(x)) + f(vc(y)), quad f(k vc(x)) = k f(vc(x)).
$

Conversely, *every* linear map between finite-dimensional spaces is represented by a matrix.
This is why matrices are so fundamental.

The following are all linear maps (and therefore representable by matrices): rotations, reflections, scalings, projections, and their compositions.

The following are *not* linear:
- translation: $f(vc(x)) = vc(x) + vc(b)$ with $vc(b) != vzero$ (fails $f(vzero) = vzero$).
- any map with $f(vzero) != vzero$.

#quizzes[
  + `4` For each map, decide if it is linear. If yes, find its matrix.
    #h-enum(cols: 1)[
      + $f(mat(x; y)) = mat(2x; x+y)$
      + $f(mat(x; y)) = mat(x+1; y)$ (translation by $(1,0)$)
      + $f(mat(x; y)) = mat(x y; 0)$
      + Projection onto the $x$-axis: $f(mat(x; y)) = mat(x; 0)$.
    ]
]

#remark[
  The *column* of a matrix $A$ tells you where the basis vectors go.
  The first column is $A vc(e)_x$, the second is $A vc(e)_y$, etc.
  This is the key to *building* the matrix for any linear map: just find where each basis vector goes.
]

#example(title: "Building a rotation matrix from scratch")[
  A counterclockwise rotation by $theta$ sends:
  - $vc(e)_x = mat(1; 0)$ to $mat(cos theta; sin theta)$,
  - $vc(e)_y = mat(0; 1)$ to $mat(-sin theta; cos theta)$.

  So the rotation matrix is $mat(cos theta, -sin theta; sin theta, cos theta)$, confirming @rot-matrix.
]

#problems[
  + `3` Build the matrix for each linear map in $RR^2$ by finding where $vc(e)_x$ and $vc(e)_y$ go.
    #h-enum(cols: 1)[
      + Reflection in the line $y = x$.
      + Projection onto the line $y = x$ (maps every point to its nearest point on $y=x$).
      + Rotation by $pi/6$ followed by scaling by $2$.
    ]

  + `3` Let $P$ be the $2 times 2$ matrix for projection onto the $x$-axis.
    + Find $P$.
    + Compute $P^2$. Explain geometrically why $P^2 = P$.
    + Compute $det P$.

  + `2` Let $A = R(theta)$ be the $2 times 2$ rotation matrix.
    + Show that $A^top = A^(-1)$, i.e., $A A^top = I$.
    + Interpret this geometrically: what is the transformation $A^top$?

  + `1` (Challenge) Let $A$ be any $2 times 2$ matrix with $det A = 1$ and $A^top = A^(-1)$.
    Show that $A$ must be a rotation matrix, i.e., $A = mat(cos theta, -sin theta; sin theta, cos theta)$ for some $theta$.
]
