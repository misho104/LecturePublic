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
  #link("https://misho104.github.io/LecturePublic/", "the Derivative Boot Camp") first#footnote[Visit https://misho104.github.io/LecturePublic and find `gp1_boot1_deriv_true.pdf`.],
  and solve only the #ja-star -marked problems there.
]

Birds sing, fish swim, flowers bloom, stars twinkle, and university students calculate derivatives.
Let us begin with basic derivatives.
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
and they are all equivalent. For example, if $f(x)=3x^2$, then $f'(x)=6x$ and $f'(3) = 18$.

The real pitfalls come next. Students often get confused when a #EMPH[constant] $a$ appears. If $a$ is _declared as a constant_, we can define a function such as $g(x)=a x^2+2a-6$, for which
$ g'(x) = 2 a x. $ <d1>
We can evaluate $g'(x)$ at $x=a$. The result is $g'(a)=2a^2$, written as
$ g'(a) qeq eval(g'(x))_(x=a) qeq dv(g, x)(a) qeq dv(x)g(a) quad = quad 2a^2. $

#be-careful[
  the notation $display(dv(x)g(a))$ does *not* mean $display(dv(x)lr([g(a)], size: #150%)) = display(dv(x)(a^3+2a-6))=0$.
]

#fail-safe[
  If @d1 is confusing, try setting $a=3$. Then, $g(x)=f(x)$, and $g'(x)$ should equal $f'(x)$.
]

#make-indent
There is more bad news. _Physicists are often lazy_, and we frequently omit the argument $(x)$. For example, if $f(x)=3x^2$ and $F(t)=t^2+a t+1$, and if $a$ is _declared as a constant_,
$
  & f' qeq dv(x)f qeq 6x, wide   && f'(a) qeq dv(x)f(a) qeq 6a, \
  & F' qeq dv(t)F qeq 2t+a, wide && F'(a) qeq dv(t)F(a) qeq 3a.
$
So when you see a function written as $f$, you must identify its variable by reading the context.
For example, we sometimes replace the variables. Assume $f(x)=3x^2$. If $t$ is another #EMPH[variable] (= not a constant), we can understand $3t^2$ is the same function $f(t)$. So we may write $f(t)=3t^2$, whose derivative is $f'(t)=dv(f, t, style: "horizontal")=6t$.

#advanced-note[
  To declare that $a$ is a constant, write "Let $a$ be a constant."
  You must do the same when writing proofs or exam answers.
]

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

== Degree and Radian



#problems[
  + `9` Hogehoge
  + `9` #lorem(80)
  + `4` Hogehoge
  + `1` Hogehoge
  + `1` #lorem(80)

]


