#import "misho-text.typ": EMPH, JA, RED, TODO, ZH, c, h-enum, keyword, problems, quizzes, tab, text-sf
#import "@preview/in-dexter:0.7.2": first-letter-up, make-index

#let ds(body) = text-sf(body)

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

Physics is an activity to describe the world, but how? At present, mathematics (+ _broken_ English) is the only language we can use. So, _unfortunately_, we need to learn mathematics! (and #box("English" + sym.dots + "🥺"))
But it means we are _fortunate_: we have a language to describe the world.
In fact, physics have developed together with mathematics. We understand physics better if we study mathematics well!

When you do DIY, you need to use the tools properly, smoothly, and accurately.
It is the same here; when we use math as a tool, it must be *logical*, *quick*, and *accurate*.
To be logical, you must think each problem carefully; otherwise your discussion might be incomplete and you can't convince others.
To be quick and accurate, you must _"drill"_ repeatedly, as if top NBA players do shooting practice almost everyday.
You should reach the point where basic calculations feel automatic.

#EMPH[This is not] a math textbook. #EMPH[This is rather] a math "drill" book. Rigorous proofs are mostly omitted, but drill problems are the core of this document, through which students are expected to achieve better conceptual understanding.


=== Target of this document

This document is primarily for first-year undergraduate students in their second semester, who

- completed basic calculus (differentiation and integration),

- are going to major in physics or physical science, and

- do not hesitate to do repetitive practice to achieve better conceptual understanding.

=== How to use this document

#[
  #show enum: set par(first-line-indent: 1em, hanging-indent: 1em)

  + *Buy a A4-sized paper notebook*.

    Digital notebooks on tablets are not suitable (less effective).

  + Read the text and solve #EMPH[Quizzes].

    The texts are kept short, so please read all the text carefully. Quizzes should be solved while reading, but you don't have to write down the solution process for Quizzes.

  + Solve #EMPH[Drill Problems].

    This is to improve your fluency ($!=$ speed) and accuracy. Write down solution process clearly.

  + Solve other #EMPH[Problems].

    This is to have better conceptual understanding, but also to develop your writing skills.
    Write down the solution process clearly _as an English text_, taking care of _logical completeness_.

  Optionally, you you are encouraged to prepare a reference book, so that you can consult it when you want to know more.
  Sho supposes [Boas] listed below is the best option.
]


#pagebreak()

= References

This document is written under the influence of the following references.

- #link("https://haltasaki.github.io/books/math/")[The Math Book by Hal Tasaki] (#JA[数学：物理を学び楽しむために], in Japanese)

  #tab[A free book with full description, but unfortunately in Japanese.  Topic selections and the depth of descriptions are based on this reference.]

- #link("https://lecture.ecc.u-tokyo.ac.jp/gocho/")[First-Year Math Practice] (in Japanese)

  #tab[This document is grounded in a "learn steadily" approach ("#JA[じっくり]" in Japanese), which originates from Prof. Gocho and Prof. Kiyono, who were instructors of Sho in his freshman.
    Problems and rigorous math descriptions are taken from their works.]

- #text-sf[*[Boas]*] Mary L. Boas, _Mathematical Methods in the Physical Sciences_, 3rd ed., Wiley, 2006.
- #text-sf[*[AWH]*] George B. Arfken, Hans J. Weber, and Frank E. Harris,\ #h(4em) _Mathematical Methods for Physicists_, 7th ed., Academic Press, 2023.

  #tab[
    These two books are widely used in physics departments around the world.
    [Boas] seems more friendly to beginners, while [AWH] seems more detailed and complete.
    Sho recommends you to study [Boas] _in parallel with_ this document, using it as a reference, and to consult [AWH] when you want more details or more exercises.
  ]


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

#TODO[a bit on (abstract) vector space to prep for QM?]

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
  + `9` Write the following letters so that people can distinguish each from others.
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

== SI Units

Historically, different civilizations used different units.
Today, science and engineering worldwide use the #keyword[SI units] (Système International d'Unités)---the single international standard.
It is built from seven #keyword[SI base units]:

#figure(
  caption: [SI base units and their symbols for dimension @si. Recall that units are case-sensitive.],
  table(
    columns: (auto, auto, auto, auto),
    align: (left, center, left, center),
    stroke: none,
    table.header([*quantity*], table.cell(colspan: 2, align: center)[*symbol and name*], [*symbol for dimension*]),
    table.hline(),
    [time], [s], [ (second)], ds("T"),
    [length], [m], [(meter)], ds("L"),
    [mass], [kg], [(kilogram)], ds("M"),
    [electric current], [A], [(ampere)], ds("I"),
    [temperature], [K], [(kelvin)], ds("Θ"),
    [amount of substance], [mol], [(mole)], ds("N"),
    [luminous intensity], [cd], [(candela)], ds("J"),
  ),
)<SI-units>

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

#bibliography("refs.yml")
