#import "misho-text.typ": EMPH, JA, RED, ZH, c, h-enum, problems, quizzes, text-sf
#import "@preview/in-dexter:0.7.2": first-letter-up, make-index

#place(bottom + left, dx: 1.3mm, dy: 2.3mm, float: true, text-sf(size: 9pt, fill: c.gray)[
  #grid(
    columns: (23.7mm, auto),
    image("by-nc.pdf", width: 22mm),
    text(baseline: -.7mm, top-edge: 2.7mm)[This document is licensed under
      #link(
        "https://creativecommons.org/licenses/by-nc/4.0/",
      )[the Creative Commons CC--BY--NC 4.0 International Public License.]\
      You may use this document only if you do in compliance with the license.\
    ],
  )
  Visit https://github.com/misho104/LecturePublic for further information, updates, and to report issues.
])


= Preface

Physics is an activity to describe the world, but how? At present, mathematics (+_ broken_ English) is the only language we can use. So, unfortunately, we need to learn mathematics! (and #box("English" + sym.dots + "🥺"))
But, in some sense, you are fortunate, since you have a language.
Math and physics have developed together, so you will understand physics better if you study mathematics well!

When you do DIY, you need to use the tools properly, smoothly, and accurately.
It is the same here; when we use math as a tool, it must be *logical*, *quick*, and *accurate*.
To be logical, you must think each problem carefully; otherwise your discussion might be incomplete and you can't convince others.
To be quick and accurate, you must _"drill"_ repeatedly, as if top NBA players do shooting practice almost everyday.
You should reach the point where basic calculations feel automatic.

#EMPH[This is not] a math textbook, so theorem proofs are mostly omitted.
#EMPH[This is rather] an exercise book. Problems and drills are the core of this book.

=== Target of this document

This document is primarily for first-year undergraduate students in their second semester, who are majoring in physics or physical science.

=== How to use this book

First, buy a A4-sized paper notebook.
You are expected to solve problems, and when you solve "problems", you are strongly recommended to write down your solution process on the notebook, preferably with full descriptions in English.
Meanwhile, "drills" are for you to practice calculations, so you can just write down the final answer, or just do it in your brain.

Prepare the textbook [Boas] (see "References" below) and use it as a reference.
When you want to understand the details of a topic, or when you want to solve more problems, consult [Boas].

#pagebreak()

= References


This document is written under the influence of the following references.

- #link("https://haltasaki.github.io/books/math/")[The Math Book by Hal Tasaki] (#JA[数学：物理を学び楽しむために], in Japanese)

  A free book with full description, but unfortunately in Japanese.
  Topic selections and the depth of descriptions are based on this reference.

- #link("https://lecture.ecc.u-tokyo.ac.jp/gocho/")[First-Year Math Practice] (in Japanese)

  This document is grounded in a "learn steadily" approach ("#JA[じっくり]" in Japanese), which originates from Prof. Gocho and Prof. Kiyono, who were instructors of Sho in his freshman.
  Problems and rigorous math descriptions are taken from their works.

- Mary L. Boas, _Mathematical Methods in the Physical Sciences_, 3rd ed., Wiley, 2006.
- Arfken, Weber, and Harris, _Mathematical Methods for Physicists_, 7th ed., Academic Press, 2023.

  These two books are widely used in physics departments around the world and referred to in this document many times as [Boas] and [AWH]. [Boas] seems more friendly to beginners, while [AWH] seems more detailed and complete.
  Sho recommends you to study [Boas] _in parallel with_ this document, using it as a reference, and to consult [AWH] when you want more details or more exercises.

= Lecture Plan

The content is designed for 150-minute #sym.times 14-week lectures, as it is originally for a lecture _Mathematics for Fundamental Physics_ (#ZH[基礎物理數學]) in National Sun Yat-sen University (#ZH[國立中山大學]).

+ Derivative
+ Units. Significant Digits.
+ Logic. Theorems. $a^x$ and $log_a x$.
+ Logic. Theorems. $a^x$ and $log_a x$.
+ Vectors are arrows.
+ $a dot b$ and $a times b$
+ Matrices (rotation, reflection, scaling)
+ Complex numbers (polar form, Euler's formula, multi-valuedness)
+ Complex vectors, Hermitian inner product, bra-ket notation
+ Vector calculus (grad, div, rot; example of point charge)
+ ODE basics
+ ODE basics
+ Probability and error analysis
+ Probability and error analysis


#pagebreak()

= Symbols
/*
#block(height: 26em)[
  #columns(2, gutter: 5em)[
    #table(
      columns: (auto, auto, 1fr),
      rows: 2em,
      fill: (_, y) => if calc.even(calc.rem(y, 13)) { c.dim-gray },
      align: horizon,
      stroke: (x: none),
      [A], [a], [],
      [B], [b], [],
      [C], [c], [],
      [D], [d], [],
      [E], [e], [],
      [F], [f], [],
      [G], [g], [],
      [H], [h], [],
      [I], [i], [],
      [J], [j], [],
      [K], [k], [],
      [L], [l], [],
      [M], [m], [],
      [N], [n], [],
      [O], [o], [],
      [P], [p], [],
      [Q], [q], [],
      [R], [r], [],
      [S], [s], [],
      [T], [t], [],
      [U], [u], [],
      [V], [v], [],
      [W], [w], [],
      [X], [x], [],
      [Y], [y], [],
      [Z], [z], [],
    )
  ])
]
*/

== Mathematical Notations

#block(height: 14em)[
  #columns(2, gutter: 0em)[
    #table(
      columns: (auto, 1fr),
      rows: 2em,
      align: horizon,
      stroke: (x: none, y: .5pt),
      table.cell(colspan: 2)[*Chapter 1*],
      [$NN$], [natural numbers],
      [$NN_0$], [natural numbers (0, 1, 2, ...)],
      [$NN^+$], [natural numbers (1, 2, ...)],
      [$RR$], [real numbers],
      [$QQ$], [rational numbers],
      [$CC$], [complex numbers],
    )
  ]
]

== Greek symbols
#let NU(body) = table.cell(fill: luma(90%), text(fill: luma(50%), body)) // cspell:disable-line
#let CA(body) = table.cell(fill: c.alt-b, body)
#block(height: 12em)[
  #columns(4, gutter: 0em)[
    #table(
      columns: (auto, auto, auto),
      rows: 2em,
      fill: (_, y) => if calc.even(calc.rem(y, 13)) {},
      align: (center + horizon, center + horizon, left + horizon),
      stroke: (x: none),
      NU[$Α$], [$α$], [alpha],
      NU[$Β$], [$β$], [beta],
      [$Γ$], [$γ$], [gamma],
      [$Δ$], [$δ$], [delta],
      NU[$Ε$], [$ε$], [epsilon],
      NU[$Ζ$], [$ζ$], [zeta],
      NU[$Η$], [$η$], [eta],
      [$Θ$], [$θ$], [theta],
      NU[$Ι$], NU[$ι$], NU[iota],
      NU[$Κ$], [$κ$], [kappa],
      [$Λ$], [$λ$], [lambda],
      NU[$Μ$], [$μ$], [mu],
      NU[$Ν$], [$ν$], [nu],
      [$Ξ$], [$ξ$], [xi],
      NU[$Ο$], NU[$ο$], NU[omicron],
      [$Π$], [$π$], [pi],
      NU[$Ρ$], [$ρ$], [rho],
      [$Σ$], [$σ$], [sigma],
      NU[$Τ$], [$τ$], [tau],
      NU[$Υ$], NU[$υ$], NU[upsilon],
      [$Φ$], [$phi$], move(dx: -3mm, [$(phi.alt)quad$phi]),
      NU[$Χ$], [$χ$], [chi],
      [$Ψ$], [$ψ$], [psi],
      [$Ω$], [$ω$], [omega],
    )
  ]
]
Gray-outed ones are almost never used, but others are almost always used.
You need to write them so that *others can distinguish each from others*, but Sho thinks Japanese- or Chinese-speakers are OK with it, as we everyday read and write #ZH[日] vs #ZH[曰] vs #ZH[白] or #ZH[土] vs #ZH[士] vs #ZH[工] properly!


#quizzes[
  + `4` Read out the following words.
    #h-enum(cols: 3)[
      + $α$-particle
      + $β$-decay
      + $Γ$-function
      + $ε$-$δ$ definition
      + angle $θ$ and $φ$
      + $μ$- and $τ$-leptons
      + $ψ(x)$ and $φ(x)$
      + $ζ$ and $ξ$
      + metric $η_(μ ν)$
      + X-ray and $γ$-ray
      + $Ω$-baryon
      + $ε_(μ ν ρ σ)$-tensor
    ]
]

#problems[
  + `4` Write the following letters so that people can distinguish each from others.
    #h-enum(cols: 4)[
      + $a$, $α$
      + $b$, $β$
      + $c$, $C$
      + $e$, $E$, $ε$
      + $ζ$, $ξ$
      + $Θ$, $θ$, $Q$, $σ$, $6$
      + $g$, $q$, $9$
      + $i$, $l$, $1$, $I$
      + $k$, $K$, $κ$
      + $m$, $μ$
      + $p$, $ρ$
      + $s$, $S$
      + $t$, $τ$, $T$
      + $u$, $v$, $ν$
      + $w$, $W$, $ω$
      + $x$, $X$, $χ$
    ]
]

== Index
#columns(3)[
  #make-index(
    section-title: (l, c) => v(3mm),
    entry-casing: e => {
      if type(e) == str and e.len() > 0 {
        let c = e.trim().clusters()
        let chop = c.len() >= 3 and c.last() == "s" and c.at(-2) != "s"
        // upper(c.first()) + c.slice(1, if chop { -1 }).join()
        c.slice(0, if chop { -1 }).join()
      } else { e }
    },
  )
]
