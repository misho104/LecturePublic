#import "misho-text.typ": *
#import "physica.typ": *
#let metadata = (
  title: "Core Mathematics",
  description: "A Lecture note for \"Mathematics for Fundamental Physics\".",
  copyright-years: [2024–2025],
  subtitle: "A Practical Guide on Mathematics for Physics Learners",
  revision: "v0.0.1",
)
#show: misho-text.with(metadata)

#import "title.typ": title
#title(metadata, [
  These are lecture notes for first-year university students in physics or physical science.
  They cover the mathematical tools you need most: calculus, logic, complex numbers, and vectors, with introductions to vector calculus, differential equations, and statistical analysis.
  Exercises are central to these notes. Practice each topic repeatedly until you can work through problems quickly and accurately.
])

#include "preface.typ"

#let ja-star = JA(size: 9pt, "★")

#set heading(numbering: "1.1.1")

#chapter[Derivative (Review)]

= Introduction

#remark[
  This document is designed for first-year students in their _second semester_, who *have already studied derivatives* in their first-semester _"calculus"_ course.
  If you are not yet confident with derivatives, please study
  #link("https://misho104.github.io/LecturePublic/", "the Derivative Boot Camp") first#footnote[Visit https://misho104.github.io/LecturePublic and find `gp1_boot1_deriv_true.pdf`.].
]

Birds sing, fish swim, flowers bloom, stars twinkle, and university students calculate derivatives.
Let us begin with basic #keyword[derivatives].
Try the next quiz---and note how long it takes.

#quizzes[
  #show math.equation.where(block: false): it => math.display(it)
  + `4` Calculate the first derivatives of the following functions.
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

If you finished within two minutes---Wonderful! Most students take 3--4 minutes.
If you took more than four minutes, do not worry: you can do the calculations, and a little more practice will help.
Try some problems in
#link("https://misho104.github.io/LecturePublic/", "the Derivative Boot Camp")

Did you make calculation mistakes and get wrong answers? That is a serious issue---just as serious as forgetting how to do the calculations at all.
You will perform similar calculations more than 100 times in university, so you need to be both fast and accurate.


#ornament-skip

At university, students often underestimate the importance of basic calculations.
In physics, simple calculations appear constantly, so your speed and accuracy directly affect how well you follow lectures, how efficiently you study, and ultimately your grade.
Both can be improved with practice.


This course will help you strengthen these basic calculations---some of which you already know from high school---while also introducing new topics that are essential for physics.
You will solve many problems and drills, just as a beginner athlete repeats the same move hundreds of times to master it.


= Typical Pitfalls
== Notations
#set math.equation(supplement: "Eq.", numbering: it => { numbering("(1.1)", counter(heading).at(here()).at(0), it) })

#let qeq = $quad = quad$

There are several equivalent ways to write the derivative of $f(x)$:
$ f'(x) qeq dv(f, x)(x) qeq dv(f(x), x) qeq dv(x)f(x) wide "[All means the same thing]." $
Similarly, the value of $f'(x)$ at a specific point $x=3$ can be written as
$ f'(3) qeq eval(f'(x))_(x=3) qeq eval(dv(f, x))_(x=3) qeq dv(f, x)(3) qeq dv(x)f(3), $
and they are all equivalent. For example, if $f(x)=3x^2+6$, then $f'(x)=6x$ and $f'(3) = 18$.

The real pitfalls come next. Students often get confused when a #keyword[constant] $a$ appears. If $a$ is _declared as a constant_, we can define a function such as $g(x)=a x^2+2a$, for which
$ g'(x) = 2 a x. $ <d1>
We can evaluate $g'(x)$ at $x=a$. The result is $g'(a)=2a^2$, written as
$ g'(a) qeq eval(g'(x))_(x=a) qeq dv(g, x)(a) qeq dv(x)g(a) quad = quad 2a^2. $

#be-careful[
  the notation $display(dv(x)g(a))$ does *not* mean $display(dv(x)lr([g(a)], size: #150%)) = display(dv(x)(a^3+2a))=0$.
]
#fail-safe[
  If you can't see @d1, try setting $a=3$. Then, $g(x)=f(x)$, and $g'(x)$ should equal $f'(x)$.
]

#make-indent
There is more bad news. _Physicists are often lazy_, and we frequently omit the argument $(x)$. For example, if $f(x)=3x^2$ and $F(t)=t^2+a t+1$, and if $a$ is _declared as a constant_,
$
  & f' qeq dv(x)f qeq 6x, wide   && f'(a) qeq dv(x)f(a) qeq 6a, \
  & F' qeq dv(t)F qeq 2t+a, wide && F'(a) qeq dv(t)F(a) qeq 3a.
$
So when you see a function written as $f$, you must identify its variable by reading the context.
For example, we sometimes replace the variables. Assume $f(x)=3x^2$. If $t$ is another #keyword[variable] (= not a constant), we can understand $3t^2$ is the same function $f(t)$. So we may write $f(t)=3t^2$, whose derivative is $f'(t)=dv(f, t, style: "horizontal")=6t$.

#advanced-note[
  We usually write "Let $k$ be a constant" to declare $k$ as a constant. You need to do so, too.
]

#EMPH[Higher-order derivatives]#index("order") is written as
$
  dv(x)(dv(f, x)) = dv(f, x, x)=f''(x) = f^((2))(x),wide
  dv(x)(dv(x)(dv(f, x))) = dv(f, x, x, x)=f'''(x) = f^((3))(x),
$
etc. Please be careful on the position of "2" and "3".

#quizzes[
  + `4` Let $a$ and $b$ be constants. If $f(x)=3x^2$, $g(t)=a t^2+b$, $F(x)=a+3$, and $G(t)=a cos(t)+x sin(t)$, what are the following expressions?
    #h-enum(cols: 4, v-sep: 1.5em)[
      + $f'(x)$
      + $f'(0)$
      + $f'(a)$
      + $f'(-a)$
      + $g'(t)$
      + $g'(0)$
      + $g'(b)$
      + $g'(x)$
      + $F'(a)$
      + $G'(t)$
      + $G'(0)$
      + $G'(a)$
      + $display(dv(f, x))$
      + $display(dv(f, x)(0))$
      + $display(dv(g, t))$
      + $display(dv(g(x), x))$
    ]
]

== Radian and trigonometric functions

At university, angles are almost always measured in #keyword[radians]:
$
  360 "degree" quad ("or:" 360degree) qeq 2pi "radian" quad ("or:" 2pi "rad")
$
Furthermore, we usually omit "radian" (because we are lazy!) Now,
$
  "a right angle is " pi\/2.quad "The sum of the interior angles of a triangle is" pi.\
$
#quizzes[
  + `4` Express the following angles in radians, and radians in angles.
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
$ dv(x) sin x = cos x. $ <sin-deriv>
Because we have chosen radians as the standard, $(sin x)'$ becomes this simple.

#advanced-note[
  The simpleness of @sin-deriv originates in the fact $sin(0.01 "rad") approx 0.01$. If we used degrees, we would have $sin(0.01 degree) approx 0.01 times 0.017453$ and  everything is messed up with this number 0.017453.
]

#make-indent
There are a few remarks in the notation of #keyword(key: "trigonometric function", [trigonometric functions]):
$
  & sin^2 x != sin x^2. wide && "Namely,"quad (sin x)^2 = sin^2 x quad   && != quad sin x^2 = sin(x^2). \
  & tan^(-1) x != 1/(tan x). && "Namely,"quad tan^(-1) x = arctan x quad && != quad (tan x)^(-1) = 1/(tan x) = cot x.
$
The following are not incorrect but confusing. _We should avoid ambiguity_, so please don't use them.
#no-num(
  $
    #RED[$sin^(-2) x$],quad
    #RED[$sin^(1\/2) x$],quad
    #RED[$sin(x)^2$],quad
    #RED[$sin (x+1)^2$],...
  $,
)
Sho thinks we should only use $quad sin^k x quad$ for $k=2, 3, 4, ...$, and use $quad arcsin x quad$ instead of $sin^(-1)x$.

== Several interpretations of derivatives
When you, physics learners, discuss $f'(t)$, you should have the following three interpretations:

- Regarding $t$ as the time, $f'(t)$ is the #keyword[rate of change] of $f(t)$ per unit time. If $f'(t)>0$, the function $f$ is increasing at the time $t$, while $f'(t)<0$ means it is decreasing.

- Consider a graph of $f(t)$. Then, $f'(t)$ is the slope of the #keyword[tangent line] to the graph at the point $t$.

- Mathematically, $f'(t)$ is defined by (Check that they are equivalent.) $ f'(t)
  := lim_(Delta t->0) (f(t+Delta t)-f(t))/(Delta t)
  = lim_(h->0) (f(t+h)-f(t-h))/(2h)
  = lim_(s->t) (f(s)-f(t))/(s-t). $

If you are unsure of them, please consult your first-year Calculus textbooks for further information.

= Taylor expansion

Reviewing the previous equation for a function $f(x)$, we have
$
  f'(x) := lim_(Delta x->0) (f(x+Delta x)-f(x))/(Delta x),
  wide
  f'(a) := lim_(delta->0) (f(a+delta)-f(a))/(delta).
$ <def-deriv>
#advanced-note[
  These two have a bit different sense: the first one defines a new function $f'(x)$, while the second one defines a number that is eventually equal to $f'(x)|_(x=a)$. Anyway, we don't care the difference.]
We can understand the second equation as
$
  "If " delta approx 0, quad f'(a) approx (f(a+delta)-f(a))/(delta),quad "i.e.,"quad f(a+delta)approx f(a)+delta thin f'(a).
$<taylor-1>
These equations will be helpful if you want to know *what is $f(x)$ around the point $x=a med$?*
#example()[
  Find the approximate value of the following expressions:
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
      $f'(x)=1/(2sqrt(x)),quad f'(a)=f'(1)=1/2, quad f'(a)approx f(a)+delta f'(a)=sqrt(1)+delta/2=underline(1.001).$,
    )
  ][
    Doing the same thing for $g(x)=x^10$, we have
    #no-num($g'(x)=10x^9,quad g'(a)=g'(1)=10, quad g'(a)approx g(a)+delta g'(a)=1^10+10delta=underline(1.02).$)

  ][
    Doing the same thing for $h(x)=sqrt(x)$, $a=4$, and $delta=0.004$, we have
    #no-num(
      $h'(4)=1/4,quad h'(4.004) approx h(4)+0.004times 1/4 = underline(2.001).$,
    )
  ]]

This technique, and @taylor-1, is a special case of the more general #keyword[Taylor's theorem]:

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


#problems[
  + `4` Find the approximate value of the following expressions:
    #h-enum(cols: 3)[
      + $(1.002)^5$
      + $sin(0.001)$
      + $cos(0.001)$
      + $tan(0.001)$
      + $sqrt(4.004)$
    ]
  + `3` Find the approximate value of the following expressions:
    #h-enum(cols: 3)[
      + $sin(3.14)$
      + $cos(1.57)$
      + $root(3, 1.001)$
      + $(1.002)^0.9$
      + $1\/(10.004)^3$
      + $sqrt(10001)$
    ]

  #fail-safe[If you are not confident with the meaning of $root(3, 1.001)$, $(1.001)^(-0.9)$, etc., please go to ...]

  + `2` Write down the definition of the second derivative $f''(x)$. Repeat the discussion of @taylor-1 to find the expansion $f'(a+epsilon) approx f'(a) + epsilon f'(a) + (epsilon^2\/2) f''(a)$.
]
