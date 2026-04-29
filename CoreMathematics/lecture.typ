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
  This document is a set of lecture notes for first-year university students in physics or physical science.
  The notes cover the mathematical tools most immediately needed: calculus, logic, complex numbers, vectors, and include introductions to vector calculus, differential equations, and statistical analysis.
  Exercises are central to this document. "Drill" the topics until you can use the tools fast and precisely!
])

#include "preface.typ"

#let ja-star = JA(size: 9pt, "★")

#set heading(numbering: "1.1.1")

#chapter[Derivative (Review)]

= Introduction

#remark[
  This document is designed for first-year students in their _second semester_, who *already learned derivatives* in their first semester _"calculus"_ lecture.
  If you are not confident in derivatives, you are advised to study
  #link("https://misho104.github.io/LecturePublic/", "the Derivative Boot Camp") first#footnote[Visit https://misho104.github.io/LecturePublic and find `gp1_boot1_deriv_true.pdf`.],
  where you should solve (only) the #ja-star -marked problems there.
]

Birds sing, fish swim, flowers bloom, stars twinkle, and university students calculate derivatives.
So, let's begin with basic derivatives.
Do the next quiz! _How many minutes does it take?_

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

If you finished it within two minutes... Wonderful! Most students should take 3--4 minutes. If you took more than four minutes, don't worry.
At least you could calculate them, so just a bit more practice will make you perfect.
Try some problems in
#link("https://misho104.github.io/LecturePublic/", "the Derivative Boot Camp")

...Oh, you couldn't get the correct answer because of calculation mistakes? That's not a very good sign, as bad as you've forgot how to calculate them.
Since you are going to do such calculations more than 100 times in this semester, you should be able to do them fast and precisely.


#ornament-skip

In university, basic calculations are often overlooked, but their speed and accuracy are important.
Since simple calculations appear frequently in physics, speed and accuracy strongly affect your understanding of lectures, your efficiency in self-study, and ultimately your grade.
Speed and accuracy can be improved through practice.


This lecture course aims to help you improve such basic calculations, some of which you have already learned in high school, while also introducing new topics that are essential for physics.
You are asked to solve many problems and drills, much like children practicing basketball free throws hundreds of times.


= Typical Pitfalls
== Notations
#set math.equation(supplement: "Eq.", numbering: it => { numbering("(1.1)", counter(heading).at(here()).at(0), it) })

#let qeq = $quad = quad$

Consider a function $f(x)$. The derivative of $f(x)$ is written by $f'(x)$.
For example, if $f(x)=3x^2$, then $f'(x)=6x$.
We may express it in several ways:
$ f'(x) qeq dv(f, x)(x) qeq dv(f(x), x) qeq dv(x)f(x). $
They all mean the same thing. Don't be confused!

We may consider $f'(x)$ at a specific point, say $x=3$.
If $f(x)=3x^2$, then
$f'(3)=18$.
Typically, we use the following forms to express it:
$ f'(3) qeq eval(f'(x))_(x=3) qeq eval(dv(f, x)(x))_(x=3) qeq eval(dv(f(x), x))_(x=3) qeq eval(dv(f, x)(x))_(x=3) $
but also some authors may write it as $quad display(dv(f, x)(3))quad$ or $quad display(dv(x)f(3)).$

Students are often confused when we have a #EMPH[constant] $a$. If a symbol $a$ is _declared as a constant_, then we may have functions such as $g(x)=a x^2+2a-6$, for which
$ g'(x) = 2 a x. $ <d1>
Now we can consider the value of $g'(x)$ at $x=a$. It is of course $g'(a)=2a^2$, and we write it as
$ g'(a) qeq eval(g'(x))_(x=a) qeq dv(g, x)(a) qeq dv(x)g(a) quad = quad 2a^2. $
Again, don't be confused! The notation $display(dv(x)g(a))$ does *not* mean $display(dv(x)lr([g(a)], size: #150%)) = display(dv(x)(a^3+2a-6))=0$.


#fail-safe[
  If you are puzzled with @d1, imagine $a=3$. Then $g(x)$ is equal to $f(x)$, and $g'(x)$ should be equal to $f'(x)$.
]

#make-indent
But here is a further bad news. Usually _physicists are so lazy_ that we often omit the $(x)$ parts. For example, if we have $f(x)=3x^2$ and $F(t)=t^2+a t+1$, and $a$ is _declared as a constant_,
$
  & f' qeq dv(x)f qeq 6x, wide   && f'(a) qeq dv(x)f(a) qeq 6a, \
  & F' qeq dv(t)F qeq 2t+a, wide && F'(a) qeq dv(t)F(a) qeq 3a.
$
So, if you see a function $f$, you need to find out the variable of it, guessing the author's intention.

Furthermore, we may "rename" the variables. For example, if $x$ and $t$ are #EMPH[variables], we will consider $3x^2$ and $3t^2$ are the same functions. As $3x^2$ is equal to $f(x)$, the second one $3t^2$ can be expressed by $f(t)$, and its derivative is expressed by $display(dv(f, t)=6t)$.

#advanced-note[
  We usually write "Let $a$ be a constant." to declare $a$ as a constant.
  Therefore, you also have to do so when you write proofs or exam answers.
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


