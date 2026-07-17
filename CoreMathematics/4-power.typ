#import "misho-text.typ": *
#import "physica.typ": *

You have learned powers, exponential functions, and logarithmic functions in highschool, and their derivatives in your university first semester.
Here, we will have a quick review on them.

#remark[
  We go back to mathematics, so we should avoid decimals but use fractions. For example, answer $8\/5$ instead of $1.6$.
]

= Powers

Let's begin with reviewing the powers.

#quizzes[
  + `4` Calculate without a calculator. Can you solve them all...?
    #show sym.comma: "," + math.quad
    #h-enum(cols: 1, label-align: horizon)[
      + $2^4, 3^5, 4^2, 10^3, 1^25, 2^10$
      + $5^0, 3^0, 2^0, 1^0$
      + $2^(-1), 12^(-1), 3^(-3), 2^(-4), 5^(-2), 2^(-10)$
      + #[
          #show math.frac: it => math.display(it)
          #box(inset: (y: .5em))[
            $(1/2)^(-1), (1/3)^(-2), (1/12)^(-1), (1/5)^(-2),(1/2)^(-10), (1/3)^(0), (1/10)^(0)$
          ]]
      + #[
          #show math.frac: it => math.display(it)
          #box(inset: (y: .5em))[
            $(1/2)^4, (2/3)^(3), (5/2)^(2), (2/5)^(-2), (7/2)^2, (7/2)^(-2), (1/4)^(3)$
          ]]
      + #[
          #show math.frac: it => math.display(it)
          #box(inset: (y: .5em))[
            $4^(1\/2), 81^(1\/2), 3^(1\/2), 27^(1\/3), (1/4)^(1\/2), (1/7)^(1\/2), (8/9)^(1\/2), (15/3)^(1\/2)$
          ]]
      + #[
          #show math.frac: it => math.display(it)
          #box(inset: (y: .5em))[
            $4^(-1\/2), 81^(-1\/2), 3^(3\/2), 27^(2\/3), 27^(-2\/3), (1/4)^(3\/2), (1/7)^(-1\/2), (1/2)^(-5\/2)$
          ]]
    ]
  + `4` Choose ALL correct formulae from the list below. Here $A > 0$, $B > 0$, and $x, y$ are real numbers.
    #h-enum(cols: 2)[
      + $A^x dot A^y = A^(x+y)$
      + $A^x + A^y = A^(x+y)$
      + $(A^x)^y = A^(x y)$
      + $(A dot B)^x = A^x dot B^x$
      + $(A + B)^x = A^x + B^x$
      + $A^x / A^y = A^(x-y)$
      + $A^x / B^x = (A/B)^x$
      + $A^x / B^x = (A/B)^(x^2)$
      + $sqrt(A + B) = sqrt(A) + sqrt(B)$
      + $sqrt(A dot B) = sqrt(A) dot sqrt(B)$
      + $(A^x)^y = A^(x+y)$
      + $A^0 = 0$
      + $A^0 = 1$
      + $0^0 = 1$
      + $A^1 = A$
      + $A^(-1) = -A$
      + $A^(-1) = 1\/A$
      + $A^(1\/2) = sqrt(A)$
      + $A^(1\/3) = root(3, A)$
      + $(A\/B)^(-1) = B\/A$
    ]
]

#remark[
  How did you do?
  If you found Quiz 1 or 2 difficult, you should review powers and exponentials in your high-school textbook before continuing.
  This chapter will not re-teach that material from scratch---it is a quick workout to sharpen what you already know.
]

#pagebreak()

= The Exponential Function

#quizzes[
  + `4` Without a calculator, decide which is larger in each pair.
    #h-enum(cols: 3)[
      + $2^10$ or $10^3$
      + $3^4$ or $4^3$
      + $(0.9)^100$ or $(0.99)^(1000)$
    ]

  + `4` The graph of $f(x) = a^x$ passes through $(0, 1)$ for any $a > 0$.
    For each base below, decide whether $f$ is increasing or decreasing, and sketch a rough graph.
    #h-enum(cols: 3)[
      + $a = 2$
      + $a = 1\/2$
      + $a = 1$
    ]

  + `4` Match each equation with its graph. (Sketch or describe the key features.)
    #h-enum(cols: 2)[
      + $y = 2^x$
      + $y = 2^(-x)$
      + $y = -2^x$
      + $y = 2^x - 1$
    ]
]

#be-careful[
  $a^x$ is only defined for all real $x$ when $a > 0$.
  Never write $(-2)^x$ for a general real number $x$.
]


== The special base $e$ <natural-base>

The number $e approx 2.718...$ is defined by
$
  e = lim_(n -> oo) (1 + 1/n)^n.
$
Its key property---which you should already know from Calculus I---is
$
  dv(x) e^x = e^x.
$ <deriv-ex>

#quizzes[
  + `4` Differentiate. Write the answer in simplest form.
    #h-enum(cols: 4)[
      + $e^(5x)$
      + $e^(-x)$
      + $3e^(2x)$
      + $e^(x^2)$
      + $e^(sin x)$
      + $x e^x$
      + $e^x \/ (e^x + 1)$
      + $e^(-t\/tau)$ (treat $tau$ as a constant)
    ]

  + `3` Let $f(x) = e^(a x)$ where $a$ is a real constant. Show that $f'(x) = a f(x)$.
    What does this say about the sign of $f'$?
]

#remark[
  In physics you will constantly see $e^(-t\/tau)$ (exponential decay) and $e^(i omega t)$ (oscillation in complex form).
  Being fluent with $dv(t) e^(-t\/tau) = -1\/tau dot e^(-t\/tau)$ will save you a lot of effort.
]

#pagebreak()

= Logarithms

#quizzes[
  + `4` Calculate without a calculator.
    #h-enum(cols: 4)[
      + $log_2 8$
      + $log_2 (1\/4)$
      + $log_3 81$
      + $log_(10) 0.001$
      + $log_5 1$
      + $log_a a^7$
      + $ln e^3$
      + $e^(ln 5)$
      + $log_4 2$
      + $log_9 3$
      + $log_(1\/2) 8$
      + $log_4 8$
    ]

  + `4` Choose ALL correct formulae. Here $A > 0$, $B > 0$, $a > 0$, $a != 1$.
    #h-enum(cols: 2)[
      + $log_a (A B) = log_a A + log_a B$
      + $log_a (A + B) = log_a A + log_a B$
      + $log_a (A\/B) = log_a A - log_a B$
      + $log_a (A^r) = r log_a A$
      + $log_a (r A) = r log_a A$
      + $log_a A + log_a B = log_a (A B)$
      + $log_a A - log_a B = log_a (A\/B)$
      + $log_a 0 = 1$
      + $log_a 1 = 0$
      + $log_a a = 1$
      + $(log_a A)(log_a B) = log_a (A B)$
      + $a^(log_a A) = A$
      + $log_a (a^x) = x$
      + $log_a A = (ln A)\/(ln a)$
    ]
]

#remark[
  If you are unsure why $log_a x$ and $a^x$ are inverses of each other, or why the log rules hold, go back to your high-school textbook.
  The exercises here assume you can use the rules fluently.
]

#be-careful[
  $log_a x$ is only defined for $x > 0$.
  There is no real number $log_a 0$ or $log_a (-3)$.
  Always check the domain when solving logarithmic equations.
]


== Natural logarithm

The #keyword[natural logarithm] $ln x := log_e x$ is the inverse of $e^x$:
$
  ln(e^x) = x quad forall x in RR, quad quad e^(ln x) = x quad forall x > 0.
$

Its derivative---which you know from Calculus I---is
$
  dv(x)(ln x) = 1\/x quad (x > 0).
$ <deriv-ln>

#quizzes[
  + `4` Differentiate.
    #h-enum(cols: 4)[
      + $ln(3x)$
      + $ln(x^2 + 1)$
      + $ln(sin x)$
      + $x ln x$
      + $(ln x)^2$
      + $ln(1\/x)$
      + $e^x ln x$
      + $ln|2x - 1|$
    ]

  + `4` Simplify each expression to a single number or a single logarithm.
    #h-enum(cols: 2)[
      + $ln e^5$
      + $e^(3 ln 2)$
      + $ln 6 + ln(1\/6)$
      + $2 ln 3 - ln 9$
      + $ln 12 - ln 4 + ln 2$
      + $e^(ln 3 + ln 4)$
    ]
]

#pagebreak()

= Exponential and Logarithmic Equations

#quizzes[
  + `4` Solve for $x$. Give exact answers.
    #h-enum(cols: 3)[
      + $2^x = 32$
      + $3^x = 1\/27$
      + $e^x = 5$
      + $e^(-2x) = 7$
      + $2^(x-1) = 16$
      + $10^(2x+1) = 1000$
      + $ln x = 4$
      + $ln(x - 1) = 0$
      + $log_3(2x + 1) = 3$
    ]

  + `4` Solve for $x$ and check for extraneous solutions.
    #h-enum(cols: 2)[
      + $ln x + ln(x - 1) = ln 6$
      + $log_2 x + log_2(x + 2) = 3$
      + $e^(2x) - 3e^x + 2 = 0$
      + $ln(x+1) - ln(x-1) = ln 3$
    ]
]

#be-careful[
  When combining logarithms (e.g., $ln a + ln b = ln(a b)$) and then solving, the combined equation may have solutions that make one of the original $ln$ terms undefined.
  Always substitute back and check.
]

#pagebreak()

= Exponential Growth and Decay <exp-physics>

Many physical quantities satisfy $dv(Q, t) = k Q$ for some constant $k$.
The solution is always $Q(t) = Q_0 e^(k t)$, where $Q_0 = Q(0)$.

- $k > 0$: #keyword[exponential growth] (population, compound interest)
- $k < 0$: #keyword[exponential decay] (radioactivity, RC discharge, cooling)

#quizzes[
  + `4` A quantity obeys $N(t) = N_0 e^(-lambda t)$ with $lambda > 0$.
    + Show that the #keyword[half-life] is $T_(1\/2) = (ln 2)\/lambda$.
    + If $T_(1\/2) = 10$ days, find $lambda$.
    + What fraction of $N_0$ remains after $3 T_(1\/2)$?

  + `4` An RC circuit has charge $Q(t) = Q_0 e^(-t\/tau)$ where $tau = R C$.
    + Verify that $Q(tau) = Q_0\/e$.
    + If $R = 2.0 unit("k" Omega)$ and $C = 50 unit(mu "F")$, find $tau$ in seconds.
    + At what time $t$ has $Q$ dropped to $10%$ of $Q_0$?

  + `3` Sound intensity in decibels: $L = 10 log_(10)(I\/I_0)$.
    + If intensity doubles, by how many dB does $L$ increase?
    + Two sounds have $L_1 = 60 unit("dB")$ and $L_2 = 90 unit("dB")$. Find $I_2\/I_1$.
]

#pagebreak()

#problems[
  + `9` Calculate without a calculator.
    #h-enum(cols: 4)[
      + $2^8$
      + $3^(-3)$
      + $16^(3\/4)$
      + $8^(-2\/3)$
      + $log_2 32$
      + $log_(10) 0.01$
      + $ln e^3$
      + $e^(ln 5)$
      + $log_3(1\/27)$
      + $log_4 8$
      + $log_(1\/2) 4$
      + $log_6 6^(10)$
    ]

  + `9` Differentiate.
    #h-enum(cols: 4)[
      + $e^(4x)$
      + $e^(-x^2)$
      + $ln(2x)$
      + $ln(x^2 + x)$
      + $x^2 e^x$
      + $e^x\/(1 + e^x)$
      + $ln(cos x)$
      + $sqrt(e^x + 1)$
    ]

  + `3` Solve each equation.
    #h-enum(cols: 3)[
      + $2^(x+1) = 64$
      + $e^(3x-1) = 4$
      + $log_5(2x + 3) = 2$
      + $ln(x^2 - 3) = ln(2x)$
      + $e^(2x) - 3e^x + 2 = 0$
      + $log_2 x - log_2(x-2) = 3$
    ]

  + `3` A population grows as $P(t) = P_0 e^(r t)$.
    + Show the #keyword[doubling time] is $T = (ln 2)\/r$.
    + If a population doubles in 20 years, find $r$.
    + Starting from $P_0 = 1000$, find $P$ after 60 years.

  + `3` Prove: $log_a x = (log_b x)\/(log_b a)$ for any valid base $b$ (change of base formula).

  + `2` Let $f(x) = a^x$. Using the fact that $a^x = e^(x ln a)$, prove that $dv(x)(a^x) = a^x ln a$.

  + `2` Differentiate $y = x^x$ for $x > 0$ using #keyword[logarithmic differentiation]:
    write $ln y = x ln x$, differentiate both sides with respect to $x$, then solve for $y'$.

  + `1` Define $cosh x = (e^x + e^(-x))\/2$ and $sinh x = (e^x - e^(-x))\/2$.
    + Show $dv(x)(cosh x) = sinh x$ and $dv(x)(sinh x) = cosh x$.
    + Show $cosh^2 x - sinh^2 x = 1$.
    + Show $cosh x >= 1$ for all $x$.
]

