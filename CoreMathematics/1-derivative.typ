#import "misho-text.typ": *
#import "physica.typ": *
#import "2-units.typ": writing, writings
#let eval(expr, size: 80% + 10pt) = $lr(#expr|, size: size)$

= The first step

Birds sing, fish swim, flowers bloom, stars twinkle, and university students calculate derivatives.
Let us begin with basic #keyword[derivatives].
Try the next quiz---and note how long it takes.

#quizzes[
  + Calculate the first derivatives of the following functions, *measuring how many minutes it takes.*
    #h-enum(cols: 4, v-sep: 1.5em)[
      + $(x+1)^3$
      + $tan x$
      + $2cos^2x$
      + $2cos x^2$
      + $x^3 cos x$
      + $(3sin x)/x$
      + $x^(3\/2)$
      + $sqrt(sin x)$
    ]
]

- Less than two minutes? Amazing! It is as fast as Sho!

- Less than four minutes? Great, it is exactly as Sho anticipates. Please continue your effort!

- Even if you took more than four minutes, do not worry.
  At least you don't make any mistakes.
  A little more practice will help you.
  Try more problems in #link("https://misho104.github.io/LecturePublic/", "the Derivative Boot Camp").#footnote[Visit https://misho104.github.io/LecturePublic and find `gp1_boot1_deriv_true.pdf`.]

- If you make any mistakes in these eight calculations, then it is a serious issue---just as serious as forgetting how to do the calculations at all.
  In university, you will perform similar calculations more than 100 times. You need to be both fast and accurate.


#divider()

At university, students often underestimate the importance of basic calculations.
In physics, simple calculations appear constantly, so your speed and accuracy directly affect how well you follow lectures, how efficiently you study, and ultimately your grade.
Both can be improved with practice.


This course will help you strengthen these basic calculations---some of which you already know from high school---while also introducing new topics that are essential for physics.
You will solve many problems and drills, just as an athlete repeats the same move hundreds of times to master it.

#v(1fr)

#_box(accent: c.gray, head-box: none)[
  This document (this lecture course) is designed for first-year students in their second semester, *who have already studied derivatives well* in their first-semester calculus. As we do not cover the details of derivatives here, if you are not confident with derivatives, please first study #link("https://misho104.github.io/LecturePublic/", "the Derivative Boot Camp").
]

#v(1fr)

#pagebreak()

= Typical Pitfalls
== Notations

#let qeq = $quad = quad$

Consider a function $f(x)$. As we vary the value of $x$, $x$ is called a #keyword[variable].
For a function $f(x)$, there are several equivalent ways to write its derivative:
$ f'(x) qeq dv(f, x)(x) qeq dv(f(x), x) qeq dv(, x)f(x) wide "[All means the same thing]." $
Similarly, the value of $f'(x)$ at a specific point $x=3$ can be written as
$ f'(3) qeq eval(f'(x))_(x=3) qeq eval(dv(f, x))_(x=3) qeq dv(f, x)(3) qeq dv(, x)f(3), $
and they are all equivalent. For example, if $f(x)=3x^2+6$, then $f'(x)=6x$ and $f'(3) = 18$.

Most of students get confused when a #keyword[constant] $a$ appears. If $a$ is _declared as a constant_, we can define a function such as $g(x)=a x^2+2a$, for which
$ g'(x) = 2 a x. $ <d1>
We can evaluate $g'(x)$ at $x=a$. The result is $g'(a)=2a^2$, written as
$ g'(a) qeq eval(g'(x))_(x=a) qeq dv(g, x)(a) qeq dv(, x)g(a) quad = quad 2a^2. $

#be-careful[
  #show math.frac: math.display
  The notation $dv(, x)g(a)$ does *not* mean $dv(, x)lr([g(a)], size: #150%) = dv(, x)(a^3+2a)=0$.
]
#fail-safe[
  If you can't see @d1, try setting $a=3$. Then, you notice $g(x)$ is the same function as $f(x)$, and $g'(x)$ should equal $f'(x)$.
]

#quizzes[
  + Let $a$ be a constant and $g(x)=a x^2+2a$. Calculate
    #h-enum(cols: 4)[
      + $g(1)$
      + $g(a)$
      + $g(0)$
      + $g(7)$
      + $g'(1)$
      + $g'(a)$
      + $g''(2)$
      + $dv(, x)g(7)$
    ]
]

#make-indent
One more bad news. _Physicists are often lazy_ and write $f(x)$ as $f$.
If $f(x)=2x^2+1$, we may write $f'=4x$ and $f''=4$. For $g(t)=2t^2-1$, you may write $g'=4t$ and $g''=4$.
Therefore, when you see a function $f$, you must *identify its variable from the context*.

In physics, a variable can be a function of another variable.
The kinetic energy $K(v)=m v^2\/2$ is a good example. Its variable $v$ is a function of time $t$~---we write this fact by $v=v(t)$--- and thus
$
  K(v) = 1/2 m v^2 quad "but also" quad K(t) = K(v(t)) = 1/2 m v(t)^2.
$
Now, what does $K'$ mean? ---It is ambiguous and we must avoid such notation.
Even though, if you see it in a textbook, you need to guess the author's intention from the context.

#advanced-note[
  This rewrite, $K(t)$ and $K(v)$, is common in physics. However, mathematicians
  do not like this practice because they consider $K$ a unique object: a
  function should always mean the same rule applied to its input.
  If they see $K(v)=m v^2\/2$, they would say #math.lr(size: 100%)[\[$K$ is an object that converts its input into $m\/2 times ("input")^2$, and thus if you feed $t$ into $K$, you must get $K(t) = m t^2\/2$\]].
  This is of course not what we mean.
  For example, imagine $v(t) = alpha t$ with $alpha$ a constant. Then
  $ "physicists:" quad K(v) = 1/2 m v^2, quad K(t) = 1/2 m alpha^2 t^2; $
  but mathematicians would say, #math.lr(size: 100%)[\[since it returns $m alpha^2\/2 times ("input")^2$, it is a different object\]] and hence use a different name for it, such as $tilde(K)$:
  $ "mathematicians:" quad K lr(size: #150%, (v(t))) = 1/2 m times v(t)^2 = tilde(K)(t) = 1/2 m alpha^2 t^2. $
  Both conventions are reasonable, and eventually you will get used to both.
]

#EMPH[Higher-order derivatives]#index("order") is written as
$
  dv(, x)(dv(f, x)) = dv(f, x, 2)=f''(x) = f^((2))(x),wide
  dv(, x)(dv(, x)(dv(f, x))) = dv(f, x, 3)=f'''(x) = f^((3))(x),
$
etc. Please be careful on the position of "2" and "3".


== Radian and trigonometric functions

At university, angles are almost always measured in #keyword[radians]:
$
  360 "degree" quad ("or:" 360degree) qeq 2pi "radian" quad ("or:" 2pi "rad")
$
Furthermore, we usually omit "radian" (because we are lazy!). So,
$
  "a right angle is " pi\/2.quad "The sum of the interior angles of a triangle is" pi.\
$
#quizzes[
  + Express the following angles in radians, and radians in angles.
    #h-enum(cols: 5)[
      + $180 degree$
      + $45 degree$
      + $60 degree$
      + $90$
      + $-30 degree$
      + $1 degree$
      + $1$
      + $-0.3$
      + $x degree$
      + $x$
    ]
]

Why do insist on radians?
The answer comes from the derivative formula
$ dv(, x) sin x = cos x. $ <sin-deriv>
Because we have chosen radians as the standard, $(sin x)'$ becomes this simple.

#advanced-note[
  The simpleness of @sin-deriv originates in the fact $sin(0.01 "rad") approx 0.01$. If we used degrees, we would have $sin(0.01 degree) approx 0.01 times 0.017453$ and  everything is messed up with this number 0.017453.
]

#pagebreak()

#make-indent
There are a few remarks in the notation of #keyword(key: "trigonometric function", [trigonometric functions]):
$
  & sin^2 x != sin x^2. wide && "Namely,"quad (sin x)^2 = sin^2 x quad   && != quad sin x^2 = sin(x^2). \
  & tan^(-1) x != 1/(tan x). && "Namely,"quad tan^(-1) x = arctan x quad && != quad (tan x)^(-1) = 1/(tan x) = cot x.
$
The following expressions are not incorrect but confusing;
#no-num(
  comma-gap: auto,
  $
    #RED[$sin^(-2) x$],
    #RED[$sin^(1\/2) x$],
    #RED[$sin(x)^2$],
    #RED[$sin (x+1)^2$],...
  $,
)
*We should avoid ambiguity*, so please _never_ use confusing these notations.
Sho thinks we should use $med sin^k x med$ only for $k=2, 3, 4, ...$, and use $med arcsin x med$ instead of $sin^(-1)x$.

== Several interpretations of derivatives
When you, physics learners, discuss $f'(t)$, you should have the following three interpretations:

- Regarding $t$ as the time, $f'(t)$ is the #keyword[rate of change] of $f(t)$ per unit time. If $f'(t)>0$, the function $f$ is increasing at the time $t$, while $f'(t)<0$ means it is decreasing.

- Consider a graph of $f(t)$. Then, $f'(t)$ is the slope of the #keyword[tangent line] to the graph at the point $t$.

- Mathematically, $f'(t)$ is defined by (Check that they are equivalent.) $ f'(t)
  := lim_(Delta t->0) (f(t+Delta t)-f(t))/(Delta t)
  = lim_(h->0) (f(t+h)-f(t-h))/(2h)
  = lim_(s->t) (f(s)-f(t))/(s-t). $

If you are unsure of them, please consult your first-year Calculus textbooks for further information.

#quizzes[
  + What is the definition of $f'(x)$? Explain.
]
In physics, it is important to memorize and understand the #keyword[definition] of each concept.


= Taylor expansion

Reviewing the definition of $f'(x)$, we have
$
  f'(x) := lim_(Delta x->0) (f(x+Delta x)-f(x))/(Delta x),
  wide
  f'(a) := lim_(delta->0) (f(a+delta)-f(a))/(delta).
$ <def-deriv>
The second equation is interpreted as follows:
$
  "If " delta approx 0, quad f'(a) approx (f(a+delta)-f(a))/(delta),quad "i.e.,"quad f(a+delta)approx f(a)+delta thin f'(a)
$<taylor-1>
and this interpretation is useful in the following example:
#example()[
  Find the approximate value of the following expressions without using calculators. Then, check your answer with a calculator.
  #h-enum(cols: 3)[
    + $sqrt(1.002)$
    + $(1.002)^10$
    + $sqrt(4.004)$
  ]
]
#solution[
  #enum(numbering: cn => box(width: 2em, align(right, text-sf[*(#cn)*])), tight: false)[
    Apply @taylor-1 for $f(x)=sqrt(x)$, $a=1$, and $delta=0.002$. Then,
    #no-num(
      comma-gap: auto,
      $
        f'(x)=1/(2sqrt(x)),
        f'(a)=f'(1)=1/2,
        f(a+delta)approx f(a)+delta f'(a)=1+delta/2=underline(1.001).
      $,
    )
  ][
    Doing the same thing for $g(x)=x^10$ with $a=1$ and $delta=0.002$,
    #no-num(
      comma-gap: auto,
      $
        g'(x)=10x^9,
        g'(a)=g'(1)=10,
        g(a+delta)approx g(a)+delta g'(a)=1^10+10delta=underline(1.02).
      $,
    )
  ][
    Doing the same thing for $h(x)=sqrt(x)$, $a=4$, and $delta=0.004$, we have
    #no-num($h'(4)=1/4,quad h'(4.004) approx h(4)+0.004times 1/4 = underline(2.001).$)
  ]]
#advanced-note[
  "Solutions" contain not only the answer but also how you reached the answer. You are, of course, asked to write such explanations when you solve problems.]

Namely, with this technique, you can find *the value of $f(x)$ around a point $x=a$.*
This technique, @taylor-1, is a special case of Taylor's theorem, which is discussed in #TODO[???].

#quizzes()[
  + Find the approximate value of the following expressions without using calculators. Then, check your answer with a calculator.
    #h-enum(cols: 3)[
      + $sqrt(1.001)$
      + $(1.0001)^30$
      + $1/1.001$
    ]
]

To summarize, we have the following statement:

#theorem(type: "Statement", title: "Taylor expansion: basic")[
  For a physicists-friendly function $f(x)$,
  $ f(a+delta) & approx f(a) + delta f'(a), $ <taylor-simple>
  or as an equivalent expression,
  $ f(x) & approx f(x_0) + (x-x_0) f'(x_0). $
]
#quizzes()[
  + Check these two equations are equivalent. You will be ready to use either of them in the future.
  + Review how to derive @taylor-simple and summarize it in your own words.
]

#problems[
  + `9` Calculate the following expression.
    #h-enum(cols: 5)[
      + $sin 30 degree$
      + $cos 45 degree$
      + $cos 120 degree$
      + $sin 150 degree$
      + $tan 180 degree$
      + $cos 0$
      + $sin 2pi$
      + $cos pi$
      + $sin(pi\/3)$
      + $cos(-pi\/4)$
      + $tan(2pi\/3)$
      + $sin(pi\/6)$
      + $tan(5pi\/6)$
      + $cos(-pi\/6)$
      + $tan(-pi\/2)$
    ]
  + `9` For the following $f(x)$, calculate $f'(x)$, $f''(x)$, $f^((3))(x)$, $f^((4))(x)$, and $f^((5))(x)$.
    #h-enum(cols: 4)[
      + $x^3$
      + $sin 2x$
      + $ee^(2x)$
      + $ln 2x$
    ]
  + `9` Find the approximate value for the following expressions without calculators. Then, check your answer with a calculator.
    #h-enum(cols: 5)[
      + $(1.002)^7$
      + $(2.002)^7$
      + $(0.998)^4$
      + $(10.01)^3$
      + $1 div 0.998$
      + $sqrt(0.998)$
      + $sqrt(4.001)$
      + $(0.999)^(1\/2)$
      + $(0.999)^(-1\/2)$
      + $(0.999)^(-3\/2)$
      + $1/(2.02)^2$
      + $tan 0.001$
      + $cos 0.002$
      + $sin 0.003$
      + $ln 1.001$
    ]
  + `2` Find the approximate value for the following expressions without calculators. Then, check your answer with a calculator.
    #h-enum(cols: 5)[
      + $root(3, 1.001)$
      + $root(3, 8.012)$
      + $1.001^0.5$
      + $1.001^(-0.9)$
      + $sin(3.14)$
      + $cos(1.57)$
      + $sin 1degree$
      + $cos 61degree$
      + $ln 0.999$
      + $log_10(10.01)$
      + $sqrt(1.001)sin 0.001$
    ]
  #fail-safe[If you are not sure about $root(3, 1.001)$, $(1.001)^(-0.9)$, etc., study @chap:pow first.]
  + `2` For the following $f(x)$, calculate $f^((n))(x)$ for all positive integers $n=1,2,3,...$.
    #h-enum(cols: 5)[
      + $x^10$
      + $sin 2x$
      + $ee^(2x)$
      + $ln x^2$
      + $sqrt(x)$
    ]

  + `1` Write down the definition of the second derivative $f''(x)$. Repeat the discussion of @taylor-1 to find the expansion $f'(a+epsilon) approx f'(a) + epsilon f'(a) + (epsilon^2\/2) f''(a)$.
]

#advanced-note[
  The two equations in @def-deriv have similar but different meanings: the first one defines a new function $f'(x)$, while the second one defines a number that is eventually equal to $f'(x)|_(x=a)$. Anyway, we don't care the difference.]



= Mathematical Notation
As _physicists are lazy_, we usually use the following notation:

#writings(
  box: (true, false, true, false),
  align: (left, left),
  $x in CC$,
  [means "$x$ is a complex number".],
  $x in ZZ$,
  [means "$x$ is an #keyword[integer]".#footnote[Z comes from "Zahlen" (Zahl).]],
  $x in RR$,
  [means "$x$ is a real number".],
  $x in NN^+$,
  [means "$x$ is a positive integer".],
  $x in QQ$,
  [means "$x$ is a #keyword[rational number]".],
  $x in NN^0$,
  [means "$x$ is a non-negative integer".],
)
The symbol "$in$" means _"is a member of"_, and $NN^+$ means a #keyword[set] of positive integers, ${1, 2, 3, 4, ...}$. So,
#writings(
  box: (true, false, true, false),
  align: (left, left),
  $x in NN^+$,
  "and",
  [$x in {1, 2, 3, 4, 5, ...}$],
  [means the same thing: "$x$ is a positive integer".],
)

#remark[
  In mathematics, "natural numbers" usually mean $NN^0$. Meanwhile, physicists and other people tend to think natural numbers mean $NN^+$ .
]


#quizzes[
  + What is the difference between $NN^+$ and $NN^0$?
  + What is the difference between $NN^0$ and $ZZ$?
  + What is "rational numbers"? What is the difference between $ZZ$ and $QQ$?
]

We write "$x$ is a positive number" by #writing[$x in RR, x>0$] but also by #writing[$x>0$]. Similarly,
#writings(
  box: (true, false, true, false),
  align: (left, left),
  $x in RR, x <= 0$,
  "or",
  $x<=0$,
  [means "$x$ is a non-positive number".],
)
Notice that, when we say "positive" or "negative", we implicitly assume the number is real.
#advanced-note[
  This is because we cannot compare complex numbers with $0$. The operator $>$ is defined only for real numbers. When we write $a>b$, we implicitly consider that $a$ and $b$ are real numbers.
]
#problems[
  + `2`
    The #keyword[intersection] of two sets $A$ and $B$ is a set made by elements both in $A$ and $B$; we write it by $A inter B$. The #keyword[union] of $A$ and $B$ is a set made by elements in $A$, $B$, or both; we write it by $A union B$.
    The #keyword[set difference], $A without B$, is a set made by elements in $A$ but not in $B$.

    For example, let $A={1, 2, 3}$, $B={2, 3, 4}$, and $C={2, 4}$. Then,
    #no-num[$ A inter B = {2, 3}, quad A union B = {1, 2, 3, 4}, quad A without C = {1, 3}, quad B without C = {3}, quad C without B = {} $,]
    where ${}$ (or $emptyset$) means the #keyword[empty set], the set without any elements.

    + Write the following sets.
      #h-enum(cols: (1fr, 1fr, 1fr, 1.3fr, 1.3fr))[
        + $A inter C$
        + $B inter C$
        + $A union C$
        + $B union C$
        + $A union B union C$
        + $B without A$
        + $C without A$
        + $C without B$
        + $(B without A) union A$
        + $NN^0 without NN^+$
      ]
    + Express the following statements only with $RR$, $QQ$, $ZZ$, $NN^+$, $NN^0$, $inter$, $union$, $without$, and "$x in$".
      #h-enum(cols: (1.4fr, 1fr))[
        + $x$ is a rational number.
        + $x$ is an irrational number.
        + $x$ is a rational number but not an integer.
        + $x$ is a non-positive integer.
        + $x$ is a negative integer.
        + $x$ is a non-zero integer.
      ]
]
