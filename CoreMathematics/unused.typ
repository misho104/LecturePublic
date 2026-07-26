#theorem(title: "Taylor's theorem")[
  If a function $f(x)$ is sufficiently smooth, we can express it as
  $
    f(x) = sum_(k=0)^N ((x-a)^k)/k! f^((k))(a) + "[dangerous part]".
  $
  and we can ignore the dangerous part if $x approx a$. So, if we replace $x$ by $a+epsilon$ and $epsilon approx 0$,
  $
    f(a+epsilon) & = sum_(k=0)^N (epsilon^k)/k! f^((k))(a) + "[dangerous part]" \
                 & approx f(a) + epsilon thin f'(a) + (epsilon^2)/2 thin f''(a) + (epsilon^3)/6 thin f'''(a) + dots.c
  $

]


=== Derivation via Taylor series

We can motivate @eq:euler using the Taylor expansion of $ee^x$, $cos x$, and $sin x$.
In @chap:deriv, we saw that $f(x) approx f(a) + delta f'(a) + ...$ near $x = a$.
Applying this repeatedly (which will be discussed in more detail in a later chapter), one obtains:
$
   ee^x & = 1 + x + x^2/2 + x^3/6 + x^4/24 + x^5/120 + dots, \
  cos x & = 1 #h(0.63em) - #h(0.5em) x^2/2 #h(2.88em) + x^4/24 #h(2.93em) - dots, \
  sin x & = #h(2.1em) x #h(1.73em) - x^3/6 #h(2.88em) + x^5/120 #h(2.6em) - dots.
$

Now substitute $x = i theta$ and use $i^2 = -1$, $i^3 = -i$, $i^4 = 1$, $i^5 = i$, ...:
$
  ee^(i theta) & = 1 + i theta + (i theta)^2/2 + (i theta)^3/6 + (i theta)^4/24 + (i theta)^5/120 + dots \
               & = 1 + i theta - theta^2/2 - i theta^3/6 + theta^4/24 + i theta^5/120 - dots \
               & = (1 - theta^2/2 + theta^4/24 - dots)
                 + i (theta - theta^3/6 + theta^5/120 - dots) \
               & = cos theta + i sin theta.
$

#remark[
  This derivation assumes that the Taylor series for $ee^x$ extends to complex arguments. This is valid and will be proved in a more advanced course.
]
= Roots of Complex Numbers <sec:comp-roots>

In @chap:pow, we defined $root(n, a)$ only for $a > 0$ as a real number.
With complex numbers, we can find $n$-th roots of _any_ nonzero complex number---and there are always exactly $n$ distinct roots.

#definition(title: [$n$-th root])[
  For $n in NN^+$ and $w in CC$, an #keyword[$n$-th root of $w$] is a complex number $z$ such that $z^n = w$.
]

#theorem(title: [$n$-th roots of a complex number])[
  Let $w = R ee^(i phi)$ with $R > 0$. The $n$ distinct $n$-th roots of $w$ are
  $ z_k = R^(1\/n) ee^(i(phi + 2pi k)\/n), quad k = 0, 1, ..., n-1. $ <eq:roots>
  These $n$ points are equally spaced on a circle of radius $R^(1\/n)$, forming a regular $n$-gon in the complex plane.
]

To understand why there are exactly $n$ roots: if $z = r ee^(i theta)$, then
$z^n = r^n ee^(i n theta) = R ee^(i phi)$
requires $r^n = R$ (so $r = R^(1\/n)$) and $n theta = phi + 2pi k$ (so $theta = (phi + 2pi k)\/n$).
For $k = 0, 1, ..., n-1$, we get $n$ distinct angles; $k = n$ gives the same angle as $k = 0$.

#example(title: [Square roots of $-1$])[
  Find all square roots of $-1$.
]
#solution[
  Write $w = -1 = ee^(i pi)$ (so $R = 1$, $phi = pi$, $n = 2$). By @eq:roots:
  #no-num[
    $
      z_0 = ee^(i pi \/ 2) = cos(pi/2) + i sin(pi/2) = i, quad
      z_1 = ee^(i 3pi \/ 2) = cos(3pi/2) + i sin(3pi/2) = -i.
    $
  ]
  The two square roots of $-1$ are $i$ and $-i$, confirming @eq:i-def.
]

#example(title: [Cube roots of unity])[
  Find all cube roots of $1$.
]
#solution[
  Write $w = 1 = ee^(i dot 0)$ ($R = 1$, $phi = 0$, $n = 3$). By @eq:roots:
  #no-num[
    $
      z_0 = 1, quad
      z_1 = ee^(2pi i \/ 3) = -1/2 + sqrt(3)/2 i, quad
      z_2 = ee^(4pi i \/ 3) = -1/2 - sqrt(3)/2 i.
    $
  ]
  These three points form an equilateral triangle inscribed in the unit circle.
]

#be-careful[
  Each nonzero complex number has exactly $n$ distinct $n$-th roots.
  Do not forget the other roots. The equation $z^n = w$ has $n$ solutions in $CC$, not just one.
]

#quizzes[
  + Find all square roots of $i$ and draw them in the complex plane.
  + Find all cube roots of $-1$.
  + Find all fourth roots of $1$ and draw them in the complex plane.
  + Verify the solutions from the cube roots of unity example by checking $z_1^3 = 1$ directly.
]

#problems[
  + `4` Find all $n$-th roots of the following. Draw them in the complex plane.
    #h-enum(cols: 2)[
      + $w = -4$, $n = 2$
      + $w = 8i$, $n = 3$
      + $w = -8$, $n = 3$
      + $w = 1$, $n = 4$
      + $w = -1$, $n = 4$
      + $w = i$, $n = 4$
      + $w = 1 + sqrt(3)i$, $n = 3$
      + $w = -sqrt(2) + sqrt(2) i$, $n = 2$
    ]
  + `3` Find all solutions of the following equations in $CC$.
    #h-enum(cols: 3)[
      + $z^3 - 8 = 0$
      + $z^4 + 16 = 0$
      + $z^6 - 1 = 0$
      + $z^3 + i = 0$
      + $z^4 - 4z^2 + 3 = 0$
      + $z^6 + z^3 - 2 = 0$
    ]
  #fail-safe[For (4) and (5), try factoring or substituting $w = z^2$ or $w = z^3$.]
  + `2` The $n$-th #keyword[roots of unity] are the $n$ solutions of $z^n = 1$.
    + Show that the roots of unity are $omega^k$ for $k = 0, 1, ..., n-1$, where $omega = ee^(2pi i\/n)$.
    + Show that $1 + omega + omega^2 + ... + omega^(n-1) = 0$. #h(1em)#hint[Consider $sum_(k=0)^(n-1) omega^k$ as a geometric series.]
    + Show that the product of all $n$-th roots of unity is $(-1)^(n+1)$.
  + `1` Use the identity $sum_(k=0)^(n-1) omega^k = 0$ (from the previous problem) and de Moivre's theorem to show that for $n >= 2$:
    $ sum_(k=0)^(n-1) cos((2pi k)/n) = 0 quad "and" quad sum_(k=0)^(n-1) sin((2pi k)/n) = 0. $
]



