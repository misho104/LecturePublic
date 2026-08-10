#import "misho-text.typ": *
#import "physica.typ": Im, Re, bra, ket, trace  // cspell: disable-line
#import "2-units.typ": writing, writings
#import "5-vector.typ": dm, va, vc, vcu, vip
#import "6-complex.typ": cip, cop, lbk

We discuss matrices#footnote[One dog, two dogs. One matrix, two matrices. One vertex, two vertices. One index, two indices.], which are deeply tied to vectors, so we will begin with a review of vectors.

#restriction[The space in which the vectors "live" can be with _infinite dimension_. However, as in @chap:vector and @chap:complex, we only consider finite-dimensional spaces in this chapter.]

Since a matrix is described as a two-dimensional list of numbers, e.g.,
$A = mat(1, 2, 3; 4, 5, 6)$ and $B=mat(0, 1+ii; 1-ii, 0)$,
we will first focus on the list-of-numbers interpretation#footnote[→ The beginning of @chap:vector.] of vectors; in #TODO[section]. we will use the arrow interpretation of vectors.

= Review: Vectors as lists of numbers <sec:mat-vec-review>

#[
  #set par(leading: 0.2em)
  Let us introduce some notation for vectors.
  #writing[$RR^n$] is the set of all real $n$-dimensional vectors. i.e.,
  #writing[$vc(a)in RR^n$] means "$vc(a)$ is a real $n$-dimensional vector."
  Similarly,
  #writing[$CC^n$] is the set of all complex $n$-dimensional vectors. i.e.,
  #writing[$vc(a)in CC^n$] means "$vc(a)$ is a complex $n$-dimensional vector."
  This notation is consistent with #writing[$RR^(m,n)$] and #writing[$CC^(m,n)$], which we will see later (the set of all $m times n$ real or complex matrices).
  The $k$-th component of $vc(a)$ is denoted by #writing[$(vc(a))""_k$], but we may write it as #writing[$a_k$] if not confusing.

  We will also use a shorthanded notation, #writing[$KK$], to express either $RR$ or $CC$, and you need to identify its meaning from the context.
  For example,
  #writing[If $vc(v) in KK^3$, then $v_k in KK$ but $|vc(v)| in RR$] is to mean
  #tab[
    #set par(leading: dim.leading)
    If $vc(v)$ is a (real / complex) 3-dimensional vector, then its $k$-th component is a (real / complex) number and its magnitude $|vc(v)|$ is always a real number.
  ]
]

#divider()#v

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
  + `1` This discussion assumes an orthonormal basis of $KK^n$ always have $n$ vectors, which we have not proved yet. So, prove that the number of basis vectors in an orthonormal basis of $KK^n$ is always $n$. #hint[Linear dependency, discussed after this problem, will be useful.]
]

#block(breakable: false)[
  Let us define linear combinations (see @sec:vec-lc) of (real / complex) vectors in a formal way:
  #definition(title: "Linear combination of vectors")[
    Consider (real / complex) vectors $vc(v)_1, ..., vc(v)_m$ and numbers $c_1, ..., c_m$, where $vc(v)_k in KK^n$ and $c_k in KK$.
    $
      sum_(k=1)^m c_k thin vc(v)_k = c_1 thin vc(v)_1 + c_2 thin vc(v)_2 + dots.c + c_m thin vc(v)_m
    $
    is called a #keyword[linear combination] of $vc(v)_1, ..., vc(v)_m$.

    If an equation $sum_(k=1)^m c_k thin vc(v)_k = vc(0)$ has a solution with at least one $c_k != 0$, then we say that $vc(v)_1, ..., vc(v)_m$ are #keyword[linearly dependent]. Otherwise, i.e., if the equation has only the trivial solution $c_1 = ... = c_m = 0$, we say that $vc(v)_1, ..., vc(v)_m$ are #keyword[linearly independent].
  ]
]
Let $S=\{vc(v)_1, dots, vc(v)_m}$ with $vc(v)_k in KK^n$.
If $S$ is linearly dependent, then some vector $vc(v)_p$ in $S$ can be expressed by a linear combination of the other vectors in $S$.
Meanwhile, if $S$ is linearly independent, then it is impossible to do so. Namely, none of the vectors in $S$ can be expressed by a linear combination of the other vectors in $S$.

#advanced-note[
  Consider _an_ orthonormal basis $S$ of $KK^n$. It is obvious that

  - $S$ is linearly independent, and
  - any vectors in $KK^n$ can be expressed as a linear combination of the vectors in $S$.

  It is also easy to prove that $\{vc(v)_1, vc(v)_2, ..., vc(v)_m\}$, where $vc(v)_k in KK^n$, is always linear dependent if $m>n$.
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
    vc(a) = mat(a'_1; dots.v; a'_n)_(f) = sum_(k=1)^n vc(f)_k a'_k,
  $
  where the new components $a'_j$ are given by
  $
    a'_j := sum_(k=1)^n u_(j k)a_k, wide u_(j k) = lbk(vc(f)_j, vc(e)_k).
  $
]<thm:mat-basis-change>
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
  In particular; we name a #EMPH[row], a #EMPH[column] and a #EMPH[component] as follows:
  #index("row (vector)")
  #index("column (vector)")
  #index("component (vector)")
  $
    j"-th row:" mat(A_(j 1), A_(j 2), dots, A_(j n)); quad
    k"-th column:" mat(A_(1 k); dots.v; A_(m k)); quad
    (j,k)"-component:" A_(j k);
  $
  "$n times m$" is called the #EMPH[size] of the matrix. We write the set of all $n times m$ matrix as $KK^(m,n)$.#index("size (matrix)")
]
For example, we can write #writing[$M$ is a complex $3 times 2$ matrix] by #writing[$M in CC^(3,2)$].
#remark[
  - The last component of a $m times n$ matrix is $A_(m n)$.
  - #text("Co" + text(weight: "bold", "l") + "um" + "ns") are tall because "#text(weight: "bold", "l")" is tall; rows are flat because "r-o-w" is flat.
]

#quizzes[
  + Write a $5 times 2$ matrix. Answer the number of its components. Answer how many rows and columns does it have. Answer the number of the components in its first row. Answer the number of the components in its first column.
  + Consider a $a times b$ matrix. Answer the number of its components. Answer how many rows and columns does it have. Answer the number of the components in its first row. Answer the number of the components in its first column.
]

Elements at the diagonal, $A_11$, $A_22$, ..., $A_(n n)$ are called the #keyword[diagonal elements]. Meanwhile, other elements, i.e., $A_(i j)$ with $i!=j$, are called the #keyword[off-diagonal elements].
Also, vectors $vc(v)=mat(v_1; dots.v; v_n)$ are called #EMPH[column vectors].
We will later see #EMPH[row vectors] $vc(v)^TT=mat(v_1, dots, v_n)$.
#index("vector", "column vector")
#index-see("column vector", "vector")
#index("vector", "row vector")
#index-see("row vector", "vector")
#quizzes[
  + $1 times n$ matrices and $n times 1$ matrices can be identified as column vectors or row vectors. Which is which?
]
#be-careful[
  $mat(v_1; dots.v; v_n)$ and $mat(v_1, dots, v_n)$ are different objects.
]
You will consider complex matrices in quantum mechanics courses, while in other physics we usually use real matrices.
A real matrix is (of course) a complex matrix, so it is almost enough if you learn about complex matrices.

#divider()

#[
  #EMPH[Zero matrices]#index("zero matrix"), denoted by $O^(m,n)$, are matrices with all components being zero, such as
  $
    O^(2,3)=mat(0, 0, 0; 0, 0, 0),quad
    O^(3,3)=mat(0, 0, 0; 0, 0, 0; 0, 0, 0),quad
    O^(1,4)=mat(0, 0, 0, 0), quad "etc."
  $
  Sometimes $O_n$ is used to denote $O^(n,n)$.
  Also, we may simply write $O$ instead of $O^(m,n)$ when the size is clear from context.

  #EMPH[Identity matrices]#index("identity matrix"), denoted by $I_n$, are $n times n$ matrices with diagonal components being one and off-diagonal components being zero. Namely, $n times n$ matrices with $(I_n)_(i j) = delta_(i j)$:
  $
    I_2 = mat(1, 0; 0, 1),quad
    I_3 = mat(1, 0, 0; 0, 1, 0; 0, 0, 1),quad"etc."
  $
  #index("identity matrix")
  We may simply write $I$ instead of $I_n$ when the size is clear from context.

  #EMPH[Square matrices]: are matrices that have the same number of rows and columns, i.e., $n times n$ matrices.#index("square matrix") If $A$ is square, $A^TT$, $overline(A)$, and $A^dagger$ are also square matrices.
]

#let op-style = n => text-sf(weight: "bold", sym.chevron.l + str(numbering("i", n)) + sym.chevron.r)
#let cat-of-operations = enum(
  numbering: enum-style(op-style),
  tight: true,
  [addition and scalar multiplication],
  [transposition, complex conjugate, and Hermitian conjugate],
  [matrix multiplication],
  [trace and determinant],
)
= Basic operations on matrices <sec:mat-ops>
You need to learn following operations for matrices:
#cat-of-operations
We first review the definitions of these operation. Their properties are postponed to the next section.

#remark[This note does not discuss #EMPH[rank], #EMPH[elementary row operations], matrix as #keyword[linear equations], #keyword[eigenvalues] and #keyword[eigenvectors], and #keyword[diagonalization of matrices], which will be discussed in sophomore courses.]
#index("rank (matrix)")
#index("elementary row operations")


#block(breakable: false)[
  #make-indent
  #EMPH[Addition]#index("addition (matrix)") and #keyword[scalar multiplication] are defined just like vectors:
  #definition(title: [#op-style(1) Addition and Scalar multiplication])[
    #EMPH[Addition] and #keyword[scalar multiplication] of $m times n$ matrices are defined by
    $
      A + B := mat(A_(11) + B_(11), A_(12) + B_(12), dots, A_(1 n) + B_(1 n); A_(21) + B_(21), A_(22) + B_(22), dots, A_(2 n) + B_(2 n); dots.v, dots.v, dots.down, dots.v; A_(m 1) + B_(m 1), A_(m 2) + B_(m 2), dots, A_(m n) + B_(m n)),
      quad
      k A := mat(k A_(11), dots, k A_(1 n); k A_(21), dots, k A_(2 n); dots.v, dots.down, dots.v; k A_(m 1), dots, k A_(m n))
    $
    for the matrices $A$ and $B$ with same size. If $A$ and $B$ are in different size, $A+B$ is _not defined_.
  ]
]

#block(breakable: false)[
  #make-indent
  #EMPH[Transposition], #EMPH[complex conjugate], and #EMPH[Hermitian conjugate] are defined as follows:
  #definition(title: [#op-style(2) Transposition, Complex conjugate, and Hermitian conjugate])[
    Let $A$ be a $m times n$ matrix.
    Its #keyword[transposition] $A^TT$ is defined by a $n times m$ matrix with
    $(A^TT)_(i j) = A_(j i).$
    The #keyword[complex conjugate] $overline(A)$ of a matrix $A$ is defined by
    $(thin overline(A)thin )_(i j) := overline(A_(i j))$.
    The #keyword[Hermitian conjugate] $A^dagger$ of a matrix $A$ is defined by
    $A^dagger := overline(A)^T = overline(A^T)$.
  ]
  #be-careful[Memorize these words: "complex conjugate" and "Hermitian conjugate".]
]
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

#block(breakable: false)[
  #make-indent
  Matrix multiplications, defined next, is the most important operation.
  #definition(title: [#op-style(3) Matrix multiplication])[
    Matrix multiplication $A B$ is defined _iff_ the number of columns of $A$ is equal to the number of rows of $B$. In other words, if $A$ is a $s times t$ matrix and $B$ is a $u times v$ matrix, then $A B$ is defined _iff_ $t=u$.
    The product $A B$ is a $s times v$ matrix defined by
    $
      (A B)_(j k) := sum_(n=1)^t A_(j n) B_(n k).
    $
  ]
]
#be-careful[You need a lot of practice to get used to this operation. So...]
#quizzes[
  + Calculate the following products if defined. Answer "undefined" if the product is not defined.
    #h-enum(cols: 5)[
      + $A B$
      + $B A$
      + $A C$
      + $C A$
      + $A D$
      + $D A$
      + $B C$
      + $C B$
      + $B D$
      + $D B$
      + $C D$
      + $D C$
      + $A^2$
      + $A^3$
      + $B^2$
      + $C^2$
      + $D^2$
      + $D D^TT$
      + $D^TT D$
      + $D D^TT D$
    ]
    #no-num(shift: false)[$
      "with"
      A=mat(1, 2; 0, 1),quad
      B=mat(1, 2, 0; 0, 1, 1),quad
      C=mat(3, 1; 0, 0; 0, 1),quad
      D=mat(2; 1; 0).
    $]
    #fail-safe(indent: false)[$A^2$ means $A A$. Also, $A^3=A A A$, $(A B)^2=A B A B$, and $(A B)^3=A B A B A B$.]
]
You can calculate the product of a matrix and a vector, such as
$
  A=mat(1, 2; 3, 4),quad vc(v)=mat(1; -1),quad A vc(v) = mat(1, 2; 3, 4) mat(1; -1) = mat(-1; -1),
$
as if $vc(v)$ is a $2 times 1$ matrix.

For square matrices, we can define the #EMPH[trace] and #EMPH[determinant] as follows:
#definition(title: [#op-style(4) Trace and Determinant])[
  Consider a square matrix $A in KK^(n, n)$, i.e., its size is $n times n$.
  Its #keyword[trace] is defined by
  $ tr(A) := sum_(k=1)^n A_(k k) = A_(1 1) + A_(2 2) + dots.c + A_(n n). $
  Its #keyword[determinant] is defined by
  $
    "For" 1times 1 "matrices,"quad det lr(size: #1.8em, (thick a thick)) := a\
    "For" 2times 2 "matrices,"quad det mat(a, b; c, d) := a d - b c,\
    "For" 3times 3 "matrices,"quad det mat(a, b, c; d, e, f; g, h, i) := a e i + b f g + c d h - c e g - b d i - a f h.
  $
  We will not discuss the determinant of larger matrices in this course.
]
Obviously, the trace and determinant of real matrices are real numbers.
#remark[Sometimes $det A$ is written by $|A|$.]

= Properties of matrix operations <sec:mat-prop>
Now we discuss the properties of the operations
#cat-of-operations
one by one.

Recall @chap:vector, where addition and scalar multiplication are the fundamental operations of vectors and we saw @thm:va-axiom. Here, similar properties hold for matrices.
#theorem(title: [Properties #op-style(1) Addition and Scalar multiplication])[
  Consider $A, B, C in KK^(m, n)$ and scalars $p, q in KK$. (So, $A$, $B$, and $C$ are in the same size.) Then,
  #v-enum(
    cols: 2,
    label-style: "(A)",
  )[
    + $A+B = B+A,$
    + $\(A+B)+C = A+\(B+C),$
    + $A+O^(m,n)=A,$
    + $A+(-A)=O^(m,n),$
    + $p A + p B = p\(A+B),$
    + $p A + q A = (p+q) A,$
    + $(p q)A = p\(q A),$
    + $1 A= A.$
  ]
] <thm:mat-prop-add>
#quizzes[+ Check these properties and compare them with @thm:va-axiom.]

#make-indent
Matrix multiplications are easy to understand, except for the "be careful" box below.
#theorem(title: [Properties #op-style(3) Matrix multiplication])[
  Consider $A in KK^(m, n)$, $B in KK^(n, l)$, $C in KK^(l, k)$. (Notice that we have chosen them so that $A B$ and $B C$ are defined.)
  Also, consider $P, Q in KK^(m, n)$, $R, S in KK^(n, l)$, and $p in KK$. Then,
  #v-enum(
    cols: 2,
    label-style: "(A)",
  )[
    + $(A B)C = A(B C),$
    + $A(R+S) = A R + A S,$
    + $(P+Q) B = P B + Q B,$
    + $p (A B) = (p A)B = A (p B),$
    + $A I_n = I_m A = A,$
    + $A O=O, quad O A = O.$
  ]
] <thm:mat-prop-mul>
#be-careful[The following statements are all incorrect (false).
  #h-enum(cols: 2, label-style: "・", v-sep: .5em)[
    + #RED[$A B = B A$.]
    + #RED[If $A B = O$, then $A = O$ or $B = O$.]
    + #RED[If $A B = A$, then $B = I$.]
    + #RED[If $A B = A C$, then $B = C$.]
    + #RED[If $A^2=O$, then $A=O$.]
    + #RED[If $A B = B$, then $A = I$.]
    + #RED[If $A^2=A$, then $A=I$.]
  ]
  Also, #RED[$A O = O A$] is incorrect; imagine $A$ is a $3times 2$ matrix and calculate $A O$ and $O A$.
]
#advanced-note[
  Precisely speaking, we need the above property #thick-sf[(A)] to define $A^k$ for a _square_ (why?) matrix $A in NN^(n, n)$ and $k in NN^0$. Anyway, it is defined by $A^k := A A^(k-1)$ with $A^0 := I_n$.
]

#make-indent
Transpositions and conjugations obviously satisfy the following equalities:
$
  & (A^TT)""^TT = A, wide wide wide
  &&overline(thick overline(A)thick)= A, quad&&(A^dagger)""^dagger = A; \
  & overline(A^dagger) = overline(A)^dagger = A^TT, wide
  && (A^TT)""^dagger = (A^dagger)""^TT = overline(A), wide
  && overline(A^TT) = overline(A)^TT = A^dagger;\
  & (A+B)^TT = A^TT + B^TT,
  &&overline(A+B) = overline(A)+ overline(B), wide
  &&(A+B)^dagger = A^dagger + B^dagger;
$
but the following properties are of important. _You need to check them carefully._
#theorem(title: [Properties #op-style(2) Transposition and Conjugation])[
  For matrices $A, B$ and $p in KK$,
  #v-enum(
    cols: 2,
    label-style: "(A)",
  )[
    + $(p A)^TT = p thin A^TT$,
    + $overline((p A))= overline(p) thin overline(A)$,
    + $(p A)^dagger = overline(p) thin A^dagger$,
    + $(A B)^TT = B^TT A^TT$,
    + $overline((A B)) = overline(A)thin overline(B)$,
    + $(A B)^dagger = B^dagger A^dagger$.
  ]
] <thm:mat-prop-conj>

#make-indent
Finally, trace and determinant satisfy the following properties:
#theorem(title: [Properties #op-style(4) Trace and Determinant])[
  For $A, B in KK^n$ and $p in KK$,
  #v-enum(
    cols: (1fr, 1.5fr),
    label-style: "(A)",
  )[
    + $tr(A+B)=tr A+tr B$,
    + $tr(p A)=p tr A$,
    + $tr(A B) = tr(B A)$,
    + $tr(A B C) = tr(C A B) = tr(B C A)$,
    + $det(A B) = det(A) det(B) = det(B A)$,
    + $det(p A) = p^n det A$;
    + $tr A^TT = tr A, quad tr overline(A)=tr A^dagger = overline(tr A)$,
    + $det A^TT = det A, quad det overline(A)=det A^dagger = overline(det A)$.
  ]
  (These properties are correct for any $n times n$ matrices.)
]<thm:mat-prop-tr-det>
Also, $tr(I_n) = n$, $det(I_n)=1$, and $tr(O^(n,n)) = det(O^(n,n))=0$.
#be-careful[The following statements are all incorrect (false).
  #h-enum(cols: (1fr, 1.5fr, 1.8fr), label-style: "・", v-sep: .5em)[
    + #RED[$(A B)""^TT = A^TT B^TT$]
    + #RED[$tr(A B C) = tr(C B A)$]
    + #RED[$det(-A) = - det(A)$]
    + #RED[$(A B)""^dagger = A^dagger B^dagger$]
    + #RED[$tr(A B) = tr(A)tr(B)$]
    + #RED[$det(A+B) = det A + det B$]
  ]
  Also, if $A$ and $B$ are not square matrices, then #RED[$det(A B)=det(B A)$] is false.
]

Now it's time to do (a lot of) exercises.
#problems[
  #no-num(shift: false)[$
    "Let"
    A=mat(-ii, 1; 0, 2ii),
    B=mat(0, 1; 1, 1),
    C=mat(1, 1; 0, 1),
    D=mat(1, 2, 0; 0, 1, 1),
    vc(v)=mat(2; 1; 0),
    vc(w)=mat(1+ii; 0; 1-ii), "and"
    vc(x)=mat(2ii; -1).
  $]

  + `4` Calculate them. If the result is not defined, answer "undefined".
    #h-enum(cols: 7)[
      + $A^2$
      + $A B$
      + $B A$
      + $A^dagger$
      + $A^dagger B^dagger$
      + $A B D$
      + $A B^TT D$
      + $C^2$
      + $C^3$
      + $C^9$
      + $D^TT D$
      + $D D^TT$
      + $D^2$
      + $A vc(x)$
      + $vc(x)^dagger A^dagger$
      + $vc(x)^dagger vc(x)$
      + $vc(v)^dagger vc(v)$
      + $vc(w)^dagger vc(w)$
      + $vc(v)^dagger vc(w)$
      + $vc(w)^dagger vc(v)$
      + $cip(v, w)$
      + $|vc(v)|^2$
      + $vc(v)^2$
      + $vc(v) vc(v)^dagger$
      + $|A vc(x)|^2$
      + $vc(x)^dagger A^2 vc(x)$
      + $vc(x)^dagger B vc(x)$
      + $vc(x)^dagger D vc(v)$
    ]
  + `4` Calculate them. If the result is not defined, answer "undefined".
    #h-enum(cols: 4)[
      + $tr A$
      + $tr B$
      + $tr C$
      + $tr D$
      + $tr (B^2)$
      + $tr (C^2)$
      + $tr (C^3)$
      + $tr (D^2)$
      + $tr (A B C)$
      + $tr (B C A)$
      + $tr (C B A)$
      + $tr (A C B)$
      + $tr (A B A B)$
      + $tr (A^2 B^2)$
      + $tr (A^dagger)$
      + $tr (B^dagger)$
      + $det A$
      + $det B$
      + $det C$
      + $det D$
      + $det (A^3)$
      + $det (A^9)$
      + $det (A B A B)$
      + $det (A^2 B^2)$
      + $det (A^dagger)$
      + $det (C^3)$
      + $det (C^9)$
      + $det (D^2)$
      + $tr(A C)$
      + $det(A C)$
      + $tr(-3A C)$
      + $det(-3A C)$
      + $tr(D^TT D)$
      + $det (D^TT D)$
      + $tr(-3D^TT D)$
      + $det(-3D^TT D)$
      + $tr (D D^TT)$
      + $det (D D^TT)$
      + $tr (-3D D^TT)$
      + $det (-3D D^TT)$
    ]
  + `4` Calculate $det(I_n)$, $tr(I_n)$, $det(-I_n)$, $tr(-I_n)$, $det(5I_n)$, and $tr(5I_n)$ for $n in NN^+$.
]
#problems[
  + `4` We have seen several "false" equations in the above "be careful" boxes. Let's find counterexamples for them!
    + Find $2 times 2$ real matrices $A$ and $B$ such that $A B != B A$.
    + Find $2 times 2$ real matrices $A$ and $B$ such that $(A != O_2) and (B != O_2) and (A B = O_2)$.
    + Find $2 times 2$ real matrices $A$ and $B$ such that $(A B = A) and (B != I_2) and (A != O_2)$.
    + Find a $2 times 2$ real matrix $A$ such that $A^2=A$ and $A_11=A_12=5$.
    + Find a $2 times 2$ real matrix $A$ such that $A^2=O$ and $A_11=-A_22 != 0$.

  + `4` Let us accept the equality $tr(A B)=tr(B A)$. Starting from this fact, prove $tr(A B C) = tr(C B A)$ and $tr(A B C D) = tr(D B C A)$.

  + `3` Try to prove #thick-sf[(A)(B)(G)] of @thm:mat-prop-tr-det.
  + `2` Prove #thick-sf[(A)(D)] of @thm:mat-prop-conj and #thick-sf[(C)] of @thm:mat-prop-tr-det.
  + `1` Consult textbooks to find the definition of determinant for general $n times n$ matrix. Write a $4 times 4$ matrix $A$ with components $A_(j k)=j+k+delta_(j k)$ and calculate $det A$.
]

= Inverse of matrices <sec:mat-inverse>
If $x$ is a (complex) number, an equation $a x = b$ with $a != 0$ can be solved by
#no-num[$ (a dot x) dot a^(-1) = b dot a^(-1) $]
and then, since $(a dot x) dot a^(-1)=(a dot a^(-1)) dot x$ and $a dot a^(-1) = 1$, we have $x = b a^(-1)$. Can we do the same thing for matrices?

First, consider an equation $A X = B$ with $A, B, X in RR^(2,2)$. If there is a matrix $P$ such that $P A = I_2$, then we can multiply both sides of the equation by $P$ _from the left_:
#no-num[$
  & P A X = P B, quad "thus" quad P A X = I_2 X = X = P B. \
  & "(Notice we cannot do it from the right: we get" A X P = B P "but we cannot proceed from it.)"
$]
So, the question is whether there exists a matrix $P$ such that $P A = I_2$, and the answer is given in the next theorem.
#quizzes[
  +
    + Assume $P A = I_2$ and $det A = 3$. Find $det P$.
    + Assume $det A=0$. It is impossible to find $P$ such that $P A = I_2$, but why?
]
#theorem(title: "Inverse of a matrix")[
  Consider a square matrix $A in KK^(n,n)$. Then
  $
    det A != 0 & <==> "there exists a matrix" P "such that" P A = I_n \
               & <==> "there exists a matrix" Q "such that" A Q = I_n
  $
  and $P=Q$ if exists. Here, we call $P=Q$ the #keyword[inverse] of $A$ and denote it by $A^(-1)$.\
  In particular, if $det A != 0$, then $A^(-1)$ exists such that $A^(-1) A = A A^(-1) = I_n$.
]
So, if $det A != 0$ and $A X = B$, then we can solve it as $X = A^(-1) B$.

#block(breakable: false)[
  #make-indent
  For $1times 1$ and $2 times 2$ matrices, we can easily find the inverse matrices as follows:
  #theorem(title: [Explicit formulae of inverse matrices])[
    #no-shift[$
      "For" 1 times 1 "matrix,"thick
      lr(size: #1.8em, (thick a thick))^(-1) = lr(size: #1.8em, (thick 1\/a thick)).quad
      "For "2 times 2 "matrix,"thick
      mat(a, b; c, d)^(-1) = 1/(a d-b c) mat(d, -b; -c, a).
    $]
  ]
]

#theorem(title: [Properties of inverse matrices])[
  Consider a square matrix $A, B in KK^(n,n)$ with $det A != 0$ and $det B != 0$.
  #v-enum(
    cols: 2,
    label-style: "(A)",
  )[
    + $(A^(-1))""^(-1) = A,$
    + $(A B)^(-1) = B^(-1) A^(-1).$
    + $det(A^(-1)) = 1\/(det A)$
    + $(A^TT)""^(-1) = (A^(-1))""^TT,$
    + $(overline(A))""^(-1) = overline(A^(-1)),$
    + $(A^dagger)""^(-1) = (A^(-1))""^dagger,$
  ]
] <thm:mat-prop-inverse>


= Matrices with special names <sec:mat-special>

#[
  #show strong: it => {
    it.body // no "strong"
  }
  #let kw(u) = [#EMPH[#u]#index(u + " matrix")]
  Square matrices can have various special properties.
  A square matrix $A$ is called
  #list(
    tight: true,
    list.item[#kw[symmetric] if $A = A^TT$,],
    list.item[#kw[skew-symmetric] if $A = -A^TT$,],
    list.item[#kw[Hermitian] if $A = A^dagger$,],
    list.item[#kw[skew-Hermitian] if $A = -A^dagger$,],
  )
  #list(
    tight: true,
    list.item[#kw[unitary] if $A A^dagger = I$,],
    list.item[#kw[orthogonal] if $A A^TT = I$ and $A$ is real #h(1em)#hint(head: "", "Pay attention to the second condition!"),],
  )
  #list(
    tight: true,
    list.item[#kw[upper-triangular] if $A_(j k)=0$ for all $j>k$,],
    list.item[#kw[lower-triangular] if $A_(j k)=0$ for all $j<k$,],
    list.item[#kw[diagonal] if all off-diagonal elements are zero.],
  )
  #list(
    tight: true,
    list.item[#kw[normal] if it satisfies $A A^dagger = A^dagger A$. However, we will not discuss them in this course,],
  )
  Furthermore, a square matrix $A$ is called
  #list(
    tight: true,
    list.item[#kw[regular] if $det A != 0$; it may also be called #kw[invertible] or #EMPH[non-singular].],
    list.item[#kw[singular] if $det A = 0$; it may also be called #EMPH[non-invertible] or #EMPH[irregular].],
  )

]
#be-careful[Too many names? Yes, but you need to know them all!]
#example[Consider the following square matrices.
  #show math.mat: math.display
  #show math.frac: math.display
  #let nn(..args) = args.pos().map(i => thick-sf[(#i)]).join("")
  #h-enum(cols: (1fr, 1.3fr, 1fr, 1fr, 1fr, 1fr), label-style: "(1)")[
    + $mat(1, 2; 3, 4)$
    + $mat(1, 0; 0, 0)$
    + $mat(1, 2; 2, 3)$
    + $mat(0, -1; 1, 0)$
    + $mat(1, ii; -ii, 1)$
    + $mat(0, -ii; ii, 0)$
    + $mat(1, 0; 0, -1)$
    + $1/sqrt(2)mat(1, -1; 1, 1)$
    + $mat(0, 2ii; 2ii, 0)$
    + $mat(1, 0; 2ii, 1)$
    + $mat(1, -1; 0, 1)$
    + $mat(0, 1; 0, 0)$
  ]
  #nn(2, 3, 7, 9) are symmetric and #nn(4, 6) are skew-symmetric;
  #nn(2, 3, 5, 6, 7) are Hermitian and #nn(4, 9) is skew-Hermitian.
  #nn(4, 6, 7, 8) are unitary;
  #nn(4, 7, 8) are orthogonal.
  #nn(2, 7, 11, 12) are upper-triangular, #nn(2, 7, 10) are lower-triangle, and #nn(2, 7) are diagonal. Normal matrices are #nn(2, 3, 4, 5, 6, 7, 8, 9).
]
These special matrices have the following important properties:

#theorem(title: [Matrices with special names])[
  We here assume all matrices are $n times n$ matrices.

  - Properties about determinant:
    1. If $A$ is Hermitian, $det A in RR$.
    2. If $A$ is skew-Hermitian, $det A$ is zero or pure-imaginary.
    3. If $A$ is unitary, $lr(|det A|)=1$.
    4. If $A$ is orthogonal, $det A = ±1$.

  - Properties about Hermitian and skew-Hermitian matrices:
    5. If $A$ is Hermitian, then $A^n$ is also Hermitian for $n in NN^+$.
    6. If $A$ and B are both Hermitian, then, $A B "is Hermitian" <==> A B=B A.$
    7. For any matrices $M$, $M+M^dagger$ is Hermitian and $M-M^dagger$ is skew-Hermitian.

  - Properties about unitary and orthogonal matrices:
    8. A unitary matrix $U$ is invertible; $U^(-1)=U^dagger$.
    9. An orthogonal matrix $P$ is invertible; $P^(-1)=P^TT$.

  - Properties about symmetric and skew-symmetric matrices:
    10. For any matrices $M$, $M+M^TT$ is symmetric and $M-M^TT$ is skew-symmetric.

  - Properties about triangular matrices:
    11. If $A$ is (upper or lower) triangular, $det A = product_(k=1)^n A_(k k) = A_(11)A_22 dots.c A_(n n).$

  - Finally,
    12. Hermitian, skew-Hermitian, unitary, and orthogonal matrices are all normal. Real symmetric matrices and real skew-symmetric matrices are also normal.
]<thm:mat-special-prop>
The property #thick-sf[7.] and #thick-sf[10.] can be used for #keyword[decomposition of matrices].

- Any matrix $M$ can be _uniquely_ decomposed as a sum of a Hermitian matrix $H$ and a skew-Hermitian matrix $K$, i.e.,
  $ M=H+K,quad "where" quad H= (M+M^dagger)/2 quad "and" quad K= (M-M^dagger)/2. $<eq:mat-dec-h>

- Any matrix $M$ can be _uniquely_ decomposed as a sum of a symmetric matrix $S$ and a skew-symmetric matrix $T$, i.e.,
  $ M=S+T,quad "where" quad S= (M+M^TT)/2 quad "and" quad T= (M-M^TT)/2. $<eq:mat-dec-s>

These #EMPH[decompositions] are important in linear algebra.
#quizzes[
  + Prove the following facts:
    + For any square matrix $M$, $M+M^dagger$ is Hermitian, $M-M^dagger$ is skew-Hermitian, $M+M^TT$ is symmetric, and $M-M^TT$ is skew-symmetric.
    + Hermitian, skew-Hermitian, symmetric, and skew-symmetric matrices are all normal.
    + If $A$ is Hermitian, then $A^n$ is also Hermitian for $n in NN^+$.
]
#advanced-note[
  The following facts will be important when you learn #EMPH[diagonalization of matrices].

  - A normal matrix is diagonalizable by a unitary matrix.
  - A real symmetric matrix is diagonalizable by an orthogonal matrix.
  #index("diagonalization of matrices")
]


#problems[
  + `2` Prove the following facts:
    + #thick-sf[1--10] and #thick-sf[12] of @thm:mat-special-prop.
    + The decompositions of matrix, given in @eq:mat-dec-h and @eq:mat-dec-s, are unique.
]


#problems[
  + `3` A square matrix $A$ is called #EMPH[idempotent] if $A^2=A$. Let $A$ be a $n times n$ idempotent matrix. Prove the following facts.
    + $I_n-A$ is also idempotent. #hint[Calculate $(I_n-A)^2$.]
    + If $A$ is regular, then $A=I_n$. Namely, $(A "is idempotent")=> (A=I_n) or (det A=0).$
  + `3` A square matrix $A$ is called #EMPH[nilpotent] if $A^k=O$ for some positive integer $k$. Let $A$ be a $n times n$ nilpotent matrix. Prove the following facts.
    + $A$ is singular. #hint[Find its determinant.]
    + $(I_n-A)(I_n+A+A^2+dots.c+A^(k-1))=I_n$. (It means $I-A$ is invertible.)

  + `2`
    + Find all $2 times 2$ idempotent matrices.
    + Find all $2 times 2$ nilpotent matrices.
    + Find all $2 times 2$ matrices that satisfy $A^2=I_2$.
]

= Matrix and Arrows
Consider $2 times 1$ real matrices and $3 times 1$ real matrices, such as $mat(1; 3)$ and $mat(-1; 0; 3)$.
Because Sho asked you to write a vector in the vertical form, it is natural to identify $n times 1$ real matrices as $n$-dimensional real vectors. And thus,
#theorem(type: "Statement")[
  We can identify a matrix $M in RR^(n,1)$ as a $n$-dimensional real vector $vc(v) in RR^n$, and furthermore, as _an arrow_ in a $n$-dimensional space.
]
The cases with $n=2$ and $3$ are important in physics because our space is three-dimensional.
So, let's consider a few $2times 2$ matrices:
$
  V=mat(1, 0; 0, -1),quad
  H=mat(-1, 0; 0, 1),quad
  C=mat(cos 90degree, -sin 90 degree; sin 90 degree, cos 90 degree) = mat(0, -1; 1, 0).
$
#quizzes[
  +
    + Draw $vc(v)=mat(1; 2)$ as an arrow on a $x y$-plane.
    + Calculate $V vc(v)$, $H vc(v)$, and $C vc(v)$ and draw them on the plane.
    + Think about the meanings of these matrices $V$, $H$, and $C$.
    + Calculate $H^2$, $V^2$, $C^2$, $C^4$, $H V$, and $V H$, and think about their meanings.
]
Obviously, $V$ corresponds to a vertical #keyword[reflection] (reflection with respect to $x$-axis), $H$ to a horizontal #EMPH[reflection] (reflection with respect to $y$-axis), and $C$ corresponds to a $90degree$-rotation around the origin.
Therefore, $V^2$, $H^2$, and $C^4$ must be the identity matrix $I_2$, and $C^2 = H V = V H$.
#quizzes[
  +
    + Calculate $V^(-1)$, $H^(-1)$, and $C^(-1)$.
    + Show that $V$, $H$, $C$ are orthogonal. (Also, show that they are unitary.)
  + Let us define $[A, B] := A B - B A$, which we call it #keyword[commutator]. Show that
    + $[H,V]=0$, which we say "the matrix $H$ and the matrix $V$ #keyword[commutes]".
    + $[H, C] != 0$, which we say "$H$ and $C$ do not commute."

]
When we operate $H$ and $V$ on an arrow, we do not have to care about the order because $H V=V H$, i.e., $H$ and $V$ commute. Meanwhile, when we operate reflection $H$ and $90degree$-rotation $C$, the order matters because the operators do not commute.

For 2d arrows, the following matrices are important.
#theorem(title: [Matrices as operators on 2d arrows])[
  For arrows in 2d space,

  - $display(H = mat(-1, 0; 0, 1))$ corresponds to horizontal #keyword[reflection], or reflection about $y$-axis, of the arrow.

  - $display(V = mat(-1, 0; 0, 1))$ corresponds to vertical #keyword[reflection], or reflection about $x$-axis,  of the arrow.

  - $display(R_theta = mat(cos theta, -sin theta; sin theta, cos theta))$ corresponds to #keyword[rotation] by the angle $theta$ about the origin.

  - $display(M_(s,t)=mat(s, 0; 0, t))$ with $s>0$ and $t>0$ corresponds to #keyword[scaling] by a factor $s$ along $x$-axis and by a factor $t$ along $y$-axis, or in other words, horizontally by $s$ and vertically by $t$.
    In particular, $M_(s,s)=s thin I_2$ magnifies the whole space by $s$.
]
#be-careful[You need to memorize $R_theta$.]
#quizzes[
  +
    + Show that $R_theta R_phi = R_(theta+phi)$. Also, show that $R_theta$ and $R_phi$ commute.
    + Show that $R_theta$ is orthogonal (and unitary).
    + Show that the inverse of $R_theta$ is $R_(-theta)$ and the inverse of $M_(s,t)$ is $M_(1\/s,1\/t)$. #hint(head: "Remark: ", [It means they are invertible.])
  + Rotation and reflection should not modify the magnitude of a vector, while $M_(s,s)$ should scale the magnitude by a factor $s$. Let us confirm these properties as follows. First, consider $vc(v)=mat(a; b)$ and calculate $H vc(v)$, $V vc(v)$, $R_theta vc(v)$, and $M_(s,s) vc(v)$. Then, calculate their magnitude and compare them with $va(v)$.
]
For 3d arrows, the following matrices are important:

#theorem(title: [Matrices as operators on 3d arrows])[
  For arrows in 3d space,

  - $display(P""_x = mat(-1, 0, 0; 0, 1, 0; 0, 0, 1))$ corresponds to #keyword[reflection] about $y z$-plane.
    Similarly, $display(P""_y = mat(1, 0, 0; 0, -1, 0; 0, 0, 1))$ and $display(P""_z = mat(1, 0, 0; 0, 1, 0; 0, 0, -1))$ correspond to reflection about, respectively, $z x$-plane and $x y$-plane.
  - $display(P=P""_x P""_y P""_z = mat(-1, 0, 0; 0, -1, 0; 0, 0, -1))$ corresponds to the reflection about all the axes. This operation is called #keyword[parity transformation].

  - $display(R_(x;theta) = mat(1, 0, 0; 0, cos theta, -sin theta; 0, sin theta, cos theta))$,
    $display(R_(y;theta) = mat(cos theta, 0, sin theta; 0, 1, 0; -sin theta, 0, cos theta))$, and
    $display(R_(z;theta) = mat(cos theta, -sin theta, 0; sin theta, cos theta, 0; 0, 0, 1))$
    corresponds to #EMPH[rotation] by the angle $theta$ about $x$-axis, $y$-axis, and $z$-axis, respectively.

  - $display(M_(s,t,u)=mat(s, 0, 0; 0, t, 0; 0, 0, u))$ with $s,t,u>0$ corresponds to #keyword[scaling] by a factor $s$ along $x$-axis, $t$ along $y$-axis, and $u$ by z-axis.
    In particular, $M_(s,s,s)=s thin I_3$ magnifies the whole space by $s$.
]
#index("rotation", "rotation in 3d")
Notice that rotations in 3d-space are much more complicated than in 2d. In 2d, we only have one parameter $theta$, while you need three parameters to describe a 3d rotation:

- Any 3d rotation can be expressed by rotation around one axis $vc(n)$ by the angle $theta$ (Euler's rotation theorem). Here, two parameters are to determine the axis $vc(n)$ and one parameter is the angle $theta$.

- Any 3d rotation can be expressed by a combination of three rotations around different axes, such as $R_(z;gamma)R_(y;beta)R_(x;alpha)$. The three angles $alpha, beta, gamma$ are called #keyword[Euler angles].

We do not discuss it in details except for one _be-careful_ box.

#be-careful[
  Notice the order of the operations in $R_(z;gamma)R_(y;beta)R_(x;alpha)$ because they are operating on a vector $vc(v)$ from the left. The first rotation is around $x$-axis; the second one is about $y$-axis; the last one is about $z$-axis.
]
#advanced-note[
  Also notice that, in $R_(z;gamma)R_(y;beta)R_(x;alpha)$, the second rotation is not about the original $y$-axis, but about $y$-axis after the first rotation (sometimes called $y'$-axis). Similarly, the third rotation is not about the original $z$-axis, but about $z''$-axis after the two rotations. This is called #EMPH[extrinsic rotations]. There is also a concept of #EMPH[intrinsic rotations], which is defined in a different way.

  For more discussions, see Section 4.4--4.6 of @Goldstein3e. Euler's rotation theorem is "physically" obvious, but for rigorous proof, see Theorem 6.6.15 of @Hassani2e.]
#index("rotation", "intrinsic rotation")
#index("rotation", "extrinsic rotation")

#quizzes[
  + Show that reflections $P""_x$, $P""_y$, $P""_z$ do not modify the magnitude of a vector.
    #hint[Consider $vc(v)$ and calculate the magnitude of $P""_x vc(v)$ etc.]
]
Now we want to confirm that the rotation matrices do not modify the magnitude of a vector, but it is a bit messy to calculate the magnitude of $R_(x;theta) vc(v)$ etc.
Here, instead, we use the following theorem:

#theorem[
  Consider a vector $vc(v)in KK^n$ and a matrix $A in KK^(n,n)$. Then,
  $ |A vc(v)|^2 = (A vc(v))""^dagger A vc(v) = vc(v)^dagger A^dagger A vc(v). $

  #fail-safe(indent: false)[
    Recall $(A B)^dagger = B^dagger A^dagger$. Also, if $A$ and $vc(v)$ are real, we may write $|A vc(v)|^2 = (A vc(v))""^TT (A vc(v)) = vc(v)^TT A^TT A vc(v)$.  ]
]<thm:mat-magnitude-0>
#proof[
  $A vc(v)$ is a vector with components $(A vc(v))_k = sum A_(k j)v_j$. So, its magnitude squared is given by
  #no-num[$
    |A vc(v)|^2 = sum_(k=1)^n lr(|(A vc(v))_k|)^2 = sum_(k=1)^n overline((A vc(v))_k) (A vc(v))_k
    = sum_(k=1)^n sum_(j=1)^n overline(A_(k j)) thin overline(v_j) sum_(j'=1)^n A_(k j')v_(j')
    = sum_(k=1)^n sum_(j=1)^n sum_(j'=1)^n overline(v_j) thin overline(A_(k j)) A_(k j')v_(j').
  $]
  Meanwhile,
  #no-num[$
    vc(v)^dagger A^dagger A vc(v)
    = sum_(a=1)^n sum_(b=1)^n sum_(c=1)^n overline(v_a) (A^dagger)_(a b) A_(b c) v_c
    = sum_(a=1)^n sum_(b=1)^n sum_(c=1)^n overline(v_a) thin overline(A_(b a)) A_(b c) v_c,
  $]
  so they are equal. $qed$
]
With this theorem, we can easily show that rotations do not modify the magnitude of a vector.

#quizzes[
  + Show that rotations $R_(x;theta)$ etc. do not modify the magnitude of a vector by the following procedure.
    + Show that $(R_(x;theta))^dagger R_(x;theta) = I_3$. (Notice that it means $R_(x;theta)$ is unitary.)
    + Show that $lr(|R_(x;theta) vc(v)|) = |vc(v)|$.
]



#problems[
  + `4` Show the following facts, using @thm:mat-magnitude-0.
    + If $R in CC^(n,n)$ is unitary, then $|R vc(v)| = |vc(v)|$ for any vector $vc(v) in CC^n$.
    + If $R in CC^(n,n)$ is normal, then $|R vc(v)| = |R^dagger vc(v)|$ for any vector $vc(v) in CC^n$.

  + `3` Show that, for $A, B, C in KK^(n,n)$,
    #h-enum(cols: (1fr, 1.5fr))[
      + $[B,A]=-[A,B]$
      + $[A+B, C] = [A,C]+[B,C]$
      + $[A B,C] = A[B,C]+[A,C]B$
      + $[A,[B,C]]+[B,[C,A]]+[C,[A,B]]=O^(n,n)$.
    ]
]


= Matrix and Vectors
Once we identify a vector with a $n times 1$ matrix, we can describe the inner product, @eq:mat-vec2, as a product of two matrices:
#writings(
  box: (true, false, true),
  align: horizon,
  $display(cip(v, w) = sum_(k=1)^n overline(v_k) w_k)$,
  $=$,
  $display(mat(overline(v_1), overline(v_2), ..., overline(v_n))thick mat(w_1; w_2; ...; w_n) = (vc(v))^dagger vc(w))$,
)
with $vc(v)$ and $vc(w)$ identified as matrices; $(vc(v))^dagger$ is the  Hermitian conjugate of $vc(v)$.
This equality motivates us to describe
#writings(
  box: (false, true, false, true, false),
  align: (left, center, left, center, left),
  [a vector],
  $vc(v)$,
  [as a #keyword[ket]],
  $ket(vc(v))$,
  [(or, usually, $thick ket(v)thick$)],
  [an Hermitian conjugate],
  $(vc(v))^dagger$,
  [as a #keyword[bra]],
  $bra(vc(v))$,
  [(or, usually, $thick bra(v)thick$)],
)
and this is why we denote the inner product as $cip(v, w)$.
#theorem[
  For any vectors $vc(v) in KK^n$ and $vc(w) in KK^n$, we can express the inner product $cip(v, w)$ and the magnitude $|vc(v)|$ by matrix multiplication:
  #no-num[
    $ cip(v, w) = (vc(v))^dagger vc(w), wide va(v) = sqrt((vc(v))^dagger vc(v)thick), $
  ]
  where the vectors $vc(v)$ and $vc(w)$ are identified as $n times 1$ matrices.
]

We saw $cip(v, w)$ is the inner product. How about $cop(vc(v), vc(w))$?
$
  cop(vc(v), vc(w)) = mat(v_1; v_2; ...; v_n)mat(overline(w_1), overline(w_2), ..., overline(w_n))
  =
  mat(v_1 overline(w_1), v_1 overline(w_2), ..., v_1 overline(w_n); v_2 overline(w_1), v_2 overline(w_2), ..., v_2 overline(w_n); dots.v, dots.v, dots.down, dots.v; v_n overline(w_1), v_n overline(w_2), ..., v_n overline(w_n))
$
and this is a $n times n$ matrix.
#quizzes[
  + Check that this matrix is Hermitian.
]
Recall that the numbers $v_k$ and $w_k$ are given under some basis vectors $\{vc(e)_k\}$, and thus the matrix expression is also basis-dependent; it will be different if we use another basis.

The next theorem is useful in your future lectures:
#theorem(title: [Projection operators])[
  #let fop(i) = $cop(vc(f)_#i, vc(f)_#i)$
  If $\{vc(f)_1, ..., vc(f)_n\}$ is an orthonormal basis of $KK^n$,

  - $P""_1 = fop(1)$, $P""_2 = fop(2)$, ..., $P""_n = fop(n)$ are called #keyword[projection operators].

  - The sum of all projection operators are identity. Namely, $ sum_(k=1)^n P""_k = sum_(k=1)^n fop(k) = I_n. $<eq:mat-proj-sum-id>
]

#divider()

With this identity, @thm:mat-basis-change can be understood in a more intuitive way.
Consider a vector $vc a in KK^n$. Then,
$
  ket(vc(a)) = I_n ket(vc(a))
  = sum_(k=1)^n ket(vc(e)_k) lbk(vc(e)_k, vc(a))
  = sum_(k=1)^n ket(vc(f)_k) lbk(vc(f)_k, vc(a))
$
with two bases $\{vc(e)_1, ..., vc(e)_n\}$ and $\{vc(f)_1, ..., vc(f)_n\}$.
The component-wise expressions are, for each basis,
$
  mat(a_1; dots.v; a_n)_e quad "with" a_k = lbk(vc(e)_k, vc(a)), quad "and" quad mat(a'_1; dots.v; a'_n)_f quad "with" a'_k = lbk(vc(f)_k, vc(a)),
$
and the coefficients are related by
$
  & a_k = lbk(vc(e)_k, vc(a))
    =bra(vc(e)_k)dot.c lr([sum_(m=1)^n ket(vc(f)_m) bra(vc(f)_m)]) ket(vc(a))
    =sum_(m=1)^n lbk(vc(e)_k, vc(f)_m) lbk(vc(f)_m, vc(a))
    = sum_(m=1)^n lbk(vc(e)_k, vc(f)_m) a'_m, \
  & a'_k = lbk(vc(f)_k, vc(a))
    =bra(vc(f)_k)dot.c lr([sum_(m=1)^n ket(vc(e)_m) bra(vc(e)_m)]) ket(vc(a))
    =sum_(m=1)^n lbk(vc(f)_k, vc(e)_m) lbk(vc(e)_m, vc(a))
    = sum_(m=1)^n lbk(vc(f)_k, vc(e)_m) a_m.
$

We can write $lbk(vc(f)_k, vc(e)_m)$ as a $n times n$ matrix $U$:
$
  U_(k m) = lbk(vc(f)_k, vc(e)_m).
$
Then, $lbk(vc(e)_m, vc(f)_k) = (U_(k m))^* = (U^dagger)_(m k)$ and we found
$
  mat(a'_1; dots.v; a'_n) = U mat(a_1; dots.v; a_n), wide
  mat(a_1; dots.v; a_n) = U^dagger mat(a'_1; dots.v; a'_n).
$
This equation actually means $U$ is a unitary matrix, but we are not going to dive there in this document.


#problems[

  + `2` Prove @eq:mat-proj-sum-id.
]




= Linear Transformations
In formal mathematics, matrices are introduced as #EMPH[linear transformations] of vectors.
We are not going into the details, but let us "see" the situation briefly.

Consider a real function $f(x)$. If $f$ satisfies $f(x+y) = f(x) + f(y)$ and $f(k x) = k f(x)$ with any $k in RR$, we say $f$ is a #keyword[linear function].
#quizzes[
  + Check $f(x)=x^2$ is not linear. #hint[Compare $f(1+1)$ and $f(1)+f(1)$]
  + For $f(x) = 3x+c$ to be a linear function, what is the value of $c$?
]
In these examples, $f(x)$ receives a number $in RR$ and returns a number $in RR$.
As an extension, we can consider a function $vc(F)(vc(x))$ that receives a vector $vc(x) in KK^n$ a and returns a vector $vc(F)(vc(x))$.
#example[
  - The electrostatic potential $V(x, y, z)$ is a function that receives a vector $mat(x; y; z) in RR^3$ and returns a real value $V in RR$.
  - The electric field $vc(E)(x, y, z)$ is a function that receives a vector in $RR^3$ and returns a vector in $RR^3$.
]
Now, what if we require the linearity?

#definition[
  Consider a function $F$ that receives a vector $x in KK^m$ and returns a vector $vc(f) = F(vc(x)) in KK^n$. If

  - $F(vc(x) + vc(y)) = F(vc(x)) + F(vc(y))$ for any $vc(x), vc(y) in KK^m$,

  - $F(k vc(x)) = k F(vc(x))$ for any $vc(x)in KK^m$ and $k in KK$,

  we call $F$ a #keyword[linear function] or #keyword[linear operator].
]
#remark[
  We can safely mix these two concepts "functions" and "operators", but also you are advised to be cautious about the difference between $f(g(x))$ and $g(f(x))$.
]
#theorem[
  There is an one-to-one correspondence between

  - a matrix in $KK^(m,n)$ and
  - a linear function that receives a vector $in KK^n$ and returns a vector $in KK^m$.

  In other words, any _linear_ function receiving a vector $in KK^n$ and returning a vector $in KK^m$ can be uniquely described as a $m times n$ matrix $in KK^(m,n)$ and, conversely, any matrix $in KK^(m,n)$ corresponds to a linear function receiving a vector $in KK^n$ and returning vector $in KK^m$.
]
We now apply matrices to concrete geometric transformations in $RR^2$.
Write $vc(v) = dm(x; y)$ and use the standard basis $\{vc(e)_x, vc(e)_y\}$.

== Scaling
Scaling by $(s_x, s_y)$ means multiplying the $x$-component by $s_x$ and the $y$-component by $s_y$:
$
  mat(x; y) |-> mat(s_x x; s_y y) = mat(s_x, 0; 0, s_y) mat(x; y).
$
Scaling by a single constant $s$ in all directions (dilation) uses $s I$.

== Reflection

Reflection across the $x$-axis sends $(x, y) |-> (x, -y)$:
$
  R_x = mat(1, 0; 0, -1).
$
Reflection across the $y$-axis: $R_y = mat(-1, 0; 0, 1)$.

What about reflection across the line $y = x tan alpha$ (a line through the origin at angle $alpha$)?
The general formula is
$
  R_alpha = mat(cos 2alpha, sin 2alpha; sin 2alpha, -cos 2alpha).
$<eq:mat-reflect>

#quizzes[
  + Verify @eq:mat-reflect for $alpha = 0$ (reflection across the $x$-axis) and $alpha = pi\/4$ (reflection across $y = x$).
  + Show that $(R_alpha)^2 = I$ for any $alpha$. Explain this geometrically.
]

== Rotation

Counterclockwise rotation by angle $theta$ sends $vc(e)_x |-> mat(cos theta; sin theta)$ and $vc(e)_y |-> mat(-sin theta; cos theta)$.
These become the columns:

#definition(title: [Rotation matrix])[
  The counterclockwise rotation by $theta$ in $RR^2$ is represented by
  $
    R(theta) = mat(cos theta, -sin theta; sin theta, cos theta).
  $<eq:mat-rotate>
]

#theorem[
  $
    R(theta) R(phi) = R(theta + phi), quad R(theta)^(-1) = R(-theta), quad det R(theta) = 1, quad R(theta)^T R(theta) = I.
  $
]

#example(title: [Rotation by $pi\/4$])[
  The vector $mat(1; 0)$ rotated counterclockwise by $pi\/4$ gives
  $R(pi\/4) mat(1; 0) = mat(cos(pi/4), -sin(pi/4); sin(pi/4), cos(pi/4)) mat(1; 0) = mat(1\/sqrt(2); 1\/sqrt(2)).$
]

#quizzes[
  + Verify $R(theta) R(phi) = R(theta + phi)$ by direct computation.
    #hint[Use the angle-addition formulas for $sin$ and $cos$.]
  + For what $theta$ does $R(theta) = I$? For what $theta$ does $R(theta)$ equal reflection across the $x$-axis?
]

#problems[
  + `9` Compute $R(theta) vc(v)$ for:
    #h-enum(cols: 3)[
      + $theta = pi\/2$, $vc(v) = mat(1; 0)$
      + $theta = pi$, $vc(v) = mat(0; 1)$
      + $theta = pi\/3$, $vc(v) = mat(1; 1)$
      + $theta = -pi\/4$, $vc(v) = mat(sqrt(2); 0)$
      + $theta = pi\/6$, $vc(v) = mat(sqrt(3); 1)$
      + $theta = 2pi\/3$, $vc(v) = mat(1; -1)$
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

