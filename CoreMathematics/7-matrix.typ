#import "misho-text.typ": *
#import "physica.typ": Im, Re, trace
#import "2-units.typ": writing, writings
#import "5-vector.typ": dm, va, vc, vcu, vip
#import "6-complex.typ": cip, lbk

// ----------------------------------------------------------------
// Local helpers
// ----------------------------------------------------------------
// Column vector of two entries (display)
#let dmt(a, b) = $display(mat(#a; #b))$
// Matrix notation: mx(a, b; c, d) etc.
#let mx(..args) = math.mat(delim: "(", ..args)
// Conjugate-transpose (dagger)
#let dag = $dagger$
// Standard basis vectors (column)
#let ee(k) = $vc(e)_#k$

// ----------------------------------------------------------------

= Review: Vectors as Lists of Numbers <sec:mat-vec-review>
We discuss matrices#footnote[One dog, two dogs. One matrix, two matrices. One vertex, two vertices. One index, two indices.] in this chapter.
A matrix is deeply tied to vectors.
Since a matrix is described as a two-dimensional list of numbers,
#no-num[$ A = mat(1, 2, 3; 4, 5, 6), quad B=mat(0, 1+ii; 1-ii, 0), quad "etc.," $]
we in this chapter interpret vectors as (one-dimensional) lists of numbers#footnote[→ The beginning of @chap:vector.], not arrows, until #TODO[a section].
#advanced-note[Our discussion up to this chapter (@chap:complex to @chap:matrix) also assumes that the dimension of the space is finite.]

#[
  #set par(leading: 0.2em)
  #make-indent
  Let us introduce some notation for vectors.
  #writing[$RR^n$] is the set of all real $n$-dimensional vectors. i.e.,
  #writing[$vc(a)in RR^n$] means "$vc(a)$ is a real $n$-dimensional vector."
  Similarly,
  #writing[$CC^n$] is the set of all complex $n$-dimensional vectors. i.e.,
  #writing[$vc(a)in CC^n$] means "$vc(a)$ is a complex $n$-dimensional vector."
  This notation is consistent with #writing[$RR^(m,n)$] and #writing[$CC^(m,n)$] (the set of all $m times n$ real or complex matrices).
  The $k$-th component of a vector $vc(a)$ should be denoted by #writing[$(vc(a))""_k$], but we may write it as #writing[$a_k$] if not confusing.

  We will also use a shorthanded notation, #writing[$KK$], to express either $RR$ or $CC$, and you need to identify its meaning from the context.
  For example,
  #writing[If $vc(v) in KK^3$, then $v_k in KK$ but $|vc(v)| in RR$] is to mean
  #tab[
    #set par(leading: dim.leading)
    If $vc(v)$ is a (real / complex) 3-dimensional vector, then its $k$-th component is a (real / complex) number and its magnitude $|vc(v)|$ is always a real number.
  ]
]

#divider()

First, we summarize what we have discussed about vectors.
A $n$-dimensional (real / complex) vector, $vc(v) in KK^n$, is a column array of $n$ (real / complex) numbers $v_k in KK$:
$
  vc(v) = mat(v_1; dots.v; v_n); wide
  vc(v)+vc(w) = mat(v_1+w_1; dots.v; v_n+w_n), wide
  k vc(v) = mat(k v_1; dots.v; k v_n) quad (k in KK).
$<eq:mat-vec1>
Notice that $k in KK$ means $k$ can only be a real number if we are considering real vectors, while $k$ is complex if we are considering complex vectors.

The inner product and magnitude are given by
$
  & "for" vc(v), vc(w) in RR^n, quad &&vip(v, w) = sum_(k=1)^n v_k w_k, quad && |vc(v)| = sqrt(vip(v, v))= sum_(k=1)^n v_k^2; \
  & "for" vc(v), vc(w) in CC^n, quad &&cip(v, w) = sum_(k=1)^n overline(v_k) w_k, quad &&|vc(v)| = sqrt(cip(v, v))= sum_(k=1)^n |v_k|^2. \
$<eq:mat-vec2>
#remark[
  We *must* use the notation $cip(v, w)$ for complex vectors. Meanwhile, for real vectors, we usually use $vip(v, w)$ but also we may write $cip(v, w)$.
]

For their properties, review @chap:vector and @chap:complex. Cross products are only defined for $RR^3$:
$
  & "for" vc(v), vc(w) in RR^3, quad vc(v) times vc(w) = mat(v_2 w_3 - v_3 w_2; v_3 w_1 - v_1 w_3; v_1 w_2 - v_2 w_1).
$<eq:mat-vec3>
For complex vectors or real vectors other than 3d, the cross product is not defined.

We also discussed orthogonal bases of $KK^n$. _An_ orthogonal basis is made of $n$ vectors $vc(e)_1, ..., vc(e)_n$, where $vc(e)_k in KK^n$, that satisfy
$
  lr(size: #1.5em, (thick|vc(e)_k| = 1thick)) thick and thick lr(size: #1.5em, (thick j != k ==> lbk(vc(e)_j, vc(e)_k) = 0thick))quad "for all" j, k = 1, ..., n,
$<eq:mat-vec-basis>
or more simply,
$
  lbk(vc(e)_j, vc(e)_k) = delta_(j k)quad "for all" j, k = 1, ..., n,
$<eq:mat-vec-basis-def1>
where we introduced the #keyword[Kronecker delta] $delta_(j k)$, which is defined as
$
  delta_(j k) := cases(1 "if" j=k",", 0 "if" j != k.)
$<eq:mat-vec-basis-def2>
#problems[
  + `4` Prove @eq:mat-vec-basis-def1 and @eq:mat-vec-basis-def2 are equivalent.
  + `1` This discussion assumes that an orthonormal basis of $KK^n$ always have $n$ vectors, which we have not proved yet. So, prove that the number of basis vectors in an orthonormal basis of $KK^n$ is always $n$.
]

#block(breakable: false)[
  = Change of basis <sec:mat-basis-change>
  For vectors $KK^n$, we have many (actually infinite) orthonormal bases. For example, for $CC^2$,
  $
    \{vc(e)_1, vc(e)_2\} "with" vc(e)_1=mat(1; 0),quad vc(e)_2 = mat(0; 1) quad "and" quad
    \{vc(f)_1, vc(f)_2\} "with" vc(f)_1=mat(0; ii),quad vc(f)_2 = mat(-ii; 0)
  $
  are both orthonormal bases.
  #quizzes[
    + Show $lbk(vc(e)_j, vc(e)_k) = delta_(j k)$ and $lbk(vc(f)_j, vc(f)_k) = delta_(j k)$.
  ]
]
Recall that the component-wise notation is based on a specific orthonormal basis.
If we used $\{vc(f)_1, vc(f)_2}$ instead of $\{vc(e)_1, vc(e)_2}$, the component-based notation would be different.
For example, $vc(v) = mat(3; 2)$ actually means
$
  vc(v) = mat(3; 2) = 3vc(e)_1 + 2vc(e)_2, quad "which is equal to" quad -2ii mat(0; ii)+3ii mat(-ii; 0) = - 2ii vc(f)_1+3ii vc(f)_2 .
$
So, if we had chosen $\{vc(f)_1, vc(f)_2}$ as our favorite basis, we would write
$ vc(v) = mat(-2ii; 3ii)_(f), $
where the subscript $f$ emphasizes that the components are under the basis $\{vc(f)_1, vc(f)_2\}$.

#divider()

#make-indent
In physics, we often switch from one basis to another.
Choosing a basis means choosing the axes of the space#footnote[→#ref(form: "page", <topic:basis-defines-axes>)].
We should choose the basis so that we can analyze the problem easily.
The axes belong to the whole space, not to a single vector.
Therefore, we cannot change the basis of just one vector.
We have to rewrite all the vectors in the new basis.

Suppose we have vectors $vc(a)$, $vc(b)$, ..., written under the basis $\{vc(e)_1, ..., vc(e)_n\}$:
(For some reason, it is useful to write $vc(e)_1 a_1$ instead of $a_1 vc(e)_1$ when we discuss basis transformation.)
$
  vc(a) = mat(a_1; dots.v; a_n)_(e) = vc(e)_1a_1 + dots + vc(e)_n a_n, quad "etc."
$
How can we change the basis of all of them at once, to the new basis $\{vc(f)_1, ..., vc(f)_n\}$?
The key idea is that the old basis vectors $vc(e)_k$ can be expressed in terms of the new basis vectors $vc(f)_k$:
$
  vc(e)_k = vc(f)_1u_(1 k) + vc(f)_2 u_(2 k) + dots + vc(f)_n u_(n k) = sum_(j=1)^n vc(f)_j u_(j k) = mat(u_(1 k); dots.v; u_(n k))_(f) quad "for" k=1, ..., n,
$<eq:mat-basis-change0>
where, again, we use the subscript $f$ to emphasize that the components are under the new basis.
So,
$
  vc(a) = sum_(k=1)^n vc(e)_k a_k =sum_(k=1)^n (sum_(j=1)^n vc(f)_j u_(j k) )a_k
  =sum_(j=1)^n vc(f)_j sum_(k=1)^n u_(j k)a_k
  =sum_(j=1)^n vc(f)_j a'_j quad "with" a'_j := sum_(k=1)^n u_(j k)a_k
$<eq:mat-basis-change1>
and this equation already shows the expression of $vc(a)$ under the new basis: we have got
$vc(a) = mat(a'_1; dots.v; a'_n)_(f).$
#quizzes[
  + Explain each equal symbol "=" in @eq:mat-basis-change1. Also, explain why the equation means $vc(a)= mat(a'_1; dots.v; a'_n)_(f).$
  + The coefficient $u_(j k)$ in @eq:mat-basis-change0 is given by $u_(j k)=lbk(vc(f)_j, vc(e)_k)$. Explain why. #hint[Calculate the inner product, using @thm:vc-ip-prop.]
]
#theorem(title: [Change of basis])[
  Consider $KK^n$ and two bases on it: $\{vc(e)_1, dots, vc(e)_n\}$ ("old" basis) and $\{vc(f)_1, dots, vc(f)_n\}$ ("new" basis).
  If a vector $vc(a)$ is written under the old basis as
  $
    vc(a) = mat(a_1; dots.v; a_n)_(e) = sum_(k=1)^n vc(e)_k a_k,
  $
  then it can be rewritten under the new basis as
  $
    vc(a) = mat(a'_1; dots.v; a'_n)_(f) = sum_(k=1)^n vc(e)_k a'_k,
  $
  where the new components $a'_j$ are given by
  $
    a'_j := sum_(k=1)^n u_(j k)a_k, wide u_(j k) = lbk(vc(f)_j, vc(e)_k).
  $
]
We will come back to this discussion later.

= Matrices <sec:mat-def>
#remark[
  This is a quick review; you should already be familiar with matrix arithmetic.
]
We introduce matrices as a 2d extension of vectors.

#definition(title: "Matrix")[
  A (complex / real) $m times n$ #keyword[matrix] is defined as a 2d array of (complex / real) numbers,
  $
    A = mat(
      A_(1 1), A_(1 2), dots, A_(1 n);
      A_(2 1), A_(2 2), dots, A_(2 n);
      dots.v, dots.v, dots.down, dots.v;
      A_(m 1), A_(m 2), dots, A_(m n);
    ); quad a_(j k) in KK.
  $
  In particular; we name a #keyword[rows], a #keyword[column] and a #keyword[component] as follows:
  $
    j"-th row:" mat(A_(j 1), A_(j 2), dots, A_(j n)); quad
    k"-th column:" mat(A_(1 k); dots.v; A_(m k)); quad
    (j,k)"-component:" A_(j k);
  $
  "$n times m$" is called the #keyword[size] of the matrix. We write the set of all $n times m$ matrix as $KK^(m,n)$.
]
For example, we can write #writing[$M$ is a complex $3 times 2$ matrix] by #writing[$M in CC^(3,2)$].
#remark[
  - The last component of a $m times n$ matrix is $A_(m n)$.
  - Co#text(weight: "bold", "l")umns are tall because "#text(weight: "bold", "l")" is tall; rows are flat because "r-o-w" is flat.
]

#quizzes[
  + Write a $5 times 2$ matrix. Answer the number of its components. Answer how many rows and columns does it have. Answer the number of the components in its first row. Answer the number of the components in its first column.
  + Consider a $a times b$ matrix. Answer the number of its components. Answer how many rows and columns does it have. Answer the number of the components in its first row. Answer the number of the components in its first column.
]
Also, vectors $vc(v)=mat(v_1; dots.v; v_n)$ are called #keyword[column vectors].
We will later see #keyword[row vectors] $vc(v)^TT=mat(v_1, dots, v_n)$.
#quizzes[
  + $1 times n$ matrices and $n times 1$ matrices can be identified as column vectors or row vectors. Which is which?
]
#be-careful[
  $mat(v_1; dots.v; v_n)$ and $mat(v_1, dots, v_n)$ are different objects.
]
You will consider complex matrices in quantum mechanics courses, while in other physics we usually use real matrices.
A real matrix is (of course) a complex matrix, so it is almost enough if you learn about complex matrices.

= Basic operations on matrices <sec:mat-ops>
You need to learn following operations for matrices:
- addition and scalar multiplication
- transposition, complex conjugate, and Hermitian conjugate
- matrix multiplication (@sec:mat-mul)
- trace and determinant (@sec:mat-det)

#keyword[Addition] and #keyword[scalar multiplication] are defined just like vectors:
#definition(title: [Addition and scalar multiplication])[
  #keyword[Addition] and #keyword[scalar multiplication] of $m times n$ matrices are defined by
  $
    A + B := mat(A_(11) + B_(11), A_(12) + B_(12), dots, A_(1 n) + B_(1 n); A_(21) + B_(21), A_(22) + B_(22), dots, A_(2 n) + B_(2 n); dots.v, dots.v, dots.down, dots.v; A_(m 1) + B_(m 1), A_(m 2) + B_(m 2), dots, A_(m n) + B_(m n)),
    quad
    k A := mat(k A_(11), dots, k A_(1 n); k A_(21), dots, k A_(2 n); dots.v, dots.down, dots.v; k A_(m 1), dots, k A_(m n))
  $
  for the matrices $A$ and $B$ with same size.
]
Notice that $A+B$ is _not defined_ if $A$ and $B$ are in different size.

#EMPH[Transposition], #EMPH[complex conjugate], and #EMPH[Hermitian conjugate] are defined as follows:
#definition(title: [Transposition, complex conjugate, and Hermitian conjugate])[
  Let $A$ be a $m times n$ matrix.
  Its #keyword[transposition] $A^TT$ is defined by a $n times m$ matrix with
  $(A^TT)_(i j) = A_(j i).$
  The #keyword[complex conjugate] $overline(A)$ of a matrix $A$ is defined by
  $(thin overline(A)thin )_(i j) := overline(A_(i j))$.
  The #keyword[Hermitian conjugate] $A^dagger$ of a matrix $A$ is defined by
  $A^dagger := overline(A)^T = overline(A^T)$.
]
#be-careful[Memorize these words: "complex conjugate" and "Hermitian conjugate".]
#example[
  Let $A = display(mat(1, 2+ii, 3ii; -4ii, 5+6ii, -7ii))$.
  Then its transposition is
  $A^T = display(mat(1, -4ii; 2+ii, 5+6ii; 3ii, -7ii))$, complex conjugate is $overline(A) = display(mat(1, 2-ii, -3ii; 4ii, 5-6ii, 7ii))$, and Hermitian conjugate is $A^dagger = display(mat(1, 4ii; 2-ii, 5-6ii; -3ii, 7ii)).$
]
#quizzes[
  +
    #h-enum(cols: 1, label-align: horizon)[
      + Let $A = mat(1, 2+ii; -3ii, 4)$. Compute $A^T$, $overline(A)$, and $A^dagger$.
      + Write a $3 times 2$ matrix $A$ whose elements are given by $A_(i j) = i + j$.
      + For a matrix $A$, determine the condition under which $A + A^TT$ is defined.
      + Find a matrix $A$ that is _not_ real and satisfies $A = A^dagger$.
    ]
]

== Matrix-vector multiplication

We now define how a matrix acts on a vector, which corresponds to applying the linear transformation.

#definition(title: [Matrix-vector multiplication])[
  Let $A = (a_(i j)) in RR^(m times n)$ and $vc(v) = mat(v_1; dots.v; v_n) in RR^n$.
  The #keyword[product] $A vc(v)$ is the vector in $RR^m$ defined by
  $
    A vc(v) = mat(
      a_(1 1) v_1 + a_(1 2) v_2 + dots + a_(1 n) v_n;
      a_(2 1) v_1 + a_(2 2) v_2 + dots + a_(2 n) v_n;
      dots.v;
      a_(m 1) v_1 + a_(m 2) v_2 + dots + a_(m n) v_n;
    ).
  $
  In other words, the $i$-th entry of $A vc(v)$ is $sum_(j=1)^n a_(i j) v_j$.
]


#theorem(title: [Matrix as a linear transformation])[
  The map $T : RR^n -> RR^m$ defined by $T(vc(v)) = A vc(v)$ is a linear transformation.
  Conversely, every linear transformation $T : RR^n -> RR^m$ corresponds to a unique matrix $A in RR^(m times n)$, where the $j$-th column of $A$ is $T(vc(e)_j)$.
]<thm:mat-linear>

So matrices and linear transformations are in one-to-one correspondence (once a basis is fixed).

#example(title: [Reading a linear transformation as a matrix])[
  The linear transformation that sends $dm(x; y) |-> dm(x+2y; 3x-y)$ corresponds to which matrix?
]
#solution[
  Check: $T(vc(e)_x) = T(dm(1; 0)) = dm(1; 3)$ and $T(vc(e)_y) = T(dm(0; 1)) = dm(2; -1)$.
  These become the columns, so $A = mx(1, 2; 3, -1)$.
  Indeed, $mx(1, 2; 3, -1) dm(x; y) = dm(x+2y; 3x-y)$.
]

#quizzes[
  + Compute the following matrix-vector products.
    #h-enum(cols: 3)[
      + $mx(2, -1; 0, 3) dm(1; 2)$
      + $mx(1, 0, -1; 2, 1, 0) dm(1; -1; 2)$
      + $mx(0, 1; -1, 0) dm(3; 4)$
    ]
  + For each of the following linear transformations $T : RR^2 -> RR^2$, find the corresponding matrix.
    #h-enum(cols: 2)[
      + $T(dm(x; y)) = dm(3x; y)$
      + $T(dm(x; y)) = dm(y; x)$
      + $T(dm(x; y)) = dm(x - y; x + y)$
      + $T(dm(x; y)) = dm(0; 0)$ (zero map)
    ]
]

#problems[
  + `9` Compute the following.
    #h-enum(cols: 3)[
      + $mx(1, 2; 3, 4) dm(1; 0)$
      + $mx(1, 2; 3, 4) dm(0; 1)$
      + $mx(1, 2; 3, 4) dm(1; 1)$
      + $mx(1, 2; 3, 4) dm(2; -1)$
      + $mx(1, 0, 0; 0, 1, 0; 0, 0, 1) dm(a; b; c)$
      + $mx(2, 0; 0, 2) dm(x; y)$
      + $mx(0, -1; 1, 0) dm(3; 4)$
      + $mx(1, 0; 0, -1) dm(x; y)$
      + $mx(1, 1, 1; 1, 1, 1) dm(1; 2; 3)$
    ]
  + `4` For each $T$ below, find the matrix $A$ such that $T(vc(v)) = A vc(v)$.
    #h-enum(cols: 1)[
      + Reflection across the $x$-axis: $T(dm(x; y)) = dm(x; -y)$.
      + Projection to the line $y=x$: $T(dm(x; y)) = dm((x+y)/2; (x+y)/2)$.
      + The map $T : RR^3 -> RR^2$ given by $T(dm(x; y; z)) = dm(x+y; y-z)$.#lorem(40)
      + The map $T : RR^2 -> RR^3$ given by $T(dm(x; y)) = dm(x; x-y; 2y)$.
    ]
]

#pagebreak()

= Matrix Multiplication <sec:mat-mul>

If $T_1 : RR^n -> RR^m$ and $T_2 : RR^m -> RR^l$ are linear transformations, their composition $T_2 compose T_1 : RR^n -> RR^l$ is also linear.
Matrix multiplication is defined to correspond to composition of linear transformations.

#definition(title: [Matrix multiplication])[
  Let $A = (a_(i j)) in RR^(m times n)$ and $B = (b_(j k)) in RR^(n times l)$.
  The #keyword[product] $A B in RR^(m times l)$ is defined by
  $
    (A B)_(i k) = sum_(j=1)^n a_(i j) b_(j k).
  $
  The $(i,k)$-entry of $A B$ is the inner product of the $i$-th _row_ of $A$ with the $k$-th _column_ of $B$.
]

#be-careful[
  $A B$ is only defined when the number of columns of $A$ equals the number of rows of $B$.
  In general, $A B != B A$; matrix multiplication is *not commutative*.
]

#example(title: [Matrix multiplication])[
  Compute $mx(1, 2; 3, 4) mx(0, -1; 1, 2)$.
]
#solution[
  #no-num[$
    mx(1, 2; 3, 4) mx(0, -1; 1, 2)
    = mx(1dot 0+2 dot 1, 1dot(-1)+2dot 2; 3dot 0+4dot 1, 3dot(-1)+4dot 2)
    = mx(2, 3; 4, 5).
  $]
]

#theorem(title: [Properties of matrix multiplication])[
  For matrices of compatible sizes and scalars $k$:
  #v-enum(cols: 2, label-style: "(A)")[
    + $(A B) C = A (B C)$ (associativity)
    + $A (B + C) = A B + A C$ (distributivity)
    + $(A + B) C = A C + B C$
    + $k (A B) = (k A) B = A (k B)$
    + $A B != B A$ in general
    + $A B = A C$ does not imply $B = C$
  ]
  The #keyword[identity matrix] $I_n$ (or just $I$) satisfies $A I = I A = A$ for square $A$.
]<thm:mat-mul-props>

#definition(title: [Identity matrix and zero matrix])[
  The $n times n$ #keyword[identity matrix] is $I_n = (delta_(i j))$, where $delta_(i j) = 1$ if $i=j$ and $0$ if $i != j$:
  $
    I_2 = mx(1, 0; 0, 1), quad I_3 = mat(1, 0, 0; 0, 1, 0; 0, 0, 1).
  $
  The #keyword[zero matrix] $O$ has all entries $0$: $A O = O A = O$.
]

#quizzes[
  + Compute the following.
    #h-enum(cols: 3)[
      + $mx(1, 0; 0, 1) mx(3, 5; -2, 4)$
      + $mx(3, 5; -2, 4) mx(1, 0; 0, 1)$
      + $mx(2, 1; 0, 3) mx(1, -1; 0, 1)$
      + $mx(1, -1; 0, 1) mx(2, 1; 0, 3)$
      + $mx(1, 2; 3, 4)^2$
      + $mx(0, 1; -1, 0)^4$
    ]
  + Show that $A I = A$ for any $2 times 2$ matrix $A$ and $I = I_2$.
]

#problems[
  + `9` Compute the following.
    #h-enum(cols: 3)[
      + $mx(2, 1; -1, 3) mx(1, 2; 0, -1)$
      + $mx(0, 1; 1, 0) mx(a, b; c, d)$
      + $mx(a, b; c, d) mx(0, 1; 1, 0)$
      + $mat(1, 0, -1; 2, 1, 0) mat(1, 2; -1, 0; 3, 1)$
      + $mx(1, 2; 3, 4) mx(a, b; c, d) - mx(a, b; c, d) mx(1, 2; 3, 4)$
      + $mx(cos theta, -sin theta; sin theta, cos theta)^2$
    ]
  + `4` Prove the associativity $(A B) C = A (B C)$ for $A in RR^(m times n)$, $B in RR^(n times l)$, $C in RR^(l times p)$.
    #hint[Show both sides have the same $(i, k)$-entry.]
  + `3` A matrix $A$ is called #keyword[idempotent] if $A^2 = A$.
    Show that $P = mx(1/2, 1/2; 1/2, 1/2)$ is idempotent. Interpret $P$ geometrically.
  + `2` Show that if $A B = B A$ for _all_ matrices $B$ (of compatible size), then $A$ must be a scalar multiple of the identity matrix.
]

#pagebreak()

= Determinant and Trace <sec:mat-det>

Two important numbers attached to a square matrix are the #keyword[determinant] and the #keyword[trace].

== Trace

#definition(title: [Trace])[
  The #keyword[trace] of an $n times n$ matrix $A = (a_(i j))$ is the sum of diagonal entries:
  $
    tr(A) := a_(1 1) + a_(2 2) + dots + a_(n n) = sum_(i=1)^n a_(i i).
  $
]

#theorem[
  For $n times n$ matrices $A$ and $B$ and scalar $k$:
  $
    tr(A + B) = tr(A) + tr(B), quad
    tr(k A) = k med tr(A), quad
    tr(A B) = tr(B A).
  $
]

== Determinant

The determinant of a square matrix $A$, written $det(A)$ or $|A|$, is a single number that encodes important information about the linear transformation.
Its most important meaning: $det(A) = 0$ if and only if the transformation is not invertible (it "squashes" space).

#definition(title: [Determinant: $1 times 1$ and $2 times 2$])[
  For a $1 times 1$ matrix $(a)$: $quad det(a) := a.$

  For a $2 times 2$ matrix $A = mx(a, b; c, d)$:
  $
    det(A) = det(mx(a, b; c, d)) = mat(delim: "|", a, b; c, d) := a d - b c.
  $<eq:det2>
]

#definition(title: [Determinant: $3 times 3$ (cofactor expansion along first row)])[
  For a $3 times 3$ matrix $A = mat(a_(1 1), a_(1 2), a_(1 3); a_(2 1), a_(2 2), a_(2 3); a_(3 1), a_(3 2), a_(3 3))$:
  $
    det(A) = a_(1 1) det(mx(a_(2 2), a_(2 3); a_(3 2), a_(3 3)))
    - a_(1 2) det(mx(a_(2 1), a_(2 3); a_(3 1), a_(3 3)))
    + a_(1 3) det(mx(a_(2 1), a_(2 2); a_(3 1), a_(3 2))).
  $<eq:det3>
  Each $2 times 2$ determinant is called a #keyword[minor]; the pattern of signs $(+, -, +)$ is important.
]

#be-careful[
  The pattern of signs in the $3 times 3$ determinant is $+$, $-$, $+$ for the first row.
  For the second row it is $-$, $+$, $-$, and for the third row $+$, $-$, $+$.
]

#example(title: [$2 times 2$ and $3 times 3$ determinants])[
  Compute $det mx(3, -1; 2, 5)$ and $det mat(1, 2, 3; 0, 4, 5; 1, 0, 6)$.
]
#solution[
  #no-num[$
    det mx(3, -1; 2, 5) = 3 dot 5 - (-1) dot 2 = 15 + 2 = 17.
  $]
  #no-num[$
    det mat(1, 2, 3; 0, 4, 5; 1, 0, 6)
    = 1 dot det mx(4, 5; 0, 6) - 2 dot det mx(0, 5; 1, 6) + 3 dot det mx(0, 4; 1, 0)
    = 1(24) - 2(-5) + 3(-4)
    = 24 + 10 - 12 = 22.
  $]
]

#theorem(title: [Properties of the determinant])[
  For $n times n$ matrices $A$ and $B$ and scalar $k$:
  #v-enum(cols: 2, label-style: "(A)")[
    + $det(A B) = det(A) det(B)$
    + $det(k A) = k^n det(A)$
    + $det(A^T) = det(A)$
    + $det(A) != 0 <==>$ $A$ is invertible
    + $det(I_n) = 1$
    + If two rows of $A$ are swapped, $det$ changes sign.
    + If a row of $A$ is multiplied by $k$, $det$ is multiplied by $k$.
    + If a multiple of one row is added to another, $det$ is unchanged.
  ]
]<thm:det-props>

#quizzes[
  + Compute the following determinants.
    #h-enum(cols: 3)[
      + $mat(delim: "|", 2, 3; 1, 4)$
      + $mat(delim: "|", cos theta, -sin theta; sin theta, cos theta)$
      + $mat(delim: "|", a, b; -b, a)$
      + $mat(delim: "|", 1, 0, 0; 0, 2, 0; 0, 0, 3)$
      + $mat(delim: "|", 1, 2, 0; 0, 1, 3; 0, 0, 1)$
      + $mat(delim: "|", 1, 1, 1; 1, 2, 3; 1, 4, 9)$
    ]
  + What does $det(A) = 0$ tell you geometrically for a $2 times 2$ matrix $A$?
  #fail-safe[Think about what happens to the area of the unit square under the transformation $A$.]
]

#problems[
  + `9` Compute $det(A)$ and $tr(A)$ for each.
    #h-enum(cols: 2)[
      + $A = mx(3, -2; 1, 4)$
      + $A = mx(-1, 5; 0, 2)$
      + $A = mat(2, 1, 0; -1, 3, 2; 0, 1, -1)$
      + $A = mat(1, 2, 3; 4, 5, 6; 7, 8, 9)$
    ]
  + `4` Prove $tr(A B) = tr(B A)$ for $A, B in RR^(n times n)$.
    #hint[Write out $(A B)_(i i) = sum_j a_(i j) b_(j i)$ and sum over $i$.]
  + `4` For $A = mx(a, b; c, d)$, prove $A(a d-b c)I = (a d-b c)A$ and hence $A^(-1) = 1/(a d-b c) mx(d, -b; -c, a)$ if $det A != 0$.
  + `3` Show that $det(A^2) = det(A)^2$ and $det(A^n) = det(A)^n$ for any $n in NN$.
  + `2` Prove: if $A$ is an $n times n$ matrix and $det(A) != 0$, then the equation $A vc(v) = vc(0)$ has only the trivial solution $vc(v) = vc(0)$.
]

#pagebreak()

= Special Matrices <sec:mat-special>

Several special classes of matrices arise frequently in physics.

== Transpose and conjugate transpose

#definition(title: [Transpose and conjugate transpose])[
  For a matrix $A = (a_(i j)) in CC^(m times n)$:

  - The #keyword[transpose] $A^T = (a_(j i)) in CC^(n times m)$: swap rows and columns.

  - The #keyword[conjugate transpose] (or #keyword[Hermitian conjugate]) $A^dagger = overline(A)^T = (overline(a_(j i))) in CC^(n times m)$: transpose _and_ take complex conjugates.
]

#remark[
  Some textbooks write $A^*$ instead of $A^dagger$ for the conjugate transpose.
  In physics, $A^dagger$ (read: "$A$ dagger") is the standard notation.
  For a real matrix, $A^dagger = A^T$.
]

#quizzes[
  + Let $A = mx(1+ii, 2; -ii, 3-ii)$. Find $A^T$ and $A^dagger$.
  + Show that $(A B)^T = B^T A^T$ and $(A B)^dagger = B^dagger A^dagger$.
  #fail-safe[Compute the $(i,j)$-entry of both sides.]
]

== Special classes

#definition(title: [Special square matrices])[
  Let $A in CC^(n times n)$. We say $A$ is:

  #table(
    columns: (auto, 1fr, auto),
    stroke: none,
    align: (left, left, left),
    table.hline(),
    [*Name*], [*Condition*], [*Example*],
    table.hline(stroke: 0.5pt),
    [#keyword[symmetric]], [$A^T = A$], [$mx(1, 2; 2, 3)$],
    [#keyword[anti-symmetric]], [$A^T = -A$], [$mx(0, 1; -1, 0)$],
    [#keyword[Hermitian]], [$A^dagger = A$], [$mx(1, ii; -ii, 2)$],
    [#keyword[anti-Hermitian]], [$A^dagger = -A$], [$mx(ii, 1; -1, ii)$],
    [#keyword[orthogonal]], [$A^T A = I$, $A in RR^(n times n)$], [$mx(cos theta, -sin theta; sin theta, cos theta)$],
    [#keyword[unitary]], [$A^dagger A = I$], [],
    [#keyword[diagonal]], [$a_(i j) = 0$ for $i != j$], [$mx(2, 0; 0, 3)$],
    table.hline(),
  )
]

#remark[
  A symmetric matrix is a special case of Hermitian (when all entries are real).
  An orthogonal matrix is a special case of unitary.
  In physics, Hermitian and unitary matrices are especially important (quantum mechanics!).
]

#quizzes[
  + For $A = mx(1, 2; 2, 3)$, verify $A^T = A$.
  + For $A = mx(1, ii; -ii, 2)$, verify $A^dagger = A$.
  + For $A = mx(cos theta, -sin theta; sin theta, cos theta)$, verify $A^T A = I$.
]

#problems[
  + `4` Classify each of the following matrices.
    #h-enum(cols: 2)[
      + $mx(0, -1; 1, 0)$
      + $mx(1, 1+ii; 1-ii, -1)$
      + $mx(1, 0; 0, -1)$
      + $1/sqrt(2) mx(1, -1; 1, 1)$
      + $mx(ii, 0; 0, -ii)$
      + $mat(0, 1, 0; -1, 0, 1; 0, -1, 0)$
    ]
  + `3` Show that for any matrix $A in CC^(n times n)$:
    + $A + A^dagger$ is Hermitian.
    + $A - A^dagger$ is anti-Hermitian.
    + Any matrix can be written as a sum of a Hermitian and an anti-Hermitian matrix.
  + `3` Show that if $A$ is unitary, then $|det A| = 1$.
  + `2` Show that the eigenvalues of a Hermitian matrix are real.
    #hint[Let $A vc(v) = lambda vc(v)$ with $vc(v) != vc(0)$. Compute $cip(v, A v)$ in two ways.]
]

#pagebreak()

= Rotation, Reflection, and Scaling in 2d <sec:mat-geom>

We now apply matrices to concrete geometric transformations in $RR^2$.
Write $vc(v) = dm(x; y)$ and use the standard basis $\{vc(e)_x, vc(e)_y\}$.

== Scaling

Scaling by $(s_x, s_y)$ means multiplying the $x$-component by $s_x$ and the $y$-component by $s_y$:
$
  dm(x; y) |-> dm(s_x x; s_y y) = mx(s_x, 0; 0, s_y) dm(x; y).
$
Scaling by a single constant $s$ in all directions (dilation) uses $s I$.

== Reflection

Reflection across the $x$-axis sends $(x, y) |-> (x, -y)$:
$
  R_x = mx(1, 0; 0, -1).
$
Reflection across the $y$-axis: $R_y = mx(-1, 0; 0, 1)$.

What about reflection across the line $y = x tan alpha$ (a line through the origin at angle $alpha$)?
The general formula is
$
  R_alpha = mx(cos 2alpha, sin 2alpha; sin 2alpha, -cos 2alpha).
$<eq:mat-reflect>

#quizzes[
  + Verify @eq:mat-reflect for $alpha = 0$ (reflection across the $x$-axis) and $alpha = pi\/4$ (reflection across $y = x$).
  + Show that $(R_alpha)^2 = I$ for any $alpha$. Explain this geometrically.
]

== Rotation

Counterclockwise rotation by angle $theta$ sends $vc(e)_x |-> dm(cos theta; sin theta)$ and $vc(e)_y |-> dm(-sin theta; cos theta)$.
These become the columns:

#definition(title: [Rotation matrix])[
  The counterclockwise rotation by $theta$ in $RR^2$ is represented by
  $
    R(theta) = mx(cos theta, -sin theta; sin theta, cos theta).
  $<eq:mat-rotate>
]

#theorem[
  $
    R(theta) R(phi) = R(theta + phi), quad R(theta)^(-1) = R(-theta), quad det R(theta) = 1, quad R(theta)^T R(theta) = I.
  $
]

#example(title: [Rotation by $pi\/4$])[
  The vector $dm(1; 0)$ rotated counterclockwise by $pi\/4$ gives
  $R(pi\/4) dm(1; 0) = mx(cos(pi/4), -sin(pi/4); sin(pi/4), cos(pi/4)) dm(1; 0) = dm(1\/sqrt(2); 1\/sqrt(2)).$
]

#quizzes[
  + Verify $R(theta) R(phi) = R(theta + phi)$ by direct computation.
    #hint[Use the angle-addition formulas for $sin$ and $cos$.]
  + For what $theta$ does $R(theta) = I$? For what $theta$ does $R(theta)$ equal reflection across the $x$-axis?
]

#problems[
  + `9` Compute $R(theta) vc(v)$ for:
    #h-enum(cols: 3)[
      + $theta = pi\/2$, $vc(v) = dm(1; 0)$
      + $theta = pi$, $vc(v) = dm(0; 1)$
      + $theta = pi\/3$, $vc(v) = dm(1; 1)$
      + $theta = -pi\/4$, $vc(v) = dm(sqrt(2); 0)$
      + $theta = pi\/6$, $vc(v) = dm(sqrt(3); 1)$
      + $theta = 2pi\/3$, $vc(v) = dm(1; -1)$
    ]
  + `4` Show the following.
    #h-enum(cols: 1)[
      + $R(theta)$ is orthogonal for all $theta$.
      + $det R(theta) = 1$ for all $theta$.
      + $R(theta)^(-1) = R(-theta)$.
      + Verify the identity $R(theta) R(phi) = R(theta + phi)$.
    ]
  + `3` The composition of two reflections is a rotation. Specifically, show that
    $R_(pi\/2) R_0 = R(pi)$, where $R_0$ is reflection across the $x$-axis and $R_(pi\/2)$ is reflection across the $y$-axis.
    Then, more generally, show that $R_beta R_alpha = R(2(beta - alpha))$, where $R_alpha$ and $R_beta$ are reflections from @eq:mat-reflect.
  + `2` A rotation in $RR^3$ about the $z$-axis by angle $theta$ is represented by
    $
      R_z(theta) = mat(cos theta, -sin theta, 0; sin theta, cos theta, 0; 0, 0, 1).
    $
    Write down analogous matrices $R_x(theta)$ and $R_y(theta)$ for rotations about the $x$- and $y$-axes.
    Show that $R_x(theta)$, $R_y(theta)$, and $R_z(theta)$ are all orthogonal with determinant 1.
    + Show that in general $R_x(alpha) R_y(beta) != R_y(beta) R_x(alpha)$ (rotations in 3d do not commute).
]
= Linear Transformations <sec:mat-linear>

#definition(title: [Linear transformation])[
  A map $T : RR^n -> RR^m$ (or $T : CC^n -> CC^m$) is called a #keyword[linear transformation] (or #keyword[linear map]) if, for any vectors $vc(v), vc(w)$ in the domain and any scalar $k$,
  $
    T(vc(v) + vc(w)) = T(vc(v)) + T(vc(w)), quad
    T(k vc(v)) = k T(vc(v)).
  $<eq:mat-linear>
  Equivalently, $T(p vc(v) + q vc(w)) = p T(vc(v)) + q T(vc(w))$ for any scalars $p, q$.
]

#be-careful[
  Not every map is linear.
  For example, the map $T : RR^1 -> RR^1$ defined by $T(x) = x^2$ is _not_ linear, because $T(2) = 4$ but $2T(1) = 2$.
]

#example(title: [Examples of linear transformations in 2d])[
  + *Scaling* by a constant $c > 0$: $T(vc(v)) = c vc(v)$.
  + *Rotation* by angle $theta$ counterclockwise: $T(vc(v))$ is $vc(v)$ rotated by $theta$.
  + *Projection* onto the $x$-axis: $T(dm(x; y)) = dm(x; 0)$.
  + *Zero map*: $T(vc(v)) = vc(0)$ for all $vc(v)$.
  + *Identity*: $T(vc(v)) = vc(v)$ for all $vc(v)$.
]

#quizzes[
  + Verify that scaling (@eq:mat-linear is satisfied for $T(vc(v)) = c vc(v)$.
  + Check that the map $T(vc(v)) = vc(v) + vc(a)$ (translation by a fixed $vc(a) != vc(0)$) is *not* linear.
  + For a linear transformation $T$, show that $T(vc(0)) = vc(0)$.
    #hint[Apply the definition with $k = 0$.]
]

== A linear transformation is determined by its values on basis vectors

A key fact is that once you know what $T$ does to each basis vector, you know $T$ completely.

#theorem(title: [A linear transformation is determined by basis images])[
  Let $\{vc(e)_1, ..., vc(e)_n\}$ be an orthonormal basis of $RR^n$ (or $CC^n$).
  A linear transformation $T$ is completely determined by the $m$ vectors
  $T(vc(e)_1), T(vc(e)_2), ..., T(vc(e)_n) in RR^m.$
  Specifically, for any $vc(v) = v_1 vc(e)_1 + dots + v_n vc(e)_n$,
  $
    T(vc(v)) = v_1 T(vc(e)_1) + v_2 T(vc(e)_2) + dots + v_n T(vc(e)_n).
  $<eq:mat-T-basis>
]
#proof[
  By linearity, $T(vc(v)) = T(sum_k v_k vc(e)_k) = sum_k v_k T(vc(e)_k)$.
]

#quizzes[
  + A linear transformation $T : RR^2 -> RR^2$ satisfies $T(dm(1; 0)) = dm(1; 2)$ and $T(dm(0; 1)) = dm(-1; 3)$.
    Find $T(dm(3; -2))$ and $T(dm(a; b))$.
]

#pagebreak()

