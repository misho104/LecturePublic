#import "misho-text.typ": *
#import "physica.typ": *
#import "@preview/simple-plot:1.0.0": plot, set-plot-defaults

= Powers

Let's begin with a review: can you recall all the rules for powers...?

#quizzes[
  + Calculate without a calculator.
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
            $(1/2)^4, (2/3)^(3), (5/2)^(2), (2/5)^(-2), (7/2)^2, (7/2)^(-2), (1/3)^(2), (1/3)^(-2).$
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
  + Fill in the blanks, where $A > 0$, $B > 0$, and $x, y$ are real numbers.
    #h-enum(cols: (1fr, 1fr, 1.2fr), height: 2em, label-align: horizon)[
      + $A^3 dot A^3 = A^(med blank())$
      + $(A^3)^3= A^(med blank())$
      + $(A dot B)^4 = blank() dot blank()$
      + $A^x dot A^y = A^(med blank())$
      + $(A^x)^y = A^(med blank())$
      + $(A dot B)^x = A^x dot blank()$
      + #box(inset: (y: 0.5em), $A^(med #blank()) = 1/(A^x)$)
      + $A^x = #box(inset: 0.3em, "1")/#box(inset: 0.3em, blank())$
      + $A^x / A^y = A^(med blank())$
      + $A^0 = #blank()$
      + $A^#blank() = A$
      + $A^#blank() = sqrt(A)$
      + $A^#blank() = root(3, A)$
      + $A^x / B^x = #blank()$
      + #box(inset: (y: 0.5em), $(A/B)^(-1) = blank()$)
    ]
  + With $A>0$, $B>0$, $x in RR$, and $y in RR$, the following statements are all false. Find a counterexample for each.
    #h-enum(cols: 3, label-align: horizon)[
      + $A^x + A^y = A^(x+y)$
      + $(A+B)^x = A^x + B^x$
      + $(A dot B)^x = A dot B^x$
      + $(A^x)^y = A^((x^y))$
      + $(A^x)^y = A^(x+y)$
    ]
]
Do not worry if you cannot recall all the rules! Learn this section and come back here, and then you will be able to answer all the questions!

Let's review the definitions of #keyword[power], $a^x$. Here, $a$ is called the #keyword[base] and $x$ is called the #keyword[exponent].

#definition(title: [Power for positive base, real exponent])[
  For positive base $a >0$ and real exponent $x in RR$, we define the power $a^x$ by the following steps.

  First, consider a non-negative integer $n$. We define $a^n$ and $n$-th root $root(n, a)$, as
  - $a^0 := 1$.

  - If $n in NN^+$, then $a^n := a dot a^(n-1)$.

  - For $n in NN^+$, we define $root(n, a)$ as the *positive* solution $X$ of the following equation: $X^n = a$.\
    We write $root(2, a)$ as $sqrt(a)$.

  If $a>0$, positive solution always exists and is unique.
  So, $root(n, a)$ is "well-defined" for $a>0$. Then,

  - If $x>0$ and $x in QQ$, we can write $x = p\/q$ with $p, q in NN^+$.
    Then we define
    #no-num[$a^x = a^(p\/q) := (root(q, a))^p = (a^(1\/q))^p$]
  - If $x>0$ and $x in.not QQ$, we can consider a sequence of rational numbers $x_k in QQ$ such that $x_k -> x$.
    Then we define $a^x := lim_(k -> oo) a^(x_k)$.

  Now we have defined $a^x$ for all $x >= 0$. Finally,

  - If $x<0$, we define $a^x := 1\/(a^(|x|))$.

  and then we have defined $a^x$ for all $x in RR$, if $a>0$.
]

#example(title: [Integer-power of a positive number])[

  - $2^0 := 1$, because of the first item in the above definition.

  - The second item says $2^3:=2 times 2^2$. Using it recursively, we get $2^2 := 2 times 2^1$ and $2^1 = 2 times 2^0 = 2 times 1 = 2$. So, $2^3 = 2 times 2 times 2 = 8$.

  - Similarly, $1.1^2 = 1.1 times 1.1 = 1.21$ and $1.1^3 = 1.1 times 1.21 = 1.331$.
]
#example(title: [n-th root of a positive number])[
  The third item says $root(3, 8)$ is the positive solution of $X^3 = 8$. So, $root(3, 8) = 2$.
  Similarly, $root(2, 1.21)$ is the positive solution of $X^2 = 1.21$, so $sqrt(1.21) = 1.1$.
]
#example(title: [positive-power of a positive number])[
  To consider $a^x$ for rational but non-integer $x$, we use the fourth item of the above definition.
  #grid(
    columns: 2,
    inset: (y: 0.5em),
    align: horizon,
    [- $27^(1\/3) = (root(3, 27))^1 = 3^1 = 3$.], [- $1.21^(0.5) = 1.21^(1\/2) = sqrt(1.21) = 1.1$.],
    [- $27^(2\/3) = (root(3, 27))^2 = 3^2 = 9$.], [- $1.21^(1.5) = 1.21^(3\/2) = (sqrt(1.21))^3 = 1.1^3=1.331$.],
  )
  If $x$ is not rational, we need to use the fifth item. For example, if $x = sqrt(2)=1.4142...$, we consider a sequence
  $1$, $14\/10$, $141\/100$, $1414\/1000$, ... which converges to $sqrt(2)$. Then,

  - $2^(sqrt(2))$ is the limit of $2^1,med 2^(14\/10),med 2^(141\/100),med 2^(1414\/1000), med... --> 2^(sqrt(2)) = 2.665...$.

  - $3^(pi) = 3^(3.14159...)$ is the limit of $3^3,med 3^(31\/10),med 3^(314\/100),med 3^(3141\/1000), med... --> 3^(pi) = 31.544...$.
]
#example(title: [negative-power of a positive number])[
  For $a^x$ with $x<0$, we use the last item in the above definition.
  #no-num[
    $
      1.1^(-2) = 1 / (1.1^2) = 1 / 1.21 quad quad 1.21^(-1.5) = 1 / (1.21^(1.5)) = 1 / 1.331 quad quad 3^(-pi) = 1 / (3^(pi)) = 1 / (31.544...)
    $
  ]]
We have defined $a^x$ for $a>0$ and $x in RR$. Other cases are more complicated, such as:

- $a^x$ with $a>0$ and $x in CC$ is discussed in #TODO[chapter]; it needs a careful treatment.

- $a^x$ with $a<=0$ is more complicated and requires the discussion in #TODO[chapter]. However, if $x$ is an integer, we can safely discuss it, as follows.

#definition(title: [Power for negative base])[
  For a negative base $a < 0$, we only consider $a^x$ for integer $x$.

  - $a^0 := 1$.

  - $a^x := a dot a^(x-1)$ for positive integer $x$.

  - $a^x := 1\/a^(|x|)$ for negative integer $x$.

  We do not consider $a^x$ if $a<0$ and $x$ is not an integer.
]

#definition(title: [Power for zero base])[
  We define $0^x := 0$ for $x > 0$, and $root(n, 0) := 0$ for $n in NN^+$.  (We do not consider $0^x$ for $x <= 0$.)
]

#be-careful[
  Notice that we have not defined $sqrt(x)$ for $x<0$. Sho recommends *not* to use $root(n, x)$ for $x<0$ because it is not useful for physics; it will just make you confused.
]
#quizzes[
  + Some of the following expressions are not defined. Find all the undefined ones.
    #grid(
      columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1.4fr),
      inset: (x: 1em, y: 0.5em),
      $pi^(-3)$, $pi^(-1\/pi)$, $(-2)^0$, $(-2)^(-3)$, $(-2)^(3\/8)$, $-2^(-pi)$, $sqrt(-4)$,
      $root(3, 3.5)$, $root(3.5, 3)$, $root(-4, 3)$, $root(3, 0)$, $0^(2.5)$, $0^(-2.5)$, $0.1^(0.1)$,
    )
]
#make-indent
In the following sections, we will only consider *powers of positive base*, i.e., $a^x$ for $a>0$.

#advanced-note[
  Technically, even if $x<0$, we can define $root(n, x)$ for an odd integer $n$ and then we can define $a^x$ for $x in Q$ if $x$ can be written by $x=p\/q$ with an integer $p$ and an *odd* integer $q$.
]
#advanced-note[
  Many mathematicians define $0^0:=1$ for some technical reasons, but we do not need it.
]
#set-plot-defaults(
  width: 5,
  height: 5,
  xlabel-anchor: "north",
  ylabel-anchor: "east",
  xlabel-offset: (-0.1, -0.05),
  ylabel-offset: (-0.05, -0.1),
  origin-leader: false,
  style: (plot: (samples: 40)),
)


= Exponential functions and Logarithmic functions
#grid(columns: (auto, 40%), align: (left, right))[
  Powers with positive bases, such as $2^x$ and $0.7^x$, are considered as an #keyword[exponential function] defined for $x in RR$.
  The figure to the right shows the graphs of $y=2^x$ and $y=0.7^x$.

  Obviously, $f(x) = a^x$ is #EMPH[strictly increasing] if $a>1$; #EMPH[strictly decreasing] if $0<a<1$.
  In Section #TODO[], we will check this property by calculating $f'(x)$.
  It is also important that $a^x$ can take any positive real value. We will use these facts to define $log_a x$ below in this section.

][
  #plot(
    height: 3.5,
    xmin: -3.4,
    xmax: 3.4,
    ymin: -0.4,
    ymax: 4.5,
    show-grid: true,
    ytick: (1, 2, 3, 4),
    (fn: x => calc.pow(2.0, x), stroke: c.blue + 1.5pt, label: $y=2^x$, label-pos: 0.72),
    (fn: x => calc.pow(0.7, x), stroke: c.pink + 1.5pt, label: $y=0.7^x$, label-pos: 0.05),
  )
]
#quizzes[
  + Draw the graphs of $y=2^x$, $y=0.5^x$, and $y=1^x$ by hand, without using calculators or computers.
]

#theorem(title: [Properties of Exponential Functions])[
  For $a>0$, $b>0$, and $x, y in RR$,
  $
    a^0=1, quad 1/(a^x) = a^(-x), quad root(n, a^x) = a^(x\/n)quad(n in NN, n>=2);
  $
  $
    a^x a^y = a^(x+y), quad (a^x)/(a^y) = a^(x-y), quad (a^x)^y = a^(x y), quad (a b)^x = a^x b^x, quad (a/b)^x = (a^x)/(b^x).
  $]
#remark[
  $a^(x^y)$ is usually interpreted as $a^((x^y))$; it is in general not equal to $(a^x)^y=a^(x y)$.
]

#quizzes[
  + Transform the following numbers to the form of $2^□$.
    #h-enum(cols: 6, label-align: horizon)[
      + $2$
      + $1024$
      + $sqrt(2)$
      + $root(3, 4)$
      + $0.25$
      + $root(5, 0.25)$
      + $4^x$
      + $(sqrt(2))^x$
      + $4 dot 2^x$
      + $2^x\/16$
      + $2^x 4^y$
      + $2^x\/4^y$
    ]

  + Without a calculator, arrange the following in order from smallest to largest.
    #no-num[
      $2, quad 1024, quad 2^5, quad 8^2, quad sqrt(2), quad root(3, 4), quad 0.25, quad 0.5^0.3, quad root(5, 0.25), quad 0, quad 1$
    ]
]

#make-indent
Consider the equation $p = a^x$, where $a>0$, $a!=1$ and $p in RR$. For a given $p$, how many solutions $x$ does it have?
As $a!=1$, $a^x$ is strictly increasing or decreasing and it takes any value $0 < a^x < oo$. Therefore, $p = a^x$ has a unique real solution $x$ for any $p>0$.
We call the solution $x = log_a p$.

#definition(title: [Logarithm])[
  For $a>0$, $a!=1$, and $p>0$, we define the #keyword[logarithm] $log_a p$ as the unique solution $x$ of $a^x = p$.

  $ "For " a > 0, a!=1, "and" p>0, #h(3em) a^x = p quad <==> quad x = log_a p. $
]
Notice that $log_a p$ is not defined for $p <= 0$ or $a <= 0$ or $a=1$.
#quizzes[
  + Based only on the above discussion, explain why $k=log_a (a^k)$ and $a^(log_a k)=k$.  <quiz:exp-change-base>
]
We here review basic properties of $log_a x$. Drill problems are available later in this section.

#theorem(title: [Properties of Logarithmic Functions])[
  For $a>0$ but $a!=1$, $b>0$ but $b!=1$, $A>0$, and $B>0$,
  $
    log_a 1 = 0, quad
    log_a a = 1, quad
    log_a A^k = k log_a A quad (k in RR),
  $
  $
    log_a (A B) = log_a A + log_a B, quad
    log_a (A/B) = log_a A - log_a B,
  $
  $
    log_a A = (log_b A)/(log_b a) quad "[changing the base]".
  $<eq:log-base-change>]

= Napier's number and Natural logarithm
There is a special number for the base, called #keyword[Napier's number] $ee$:
#index-see("e", "Napier's number")
$
  ee = 2.718281828... = lim_(n -> oo) (1 + 1/n)^n = sum_(k=0)^oo 1/(k!) = 1 + 1 + 1/2 + 1/6 + 1/24 + 1/120 + ...
$
It is special because of the following theorem:
#theorem(title: "Napier's number")[
  $
    dv(, x) ee^x = ee^x, quad dv(, x) ln x = 1/x,
  $
]
where the #keyword[natural logarithm] ($ln x$) is defined by $ln x := log_e x$.
Also, we often write $ee^x$ as $exp(x)$.


#quizzes[
  + Draw the graphs of $y=exp(x)$ and $y=ln x$, using computers or calculators.
  + Calculate the following, where $a>0$, $b>0$, and  $b!=1$.
    #h-enum(cols: (1.2fr, 1fr, 1fr, 1.2fr, 1.2fr), label-align: horizon)[
      + $dv(, x)exp(x)$
      + $dv(, x)ee^(-3x)$
      + $dv(, x)a^(x)$
      + $dv(, x)ln(3x)$
      + $dv(, x)log_b x$
    ]
  #fail-safe[Review @quiz:exp-change-base for (3). Review @eq:log-base-change for (5). Recall $ee$ is just a number.]
]

#pagebreak()

#problems[
  You may skip these drill problems, as (Sho expects) you *already have learned* them.
  + `9` Differentiate them, where $a$ is a positive constant such that $a!=1$.
    #h-enum(cols: (1fr, 0.9fr, 1fr, 1fr, 1.2fr))[
      + $exp(5x)$
      + $ee^(-x^2)$
      + $3exp(2x)$
      + $ee^(sin x)$
      + $x (ee^x)^2$
      + $sqrt(ee^x + 1)$
      + $ee^x ee^(x^2)$
      + $ln(2x)$
      + $ln|3x|$
      + $ln(x^5 + x)$
      + $ln lr(|cos x|)$
      + $x ln x$
      + $ln(1\/x)$
      + $ee^x ln x$
      + $ln|2x - 1|$
      + $a^(4x)$
      + $a^(x^2)$
      + $(2a)^(2x)$
      + $log_a x^5$
      + $log_a (x^5+x)$
    ]
  + `9` Simplify each expression, where $a$ is a positive constant such that $a!=1$.
    #h-enum(cols: (1fr, 1fr, 1fr, 1.3fr))[
      + $9^(-1\/2)$
      + $16^(3\/4)$
      + $8^(-2\/3)$
      + $ee^(3 ln 2)$
      + $ee^(ln 3 + ln 4)$
      + $ee^(ln (6+7))$
      + $ln ee^(6+7)$
      + $ee^3(ee^4)^4$
      + $log_4 8$
      + $log_(10) 0.01$
      + $log_(0.5) 2$
      + $log_3(1\/27)$
      + $log_6 6^(10)$
      + $ln 6 + ln(1\/6)$
      + $2 ln 3 - ln 9$
      + $ln 12 - ln 4 + ln 2$
      + $1^(-a)$
      + $log_a 1$
      + $log_a (2a^2)^4$
      + $log_a (ln(ee^(5a)))$
    ]
  + `9` Some of the following expressions are not defined. Find all the undefined ones.
    #grid(
      columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1.4fr),
      inset: (x: 1em, y: 0.5em),
      $pi^0$, $pi^(-3)$, $pi^(2.5)$, $pi^(-2.5)$, $pi^pi$, $pi^(-pi)$, $pi^(-1\/pi)$,
      $0^0$, $0^(-3)$, $0^(2.5)$, $0^(-2.5)$, $0^pi$, $0^(-pi)$, $0^(-1\/pi)$,
      $(-2)^0$, $(-2)^(-3)$, $(-2)^(2.5)$, $(-2)^(-2.5)$, $(-2)^pi$, $-2^(-pi)$, $-2^(-1\/pi)$,
      $sqrt(4.5)$, $sqrt(-4)$, $root(3, 3.5)$, $root(3.5, 3)$, $root(-4, 3)$, $root(4, -3)$, $root(4, 1+sqrt(2))$,
      $root(1.5, 1)$, $root(4, -8)$, $root(-3, 8)$, $root(0, 8)$, $root(3, pi)$, $root(pi, 3)$, $root(4, 1-sqrt(2))$,
    )
]

#problems[
  + `4` Solve these equations.
    #h-enum(cols: (1fr, 1fr, 1fr))[
      + $2^(x+1) = 64$
      + $ee^(3x-1) = 4$
      + $ee^x = 5$
      + $ln|x - 1| = 0$
      + $ln x = 4$
      + $log_5(2x + 3) = 2$
      + $2^(-2x) = 7$
      + $log_3(2x + 1) = 3$
      + $ee^(2x) - 3ee^x + 2 = 0$
    ]
  + `3` Draw the graphs of the following functions.
    #h-enum(cols: 5, label-align: horizon)[
      + $y = 2^x$
      + $y = 0.5^(x)$
      + $y = (root(3, 2))^x$
      + $y = 2 dot 2^x$
      + $y = 2^x/2$
    ]
  #fail-safe[Draw $y=2^x$ first. Rewrite the other functions in the form of $y=2^("□")$.]
  + `2` Solve these equations.
    #h-enum(cols: 2)[
      + $ln(x^2 - 3) = ln(2x)$
      + $ln x + ln(x - 1) = ln 6$
      + $log_2 x + log_2(x + 2) = 3$
      + $ln(x+1) + ln(x-1) = ln 3$
      + $log_2 x - log_2(x-2) = 3$
      + $ln(x+1) - ln(x-1) = ln 4$
      + $log_2|x| + log_2|x + 2| = 3$
      + $ln|x+1| + ln|x-1| = ln 4$
    ]
  + `2` Calculate the derivative of $x^x$.
  + `2` #keyword[Hyperbolic functions] are defined by
    $
      cosh x := (ee^x + ee^(-x))/2, quad
      sinh x := (ee^x - ee^(-x))/2, quad
      tanh x := (sinh x) / (cosh x), quad "etc."
    $
    + Calculate the derivative of $cosh x$, $sinh x$, and $tanh x$.
    + Draw the graphs of $cosh x$, $sinh x$, and $tanh x$.
    + Show the following properties:
      #h-enum(cols: (1fr, 1.2fr), label-align: horizon)[
        + $cosh^2 x - sinh^2 x = 1$.
        + $cosh x >= 1$ for all $x$.
        + $cosh x$ is an even function.
        + $sinh x$ and $tanh x$ are odd functions.
      ]
]


= Exponential Growth and Decay <exp-physics>

Consider the function $f(t) = N exp(A t)$, where $N>0$ and $A in RR$.

$
  f(t) = N exp(A t) "is" #math-strong("strictly increasing") "if" A>0, "while"
  #math-strong("strictly decreasing") "if" A<0.
$<eq:exp-growth-decay>
Therefore, $f(t) = N exp(A t)$ is called #keyword[exponential growth] if $A>0$ and #keyword[exponential decay] if $A<0$.
We learn the properties of this function in the next quiz:
#quizzes[
  + Consider the above function $f(t) = N exp(A t)$, where $N>0$ and $A in RR$.
    + What does "strictly increasing" mean?
    + Calculate $f'(t)$. Confirm the two statements in @eq:exp-growth-decay.
    + Show that $f(0) = N$ and $f'(t) = A f(t)$.
  #remark[We will discuss these equations in #TODO[section].]
]
#[
  #let th = $T_(1\/2)$
  #make-indent
  Consider an exponential decay, where the number at $t=0$ is $N$.
  We usually express such decays by
  $
    f(t) & = N exp(-Gamma t) quad quad && (Gamma>0) \
         & = N exp(-t/tau) quad        && "(we define" tau := 1\/Gamma). \
  $
  Then we define the #keyword[half-life] $th$ as the time $t$ such that $f(th) = f(0)\/2$.
  #quizzes[
    +
      #h-enum(label-align: horizon, cols: 1)[
        + Show that $f'(t) = -Gamma f(t)$.
        + Show that $th = tau ln 2$.
        + Assume $f(t_1) = 40$. Find $t_2$ and $t_3$ such that $f(t_2) = 20$ and $f(t_3) = 10$.
        + Show that, for any $t$, $f(t+th)/f(t) = 1/2$.
      ]
  ]
  So, each time one half-life passes, the quantity is reduced by half.
  If $2th$ has passed, the number will be $1\/4$ of the original number.
]

#problems[
  + `3` An RC circuit has charge $Q(t) = Q_0 ee^(-t\/tau)$, where $tau = R C$.
    + Verify that $Q(tau) = Q_0\/ee$.
    + Assume $R = 2.0 unit("k"Omega)$ and $C = 50 unit(mu"F")$. Calculate $tau$. Then, find the time $t$ at which $Q$ dropped to $10%$ of $Q_0$.


]
