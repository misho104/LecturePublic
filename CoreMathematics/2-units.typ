#import "misho-text.typ": *
#import "physica.typ": *

#let bare(body) = {
  show math.frac: it => [#it.num #sym.slash #it.denom]
  show sym.ast: h(0.05em) + sym.dot.op + h(.05em)
  $upright(#body)$
}
#let bare(body) = $#h(-0.1667em)unit(body)$

#let meter = unit("m")
#let cm = unit("cm")
#let second = unit("s")
#let mm = unit("mm")
#let kg = unit("kg")
#let mps = unit($m/s$)
#let mpss = unit($m/s^2$)
#let ampere = unit("A")
#let coulomb = unit("C")
#let ds(body) = $sans(upright(body))$
#let DIM = math.op("dim")

#let writings(shift: dim.tab, columns: none, box: (true,), align: (left, right), ..body) = {
  tab(shift: shift - 0.55em, grid(
    columns: if columns == none { box.len() } else { columns },
    inset: 0.55em,
    stroke: box.map(it => if it { (thickness: 0.5pt, dash: "dashed") } else { none }),
    align: align,
    ..body
  ))
}
#let writing(body) = {
  (
    h(0.3em)
      + box(
        inset: (x: 0.3em, y: 0.45em),
        height: 1.6em,
        stroke: (thickness: 0.5pt, dash: "dashed"),
        body,
      )
      + h(0.3em)
  )
}

A #keyword[physical quantity] is usually not just a number, but also has a #keyword[unit] and an #keyword[uncertainty] (error).
For example, "$(72 ± 2)kg$" has a number "72" and a unit "kg", which compose the #keyword[central value] "$72kg$".
It also has uncertainty because every measurement has an uncertainty.
In experimental physics, uncertainty is usually more important than the central value, and thus uncertainty handling is a fundamental skill of physicists.

In this chapter, we first review physical quantities and how to handle units. Then, we discuss #keyword[significant figures], a simple and convenient method to express the uncertainty.
Further discussions on uncertainty analysis are given in Chapter #TODO[chapter].

= Physical quantity

The expression "$(72 ± 2)kg$" means the central value is $72kg$ and the #keyword[absolute uncertainty] is $2kg$.
Accordingly, its #keyword[relative uncertainty] is given by $(2kg)\/(72kg)=0.028$.
Let's see other examples.

#align(center, table(
  columns: (auto, auto, auto, auto, auto),
  align: (left, center, center, center, center),
  stroke: (x, y) => (x: none, bottom: (if y == 0 or y == 4 { 1pt } else { 0.5pt })),
  table.header([], [unit], [central value], [absolute uncertainty], [relative uncertainty]),
  [$10meter ± 1cm$], [m (meter)], $10meter$, $1cm = 0.01meter$, [0.001 (or 0.1%)],
  [$1.6 ampere ± 0.04 ampere$], [A (ampere)], $1.6 ampere$, $0.04ampere$, [0.025 (or 2.5%)],
  [$(5±1)#EE(-3) coulomb$], [C (coulomb)], $0.005 coulomb$, $0.001 coulomb$, [0.2 (or 20%)],
  [$(50±1)mps$], [m/s], $50 mps$, $1 mps$, [0.02 (or 2%)],
))
#index("uncertainty")
#index("uncertainty", "absolute")
#index("uncertainty", "relative")
#index-see("error", "uncertainty")

#remark[
  Upper- and lowercase letters are distinguished. "M" *does not* mean "meter". The unit "A" is "ampere", not "Ampere". The unit "coulomb" is "C", not "c".
]

#quizzes[
  + For each of the following values, find its unit, central value, absolute uncertainty, and relative uncertainty.
    #h-enum(cols: 2)[
      + $50kg ± 500 unit(g)$
      + $(0.05 ± 0.001) ampere$
      + $(1.6 ± 0.001)EE(-19) coulomb$
      + $72unit("km/h") ± 1 mps$
    ]

  + The next passage has six (6) errors in the use of uppercase and lowercase letters. Find them out.


    In the SI system, temperature is expressed in k (kelvin), a unit named after Lord Kelvin.
    The unit of force is N (newton), named after the british scientist Isaac newton. The units A (Ampere) and c (coulomb) are named after French scientists.
    In contrast, Kg (kilogram) is not named after a person.
    , but comes from Greek.
]

As an undergraduate student, you need to follow the following rules:
#theorem(type: "Statement", title: "Rules for Physical Quantities: Basic")[
  + Numbers are always with units, even in calculations.
  + Include units in a symbol.
  + For physical quantities, use decimals (e.g., $1.6ampere)$. Do not use fractions like $(8\/5)ampere$.
  + Use significant figures to express the measurement precision.
]



= Units
When we educate kids, we write "my height is #blank()#cm", or "my height is $h$#cm", where $h=172$ is just a number.
But this is not nice! We want to convert the units freely and write equations such as
$1.72#meter = 172#cm = 0.00172unit("km")$.
So,
*we always include units in symbols* #writing($h=172 cm$). Then
#writings(
  box: (false, true),
  [we can write:],
  $h=172#cm=1.72#meter=0.00172 unit("km")=1.82EE(-16) unit("light-year").$,
)

Similarly, if $m=110 unit(g)$ and $g=9.8 mpss$,
#writings(
  box: (false, true),
  align: (right, left),

  [we may write:],
  $w = m g = 110 unit(g) times 9.8 mpss = 1.1 unit("kg"*m/s^2)$,
  [but not:],
  $#RED[$w = m g = 0.11 times 9.8 = 1.1 unit("kg"*m/s^2)$]$,
)
This second equation is incorrect because $m$ is not equal to $0.11$; $m$ is equal to $0.11kg$ or $110 unit(g)$.


#remark[
  Usually, physicists use upright fonts for units and #text(style: "italic")[italic fonts] for quantities. For example, $m$, $T$, and $C$ are quantities, which can be mass, temperature, capacitance, etc. Meanwhile, m, T, and C are units: meter, tesla, and coulomb, respectively.
]

#quizzes[
  +
    + If $m r omega^2 = 10.0 unit("kg"*m/s^2)$, $m=5.0kg$, and $r=1.0 meter$, what is $omega$?
    + If $v_0t + 1/2a t^2=5.0meter$, where $a=-4.0mpss$ and $v_0=7.0 mps$, what is  $t$?
    + At time $t=0$, a particle is at $(x,y)=(2.0meter,0)$. It moves with a constant velocity $(v_x,v_y)=(3.0,4.0) mps$. What is its position at $t=1.0 second$?
]

#make-indent
Every physical concept has its own unit. For example, speed has $bare(m/s)$, acceleration has $bare(m/s^2)$, and energy has $bare("kg"*m/s^2)=bare(N*m)=bare(J)$.
The table below lists the quantities you have learned.
Notice that angle (rad) has no dimension. It is called a #keyword[dimensionless] quantity.
<quiz:for-logic>

#align(center, table(
  columns: (auto, auto, auto, auto),
  align: (left, center, center, left),
  stroke: none,
  table.header([*concept*], [*dimension*], [*typical unit*]),
  table.hline(),
  [speed], $ds(L thin T^(-1))$, $bare(m/s)$, [],
  [acceleration], $ds(L thin T)^(-2)$, $bare(m/s^2)$, [],
  [linear momentum], $ds(M thin L thin T^(-1))$, $bare("kg"*m/s)$, [],
  [force], $ds(M thin L thin T^(-2))$, $bare("kg"*m/s^2)$, $(= upright("N"))$,
  [energy / work], $ds(M thin L^2 thin T^(-2))$, $bare("kg"*m^2/s^2)$, $(= bare(J))$,
  [frequency], $ds(T)^(-1)$, $bare(1/s)$, $(=bare("Hz"))$,
  [angle], [$1$ (dimensionless)], $bare("rad")$, [],
))


#advanced-note[
  To understand why angle has no dimension, you may consider the definition of the radian: it is defined as the ratio of the arc length to the radius, so the units cancel ($"meter" \/ "meter" = 1$).
]

Here, please do not write: #writing[#RED[The force is $bare("kg"*m^2/s^2)$. This is also called newton (N).]],
because _we cannot mix units and concepts_. A correct (and easy) way is to use English words:
#writings(
  box: (true, false, true),
  [the unit of the force is $bare("kg"*m/s^2)$],
  [or],
  [the force has the unit $bare("kg"*m/s^2)$.],
)
Similarly, the following statement is incorrect because it mixes concepts and units:
#writings[#RED[Since $m=bare("kg")$ and $g=bare(m/s^2)$, $m g = bare("kg"*m/s^2) = bare(N)$.]]
Instead, you need to write
#writings[Since $m$ has a unit of $bare("kg")$ and $g$ has a unit of $bare(m/s^2)$, $m g$ has a unit of $bare("kg"*m/s^2)=bare(N)$.]

Notice the last equation: units can be equal to other units, so we may write
#writing($bare(N) = bare(J/m) = bare("kg"*m/s^2)$)
#writing($bare(m)=bare(J/N)$)
#writing($bare(s)=sqrt(bare("kg"*m/N))$).
These are scientifically correct equations.
#remark[
  We sometimes use informal notations, such as #writing[$[F]=bare(N)$] or #writing($F ⤳ bare(N)$) to express "the unit of $F$ is $bare(N)$ (newton)". Still, using an equal symbol (=) is *not allowed*. Namely, #writing[#RED($F=bare(N)$)] is always incorrect.
]

#quizzes[
  + What are the units of the following concepts? Write English sentences to explain it.
    #h-enum(cols: 5)[
      + speed
      + velocity
      + force
      + energy
      + power
    ]
]

#advanced-note[
  In very formal situations, we use #keyword[symbols for dimensions] (see @SI-units on #ref(<SI-units>, form: "page")):
  #tab[Since $DIM(m)= ds(M)$ and $DIM(g) = ds(L med T^(-2))$, $DIM (m g) = ds(M med L med T^(-2))$,]
  with the operator "dim" @si. However, it seems too complicated for most situations.
]

#problems[
  + `4` Express the following units only with SI base units, e.g., $bare(N) = bare("kg"*m/s^2)$.
    #h-enum(cols: 4)[
      + W (watt)
      + Pa (pascal)
      + J (joule)
      + C (coulomb)
    ]
  + `3` Find a few more examples of dimensionless quantities in physics.
  + `2` Use "dim" notation to express the dimensions of the following quantities. For example, if $v$ is speed, then $DIM(v) = ds(L thin T^(-1))$.
    #h-enum(cols: 2)[
      + speed $v$
      + force $F$
      + angular momentum $L$
      + electric charge $Q$
      + resistance $R$
      + specific heat capacity $c$
      + Planck constant $h$
      + fine-structure constant $alpha$
    ]
]

= Significant figures <sig-figs>

In researches, we need to treat uncertainties in the method given in #TODO[chap].
However, most of lectures use #keyword[significant figures] to express the accuracy of a value, so that students becomes familiar with the concept of uncertainties.
For example,

#let unc(x) = text-sf(style: "oblique", weight: "bold", fill: c.blue, x)
#let sig(tail: 1, e: none, x) = {
  (
    x.slice(0, -tail) + unc(x.slice(-tail)) + (if e != none { EE(e) } else { "" })
  )
}

#writings(
  box: (true, false),
  align: (left, left),
  [3.14],
  [means the last digit "4" is uncertain. It can be #sig("3.16"), #sig("3.15"), #sig("3.11"), #sig("3.10"), ....],
  [3.141],
  [means "3.14" is for sure but it can be #sig("3.143"), #sig("3.142"), #sig("3.140"), #sig(tail: 2, "3.139"), ....],
  [3.1415],
  [might be #sig("3.1416"), #sig("3.14153"), etc., but the writer is sure _it is not_ 3.145 or 3.135.],
)
We write the "uncertain digit" in #unc[a different style] for clarity. You should notice the difference between:
#writings(
  box: (true, false),
  align: (left, left),
  [#sig("1.0000")],
  [meaning the last digit "0" is uncertain so it may be 1.0002, 1.0001, 0.9998, ....],
  [#sig("1.00")],
  [meaning it can be 1.03 or 0.99, but the writer is sure _it is not_ 1.2 or 0.8.],
)
It is usually convenient to use #keyword[scientific notation]:
#writings(
  box: (true, false, true, false),
  align: (left, left),
  [#sig("0.000123")],
  [is OK but we prefer],
  [#sig("1.23", e: -4).],
  [Both mean the value can be #sig("1.22", e: -4) etc.],
  [#sig("0.00100")],
  [is OK but we prefer],
  [#sig("1.00", e: -3).],
  [],
  [#sig("29979")],
  [is OK but we prefer ],
  [#sig("2.9979", e: 4).],
)
#fail-safe[$10^3=1000$ and $10^(-3)=1\/10^3=1 div 1000$. Go to #TODO[chap] for details!]
We need to _avoid ambiguous notations_. Namely,
#writings(
  box: (true, false),
  align: (right, left),
  RED[2040],
  [is ambiguous and not nice. We are not sure the author means $2.04EE(3)$ or $2.040EE(3)$.],
  RED[120],
  [is not nice. We are not sure the author means It may mean $1.20EE(2)$ or $1.2EE(2)$.],
  RED[42000],
  [is not nice because it has four ways to interpret the author's intention.],
)
#quizzes[
  + What are the four interpretations of 42000?  Write them in scientific notation.
]
#make-indent
We use #keyword[rounding]-to-the-nearest (#ZH[四捨五入]) when necessary. For example, if you need to convert to three significant figures, it will be
#no-num(
  $
    1.234 → 1.23, quad 1.235 → 1.24, quad 31.98 → 32.0, quad 1234 → 1.23EE(3), quad "and so on."
  $,
)
#quizzes[
  + Round the following numbers to three significant figures.
    #h-enum(cols: 4)[
      + $41.11$
      + $98.76$
      + $100.12$
      + $15.449$
      + $2.2360$
      + $0.0123456$
      + $9876$
      + $9.999EE(4)$
    ]
]
#remark[
  Programmers use `2.99e8` (or `2.99E8`) to mean $2.99EE(8)$, or `1.6e-12` (or `1.6E-12`) to mean $1.6EE(-12)$. However, we *should not* use them in handwriting.
]

#problems[
  + `9` Write the following numbers in scientific notation. However, some of them are ambiguous, so answer "ambiguous" if so.
    #grid(columns: 10, column-gutter: 1em)[152][340][1000][9999][43210][0.0300][0.00213][31.0][31.00][31]

  + `9` The expressions 0.123, 1.23, and 123 are numbers with _*three* significant figures_. Similarly, 1234 and $1.234EE(-3)$ are numbers with _*four* significant figures_. How about the following expressions?
    #h-enum(cols: 4)[
      + $3.14$
      + $0.11$
      + $1.1EE(-2)$
      + $1.1EE(1)$
      + $1.0008$
      + $1.0020$
      + $1.0000$
      + $4.00EE(-10)$
      + 0.0008
      + 0.00080
      + 12345
      + 67890
    ]

]

#pagebreak()

= Calculation with Significant figures

We need to do calculations of numbers with uncertainties, such as $1.23+4.56$ or $1.23\/4.56$, but how?
Here we discuss a simple method for

- addition ($x+y$) and subtraction ($x - y$)

- multiplication ($x times y$) and division ($x div y$ or $x\/y$)

Other calculations, such as $sqrt(x)$, $ee^(x)$ or $sin(x)$, need the professional method given in #TODO[chap].

=== Multiplication and Division

As a rule, if $x$ has $m$ significant figures and $y$ has $n$ significant figures, then $x times m$ or $x div y$ should be rounded to have $min(m, n)$ significant figures. ...But the rule is tough to understand. Probably you should see the example, and learn through practice.

#example()[ Calculate the following expressions, using calculators.
  #h-enum(cols: 4)[
    + $8.912 times 2.4$
    + $5.0 div 3.14$
    + $2.01 times 49.8$
    + $1.210^3$
  ]
]
#solution[
  Here we use a shorthand notation "3-SF" to mean "three significant figures".
  #enum(numbering: enum-style("(1)"), tight: true)[
    Since 8.912 has 4-SF and 2.4 has 2-SF, we round the result to (the smaller) 2-SF:
    #no-num($8.912 times 2.4 = 21.3888 → underline(21).$)][
    Since 5.0 has 2-SF and 3.14 has 3-SF, we round the result to 2-SF:
    #no-num($5.0 div 3.14 = 1.592dots → underline(1.6).$)][
    Both 2.01 and 49.8 have 3-SF, so we keep 3-SF, but don't forget to avoid ambiguity!
    #no-num($2.01 times 49.8 = 100.098 → 100 → underline(1.00EE(2)).$)][
    $1.210^3=1.210 times 1.210 times 1.210$, so we round the result to 4-SF:
    #no-num($1.210^3 = 1.771561 → underline(1.772).$)]
]

If you want, we can justify this treatment by carrying out a hand calculation of the long multiplication.

#let v-calc(columns, text) = table(
  columns: columns,
  align: center,
  stroke: none,
  column-gutter: 0em,
  inset: (x: 0.3em, y: 0.2em),
  ..(
    text
      .replace("x", sym.times)
      .replace("-", sym.minus)
      .split("/")
      .map(it => if (it == "L") { table.hline(stroke: 0.5pt) } else if it.len() > 0 and it.at(0) == "!" {
        unc(it.slice(1))
      } else {
        it
      })
  )
)
#grid(
  align: center,
  columns: (1fr, 1fr, 1fr),
  v-calc(5, "//1./2/!0/x//1./3/!1/L///!1/!2/!0//3/6/!0//1/2/!0///L/1/5/!7/!2/!0"),
  v-calc(6, "//8./9/1/!2/x////2./!4/L//!3/!5/!6/!4/!8/1/7/8/2/!4//L/2/!1/!3/!8/!8/!8"),
  v-calc(6, "///2./0/!1/x///4/9./!8/L///!1/!6/!0/!8//1/8/0/!9///8/0/!4///L/1/0/!0./!0/!9/!8"),
)
Observe which digits are uncertain, and how they "pollute" the results in each step.
In $#sig("1.20") times #sig("1.31")$, the last #sig("1") pollutes the part of $#sig("1")+6$ and we get an uncertain number #sig("7").
So, the result is #sig("1.57").

=== Addition and subtraction

Different rules are applied for addition and subtraction.
You can understand the rules easily if you do long addition and observe which digits are polluted.

#example[
  Calculate the following expressions.
  #h-enum(cols: (1fr, 1fr, 1fr, 1.5fr))[
    + $12.3 + 4.56$
    + $123 + 4.56$
    + $0.50 - 0.032$
    + $1.20EE(3) - 27$
  ]
]
#solution[
  #grid(
    align: center,
    columns: (1fr, 1fr, 1fr, 1fr),
    v-calc(5, "/1/2./!3//+//4./5/!6/L//1/6./!8/!6"),
    v-calc(6, "/1/2/!3///+///4./5/!6/L//1/2/!7./!5/!6"),
    v-calc(5, "/0./5/!0//-/0./0/3/!2/L//0./4/!6/!8"),
    v-calc(5, "/1/2/!0/!0/-///2/!7/L//1/1/!7/!3"),
  )
  and we round the results. So, the answers are #sig("16.9"), #sig("128"), #sig("0.47"), and #sig("1.17", e: 3).
]


#problems[
  + `9` Calculate the following, taking care of significant figures. You may use calculators.
    #h-enum(cols: (1fr, 1fr, 1fr, 1.5fr))[
      + $1.23 times 4.5$
      + $1.50 times 2.0$
      + $2.00 times 5.00$
      + $4.0 times 2.5$
      + $1.23 + 4.5$
      + $1.50 + 2.0$
      + $2.00 + 8.00$
      + $100.0 + 0.123$
      + $1.23 div 4.5$
      + $6.0 div 3.00$
      + $9.00 div 4.5$
      + $1.50 div 3.0$
      + $1.23-4.5$
      + $3.10-0.10$
      + $3.10 - 0.1$
      + $3.10 - 3.0$
      + $131 + 69$
      + $131 + 6.9$
      + $131 + 0.69$
      + $1.3EE(2) + 69$
    ]#v(-.2em)
    #h-enum(cols: (2fr, 2.5fr), label-start: 21)[
      + $\(1.2EE(5)\) times 9.4$
      + $1.2 div \(5.2EE(5)\)$
      + $\(3.33EE(5)\) times \(6.3EE(4)\)$
      + $\(3.33EE(5)\) times \(6.3EE(-4)\)$
      + $\(3.33EE(5)\) div \(6.3EE(4)\)$
      + $\(3.33EE(5)\) div \(6.3EE(-4)\)$
      + $1.00EE(4) + 2.5EE(3)$
      + $3.00EE(3) - 4.50EE(2)$
      + $2.99EE(2) + 0.814$
      + $1.23EE(-4) + 4.5EE(-6)$
    ]
  + `2` Calculate the following, taking care of significant figures. You may use calculators.
    #h-enum(cols: (1.7fr, 1.7fr, 1fr, 1fr))[
      + $1.50 times 2.000 times 3.50$
      + $8.00 div 4.00 div 0.25$
      + $5.0^3$
      + $2.10^3$
      + $1.0+2.0+3.0 times 4.0$
      + $17 - 8.0 - 3.0$
      + $3.0^3 + 1.2$
      + $5.0^3 - 5$
    ]#v(-.2em)
    #h-enum(cols: (1.7fr, 1.7fr, 2fr), label-start: 9)[
      + $(1.2 + 3.45) times 2.1$
      + $(8.0 - 1.25) div 2.0$
      + $1.2 times 3.4 + 5.6$
      + $18.0 - 2.5 times 1.2$
      + $1.20 times 3.40 + 5.60$
      + $(5.0EE(2) + 3.4) times 1.2$
    ]
  + `9` Calculate the following with calculators, taking care of significant figures and units.
    #h-enum(cols: 2)[
      + $3.1 mps times 1.0 unit("hour")$
      + $3.1meter div 25cm$
      + $1.5 unit("kg") times 9.8 unit(m/s^2)$
      + $1.50 unit("km") + 195 meter$
      + $(5.2 unit("kg/"m^3)) times (4.0 unit(mu m))^3$
      + $(5.2 unit("kg/"m^3)) times (4.0 unit(mu m)^3)$
      + $1.2unit(mu m) div 2.00 unit("nm")$
      + $(1.7EE(-27)unit("kg")) times (3.00EE(8) mps)^2$
      + $2.000 unit("kg") times (3.0 unit(m/s^2))$
      + $2.000 unit("kg") times (3.0 unit(m/s))^2$
      + $(1.60EE(-19)coulomb) div 2.0 unit(mu s)$
      + $(1.60EE(-19) coulomb) times 5.0unit("kV")$
      + $(6.63EE(-34) unit(J dot s)) times (3.0EE(12) unit("Hz"))$
      + $1.50 unit("MJ") div 20.0 meter$
    ]
]


#advanced-note[Uncertainties can often be determined subjectively, but central values are also without specific definitions; it is often the averaged value of the measurements, but one may assume some probabilistic distribution and use its median, mean, or mode as the central value.]
