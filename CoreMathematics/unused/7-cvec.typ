#import "misho-text.typ": *
#import "physica.typ": *
#import "5-vector.typ": dm, va, vc, vcu, vector-three-ways

Here, we consider "complex vectors". In @chap:vector, we mentioned three interpretations of vectors:
#vector-three-ways


, but we cannot do as in @chap:vector because complex vectors are not arrows.
Here, instead, we take the third approach given in the beginning of @chap:vector:

- *A vector is an element of a vector space.*

or, more precisely,

- A vector $vc(v)$ is _something_ that we can add them ($vc(v) + vc(w)$) and multiply them ($k vc(v)$) by a scalar $k$.

  - if we can use $k in RR$ for the scalar multiplication, we call them "real vectors".

  - if we can use $k in CC$ for the scalar multiplication, we call them "complex vectors".

Arrows are real vectors because we could do addition and scalar multiplication with $k in RR$, but not complex vectors because we cannot imagine the arrow represented by $z vc(v)$ such as $(1+3ii) vc(v)$.

Let's see this construction carefully in the first section below.
= Vector Spaces
#fail-safe[
  This section is advanced; do not worry if it is tough for you!
  The next section is very important, but this section you may skip!
]
#definition(title: "Vector space")[
  Consider _objects_ $vc(v), vc(w)$ in a set $V$. Consider these three conditions.

  + for any _objects_ $vc(v), vc(w) in V$, we can calculate $vc(v) + vc(w)$ and the result $vc(v) + vc(w)$  is still an _object_ of $V$,

  + for any _scalar_ $k$ and any _object_ $vc(v) in V$, we can calculate $k vc(v)$ and the result is still an _object_ of $V$, and

  + these two calculation satisfy the following properties:
    #v-enum(
      cols: (2fr, 1fr),
      label-style: "(A)",
    )[
      + $vc(a)+vc(b) = vc(b)+vc(a),$
      + $\(vc(a)+vc(b))+vc(c) = vc(a)+\(vc(b)+vc(c)),$
      + $V "has a zero vector" vc(0) "that satisfies" vc(a)+vc(0)=vc(a) "for any" vc(a),$
      + $"For each" vc(a), "there is" -vc(a) "in" V "satisfying" vc(a)+(-vc(a))=vc(0),$
      + $p vc(a) + p vc(b) = p\(vc(a)+vc(b)),$
      + $p vc(a) + q vc(a) = (p+q) vc(a),$
      + $(p q)vc(a) = p\(q vc(a)),$
      + $1 vc(a)= vc(a).$
    ]
    where $vc(a), vc(b), vc(c)$ are (any) _objects_ in $V$ and $p$ and $q$ are any _scalars_:
  If they satisfy all the above conditions, then $V$ is called a #keyword[vector space] and _the objects_ in $V$ are called #keyword[vectors].
]<vec-def-formal>
The first operation $vc(v)+vc(w)$ is called #keyword[addition] and the second operation $k vc(v)$ is called #keyword[scalar multiplication].

Notice that we have not specified what $k$ we can use.

- If we allow any *real* numbers as $k$, we call $V$ the #keyword[real vector space] and its element #keyword[real vectors].

- If we allow any *complex* numbers as $k$, we call $V$ the #keyword[complex vector space] and its element #keyword[complex vectors].

#advanced-note[
  You may notice the rule (H) has "1", which means Sho implicitly assumed "1" was a "scalar". In fact, these "scalars" must be an element of a #keyword[division ring]. We can consider real vectors and complex vectors because $RR$ and $CC$ are division rings, but we cannot consider "integer vector" because $ZZ$ is not a division ring.
]

#quizzes[
  + You have already seen these five rules #thick-sf[(A)]--#thick-sf[(H)] in a previous chapter, but where?
]
#example[
  #enum(start: 1, tight: false)[
    Arrows in a 3d space are real vectors since we can add them or scalar-multiply them, but only with $k in RR$.
  ][
    Similarly, arrows in a 2d space are real vectors.
  ]
  Notice that these two examples show two different vector spaces.

  #enum(start: 3, tight: false)[
    Consider a pair of _complex_ numbers $mat(a; b)$. They form a _complex_ vector space because we may consider addition $mat(a; b)+mat(c; d)$ and scalar multiplication $z mat(a; b)$ with $z in CC$.
  ][
    Consider a pair of _real_ numbers $mat(a; b)$. They form a _real_ vector space because we may consider addition $mat(a; b)+mat(c; d)$ and scalar multiplication $k mat(a; b)$ with $k in RR$. However, it is not a complex vector space because, if $z in CC$, the result of scalar multiplication is not a pair of real numbers.
  ]
  Notice that @vec-def-formal requires "the result is still an object of $V$".
]
#quizzes[
  + Check that arrows in a 3d space are real vectors in terms of @vec-def-formal. \ In @chap:vector, we _derived_ these properties from the geometric nature of arrows. Now, we _define vectors from the properties they should satisfy_. This is a typical move in university mathematics.
]
#advanced-note[
  In fact, $RR$ and $CC$ themselves can be considered as a real vector space and complex vector space, respectively. Similarly, we can consider a trivial vector space $\{vc(0)\}$, for which all vectors are just zero.
]
#example(title: "A bit advanced example")[
  Consider complex continuous functions defined on $0<=x<=1$, such as $f(z) = z^3+1$ or $g(z)=exp(z)$. They form a complex vector space because we can add them or scalar-multiply them:
  $f(z)+g(z)$ and $w f(z)$, and they are still complex continuous functions.

  See #thick-sf[(C)] in @vec-def-formal. The "zero vector" $vc(0)$ corresponds to $f(z)=0$ since $phi(z)+0 = phi(z)$ for any function $phi(z)$. Similarly, for any function $phi(z)$, we have $-phi(z)$ to satisfy #thick-sf[(D)].
]

= Inner product
We want to define define the magnitude, but it is easier to define the inner product first and derive the magnitude from the equation @eq:vip-norm.


= Linear combination
Because we have addition and scalar multiplication, we can consider a #keyword[linear combination] of vectors $$
= Basis and Components

We now assume $V$ is a *finite-dimensional* vector space over $bb(K)$: that is, we assume there
exist finitely many vectors $arrow(e)_1, dots, arrow(e)_n in V$ such that every $arrow(v) in V$ can
be written as
$ arrow(v) = c_1 arrow(e)_1 + c_2 arrow(e)_2 + dots.c + c_n arrow(e)_n, quad c_k in bb(K), $ <eq:basis-expansion>
and moreover this expression is *unique* (i.e., if $arrow(v) = sum_k c_k arrow(e)_k = sum_k d_k
arrow(e)_k$, then $c_k = d_k$ for all $k$). We call $lr({arrow(e)_1, dots, arrow(e)_n})$ a *basis*
of $V$, and $n$ the *dimension* of $V$.

#fail-safe[
  This is precisely the same idea as Definition 5.13 and Theorem 5.15, except that we no longer
  require the basis vectors to be "orthonormal" --- indeed, we have not yet defined what
  "orthogonal" even means for an abstract vector, since that requires an inner product (next
  section). For now we only assume _some_ basis exists.
]

Once we fix a basis $lr({arrow(e)_1, dots, arrow(e)_n})$, @eq:basis-expansion lets us represent
any vector by its *components* $(c_1, dots, c_n)$, exactly as in Definition 5.16:
$ arrow(v) = mat(c_1; dots.v; c_n), quad c_k in bb(K). $

So, once a basis is fixed, an $n$-dimensional vector space over $bb(K)$ is "the same as" $bb(K)^n$,
the set of columns of $n$ numbers in $bb(K)$. This is why, in practice, physicists often just
_define_ a complex vector to be a column of complex numbers --- but it is worth remembering that
this already presupposes a choice of basis.

#advanced-note[
  We simply _assumed_ that a finite basis exists. This is not a serious restriction for this
  course: every vector space we will meet is finite-dimensional. (In quantum mechanics, the state
  space of a spin-$1/2$ particle is 2-dimensional, for instance.) Infinite-dimensional vector
  spaces, such as the space of wavefunctions (a #emph[Hilbert space]), require a basis with
  infinitely many (possibly uncountably many) elements, and @eq:basis-expansion must be replaced
  by an infinite sum or an integral. This is far beyond the scope of this document.
]




#let hogehoge = [
  #advanced-note[
    A vector space does not have to consist of arrows or lists of numbers at all. For example, the
    set of all polynomials $f(x) = a_0 + a_1 x + dots.c + a_n x^n$ (with real coefficients) forms a
    vector space over $bb(R)$, where addition and scalar multiplication are the usual ones for
    functions. We will not pursue this direction in this document.
  ]

  == Basis and Components

  We now assume $V$ is a *finite-dimensional* vector space over $bb(K)$: that is, we assume there
  exist finitely many vectors $arrow(e)_1, dots, arrow(e)_n in V$ such that every $arrow(v) in V$ can
  be written as
  $ arrow(v) = c_1 arrow(e)_1 + c_2 arrow(e)_2 + dots.c + c_n arrow(e)_n, quad c_k in bb(K), $ <eq:basis-expansion>
  and moreover this expression is *unique* (i.e., if $arrow(v) = sum_k c_k arrow(e)_k = sum_k d_k
  arrow(e)_k$, then $c_k = d_k$ for all $k$). We call $lr({arrow(e)_1, dots, arrow(e)_n})$ a *basis*
  of $V$, and $n$ the *dimension* of $V$.

  #fail-safe[
    This is precisely the same idea as Definition 5.13 and Theorem 5.15, except that we no longer
    require the basis vectors to be "orthonormal" --- indeed, we have not yet defined what
    "orthogonal" even means for an abstract vector, since that requires an inner product (next
    section). For now we only assume _some_ basis exists.
  ]

  Once we fix a basis $lr({arrow(e)_1, dots, arrow(e)_n})$, @eq:basis-expansion lets us represent
  any vector by its *components* $(c_1, dots, c_n)$, exactly as in Definition 5.16:
  $ arrow(v) = mat(c_1; dots.v; c_n), quad c_k in bb(K). $

  So, once a basis is fixed, an $n$-dimensional vector space over $bb(K)$ is "the same as" $bb(K)^n$,
  the set of columns of $n$ numbers in $bb(K)$. This is why, in practice, physicists often just
  _define_ a complex vector to be a column of complex numbers --- but it is worth remembering that
  this already presupposes a choice of basis.

  #advanced-note[
    We simply _assumed_ that a finite basis exists. This is not a serious restriction for this
    course: every vector space we will meet is finite-dimensional. (In quantum mechanics, the state
    space of a spin-$1/2$ particle is 2-dimensional, for instance.) Infinite-dimensional vector
    spaces, such as the space of wavefunctions (a #emph[Hilbert space]), require a basis with
    infinitely many (possibly uncountably many) elements, and @eq:basis-expansion must be replaced
    by an infinite sum or an integral. This is far beyond the scope of this document.
  ]

  #quizzes[
    Let $V = bb(C)^2$ (columns of 2 complex numbers), with the obvious addition and scalar
    multiplication. Show that $arrow(e)_1 = vec(1, 0)$ and $arrow(e)_2 = vec(0, 1)$ form a basis. Then
    show that $arrow(f)_1 = vec(1, 1)$ and $arrow(f)_2 = vec(1, -1)$ also form a basis. (This shows a
    vector space can have more than one basis, just as in the real case, Example 5.14.)
  ]
]
