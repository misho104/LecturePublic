#import "misho-text.typ": *
#import "physica.typ": *
#import "2-units.typ": writing

#let Arg = math.op("Arg")


You have learned complex numbers in high school but it is worth reviewing them in a university style.
As you learned in @sec:logic-type, try to distinguish between definitions and derived consequences.

#remark[
  Geometrical discussions, such as #keyword[complex planes], are not included in this document, mainly because you are expected to be familiar with it.
]

= Complex Numbers <sec:comp-intro>

#definition(title: [Complex numbers])[
  A #keyword[complex number] is given by the form
  $ z = a + b ii, quad "where" a, b in RR quad "and" quad ii "is a symbol satisfying" ii^2=-1. $<eq:i-def>
  We call the newly-introduced symbol $ii$ #keyword[imaginary unit].
  Also, $a$ is called the #keyword[real part] of $z$ and $b$ the #keyword[imaginary part] of $z$, written by
  #no-num[$ Re(z) := a, quad Im(z) := b. $]
  The set of all complex numbers is written by $CC$.
]

#be-careful[
  $Re(z)$ and $Im(z)$ are both real. If $z = 3 + 5ii$, then $Im(z) = 5$ (not $5ii$).
]
#remark[We use $ii$ to denote the imaginary unit. You may see other notations such as $i$, $j$, $upright(j)$, or $sqrt(-1)$. However, Sho recommends you *not* to write $sqrt(-1)$ since it may make you confused.
  Recall, in @chap:pow, we _avoided_ definitions of $sqrt(x)$ for $x<0$.]
#advanced-note[
  Notice that $ii$ is just a symbol and it has only one property $i dot i=-1$.
  You may well ask "$-ii$ also satisfies $(-ii)^2=-1$; which should we choose as $ii$?" but it sounds a weird question since "$-ii$" was not _a priori_: it was not there before we introduced $ii$, so we can discuss $-ii$ only after we fix $ii$.
]
Hereafter, when we write #writing[$z = a + b ii in CC$], we implicitly assume $a$ and $b$ are real numbers.
#definition[
  Consider $z=a+b ii in CC$.

  - $z$ is a real number if $Im z = b= 0$. Namely, if $b=0$, then $z=a+0ii=a$.

  - $z$ is called #keyword[pure-imaginary] if $Re z = a = 0$ but $z!=0$, namely, if $z=b ii$ with $b!=0$.

  Also, for another complex number $c + d ii$, we define $quad a + b ii = c + d ii <==> a = c and b = d.$
]
It is debatable if $0$ is pure-imaginary or not, so you need to be careful when you discuss $0$ (but usually $0$ is not included in pure-imaginary numbers.)
Some people write the set of all pure-imaginary number by #writing[$ii RR$], but then you need to pay attention to this issue.

For complex numbers $z_1 = a_1 + b_1 ii$ and $z_2 = a_2 + b_2 ii$, addition and multiplication are defined by
#no-num[
  $
    z_1 + z_2 = (a_1 + a_2)+(b_1+b_2)ii, quad quad
    z_1 z_2 & = (a_1 + b_1 ii)(a_2 + b_2 ii) \
            & = (a_1 a_2 + b_1 b_2 ii^2) + (a_1 b_2 + a_2 b_1)ii \
            & = (a_1 a_2 - b_1 b_2) + (a_1 b_2 + a_2 b_1)ii.
  $
]
Furthermore, two more important operations are defined:
#definition(title: [Complex conjugate and Absolute value])[
  For $z = a + b ii in CC$, we define

  - its #keyword[complex conjugate] by $overline(z) := a - b ii$,

  - its #keyword[absolute value] by $|z| := (overline(z)med z)^(1\/2) = (a^2 + b^2)^(1\/2)$.
]<def:comp-conj>
#quizzes[
  + Prove that, if $z=a + b ii$, then $overline(z)z$ is a real and positive number.
  + Explain why $|z| >= 0$. #hint[See the definition carefully. What does $x^(1\/2)$ mean?]
  + For each $z$ below, find $Re(z)$, $Im(z)$, $overline(z)$, and $|z|$.
    #no-num(comma-gap: auto)[
      $ z = 2 + 7ii, z = -3 - ii, z = 5, z = -4ii, z = 0. $
    ]
  + Find $x, y in RR$ such that $(x + 1) + (2y - 3)ii = 4 - ii$.
]
#problems[
  + `9` #hint(head: "Note: ")[This is a timed practice; just write down the answer, without explanation.]\
    Consider the following numbers. Assume $a, b, k in RR$.

    #no-num(comma-gap: auto)[
      $-2 + ii$,
      $1 - ii$,
      $3 + 4ii$,
      $-2(3 +4ii)$,
      $-2$,
      $-2ii$,
      $-9ii$,
      $0$,
      $ii$,
      $4$,\
      $√2 + ii$,
      $-√3 + 2ii$,
      $3 + ii√5$,
      $-1 - ii√7$,
      $-√11 + ii√14$,\
      $(ii+√5)/√2$,
      $(ii-√5)/√2$,
      $(√3)/√2 + (√3)/√2 ii$,
      $-(√2)/2 + (√6)/2 ii$,
      $a+2ii$,
      $a-b ii$,
      $k ii$.
    ]
    + What are the real part, imaginary part, and complex conjugate of each?
    + What are their absolute values? (goal time: 120 seconds)
  + `9` Calculate the following.
    #h-enum(cols: 3, label-align: horizon)[
      + $(3+2ii)+(4-5ii)$
      + $(-2+7ii)-(5+3ii)$
      + $(6-4ii)-(-1+2ii)$
      + $(2+3ii)(4-ii)$
      + $(-1+5ii)(2+3ii)$
      + $(3-2ii)(3+2ii)$
      + $ii(3+ii)-ii(1-4ii)$
      + $(1-2ii)+overline(4+ii)$
      + $overline((3-4ii)+overline(1+2ii))$
      + $(1+2ii)^4$
      + $(1-2ii)^4$
      + $(2+3ii)^3(2-3ii)^3$
      + $(2+ii)/(-ii)$
      + $(11+4ii)/(1+2ii)$
      + $(1-ii)/(1+ii)^2$
    ]
  #fail-safe[
    A fraction $w \/ z$ of complex numbers can be simplified by multiplying both numerator and denominator by $overline(z)$:
    #no-num[
      $
        w / z = (w overline(z)) / (z overline(z)) = (w overline(z)) / (|z|^2).
        quad
        "For example, "
        (11+4ii)/(1+2ii) = ((11+4ii)times(1-2ii)) / ((1+2ii)times(1-2ii)) = (19-18ii)/5.
      $
    ]
  ]
  + `2` Find $z in CC$ that satisfies $z^2 = 1 + 2ii$.
]
As we already saw some examples, powers of complex numbers are defined, but *only for* $n in ZZ$.

- $alpha^1 = alpha, quad alpha^2 = alpha alpha, quad alpha^3 = alpha^2 alpha = alpha alpha alpha, ...$

- For $display(alpha != 0\, quad alpha^0 = 1\, quad alpha^(-1)= 1/alpha\, quad alpha^(-2)=1/alpha^2\, quad...)$

In particular, $display((a+b ii)^(-n) = 1/((a+b ii)^n) = 1/((a+b ii)^n) times ((a-b ii)^n)/((a-b ii)^n) = ((a-b ii)^n)/((a^2+b^2)^n)) quad "if" a+b ii != 0$.

#divider()

The following relations hold for these operations. They are somewhat obvious, but with using them you can speed up your calculations.


#theorem(title: [Properties of Complex-number arithmetic])[
  For $alpha, beta, gamma in CC$ and $n, m in ZZ$,
  $
    (alpha + beta) + gamma = alpha + (beta + gamma), quad
    alpha + beta = beta + alpha, quad
    0 + alpha = alpha,\
    (alpha beta) gamma = alpha (beta gamma), quad
    alpha beta = beta alpha, quad
    1alpha = alpha, quad
    alpha (beta + gamma) = alpha beta + alpha gamma.
  $
  $
    alpha^n alpha^m = alpha^(n+m), quad
    (alpha^n)^m = alpha^(n m), quad
    (alpha beta)^n = alpha^n beta^n, quad
    alpha^(-1) = overline(alpha)/(|alpha|^2), quad
    (alpha/beta)^(n) = alpha^(n) / beta^(n);
  $

  $
    overline(med overline(med alpha med) med) = alpha, quad
    overline(alpha + beta) = overline(alpha) + overline(beta), quad
    overline(alpha beta) = overline(alpha) thick overline(beta), quad
    overline(alpha^n) = (overline(alpha))^n, quad
    overline((alpha/beta)) = (overline(alpha)) / (thick overline(beta)thick);
  $
  $
    lr(|thin overline(alpha)thin |) = |alpha|,quad
    |alpha beta| = |alpha||beta|, quad
    lr(|thin alpha/(thin beta thin) thin|) = (|alpha|)/(thin |beta| thin), quad
    |alpha^n| = |alpha|^n,
  $
  $
    \|alpha| - |beta\| <= |alpha - beta|,quad
    |alpha + beta| <= |alpha| + |beta|, quad
  $
  $
    Re(z) = (z + overline(z))/2, quad Im(z) = (z - overline(z))/(2ii).
  $
]<comp:properties>
#problem-style-label.update(true)
#example[
  Express following expressions without "Re" and "Im", i.e., only with $z$ and $overline(z)$.
  #h-enum[
    + $Re(z)^2$
    + $Re(z^2)$
    + $Re(z)Im(z)$
  ]

]
#solution[
  $display(Re(z)^2 = ((z+overline(z))/(2))^2 = ((z+overline(z))^2)/4);quad
  display(Re(z^2) = (z^2 + overline(z^2))/2 = (z^2 + overline(z)^2)/2);quad
  display(Re(z)Im(z) = (z^2-overline(z)^2)/(4ii)).$
]
#problem-style-label.update(false)

#quizzes[
  + Calculate them.
    #h-enum(cols: (1fr, 0.8fr, 0.8fr, 1fr), label-align: horizon)[
      + $lr(|(sqrt(2)+ ii sqrt(7))^4|)$
      + $lr(|11+22ii|)^2$
      + $lr(|(1+ii)/(med 1-ii med)|)$
      + $(1+ii)overline((1+ii)^2)$
    ]
  + Express following expressions without "Re" and "Im", i.e., only with $z$ and $overline(z)$.
    #h-enum(cols: 3)[
      + $(Im(z))^2$
      + $Im(2z)$
      + $Re(z)+Im(z)$
    ]
]

#problems[
  + `4` Let $z = 2 + ii$ and $w = 1 - 2ii$. Calculate:
    #h-enum(cols: 5)[
      + $z+w$
      + $overline(z)$
      + $overline(w)$
      + $|z|$
      + $|w|$
      + $overline(z) + overline(w)$
      + $overline(z + w)$
      + $z overline(w)$
      + $overline(z) w$
      + $|z w|$
      + $lr(|z / w|)$
      + $|z + w|$
      + $|z| + |overline(w)|$
      + $|z w + z overline(w)|$
      + $|overline(z) w + z overline(w)|$
    ]
  + `4` Calculate $ii^2$, $ii^4$, and $ii^(127)$. Also, for $z=(1+ii)\/sqrt(2)$, calculate $z^(127)$.
  + `4` Prove the following statements, where $z, alpha, beta in CC$.
    #h-enum(cols: 3)[
      + $overline(z_1 z_2) = overline(z_1) med overline(z_2)$.
      + $|z_1 z_2| = |z_1| |z_2|$.
      + $Im(z) = (z - overline(z))\/(2ii).$
    ]
  + `2` Prove that, for $a, b, c in RR$ and $z in CC$, the solution of $a z^2 + b z + c = 0$ is given by
    $ z = (-b ± √(b^2-4a c))/(2a)quad "if" b^2 >= 4a c;quad z=(-b ± ii√(|b^2-4a c|))/(2a) quad "if" b^2<4a c. $
  + `2` Find all complex numbers $z$ satisfying the following equations.
    #h-enum(cols: 4)[
      + $z^2 + 16 = 0$
      + $z^2 + 4z + 5 = 0$
      + $z^2 + 16ii = 0$
      + $z^2 + 4z + 5ii = 0$
    ]
  + `2` Let's prove $0 <= |alpha + beta| <= |alpha| + |beta|$ step by step, where $alpha, beta in CC$.
    + For $z in CC$, prove the next: $z != 0 ==> z overline(z) > 0$. #hint[Let $z = a + b ii.$]
    + For $z in CC$, prove $|z| >= Re(z).$ Then, let $z=alpha overline(beta)$ and simplify $2|z|-2Re(z)$.
    + Calculate $(|alpha|+|beta|)^2 - |alpha+beta|^2$ and prove it is not negative ($>=0$).
    + Prove $0 <= |alpha + beta| <= |alpha| + |beta|$. Also, find the condition for $|alpha + beta| = |alpha| + |beta|.$

  + `2` Let $p(z) = a_n z^n + a_(n-1) z^(n-1) + ... + a_1 z + a_0$ be a polynomial with _real_ coefficients ($a_k in RR$).
    Prove that if $z_0 in CC$ is a solution of $p(z) = 0$, then so is $overline(z_0)$.
]

#pagebreak()

= Polar Form <sec:comp-polar>
Let us begin with a theorem.
#theorem(title: "Polar form")[
  A complex number $z = a + b ii$, where $a, b in RR$, can be expressed in the following #keyword[polar form]:
  $
    z = r lr(size: #150%, (cos theta + ii sin theta)), quad "where" & r=|z| "is the absolute value of " z, \
    & theta in RR "is called the" keyword("argument") "of" z.
  $<eq:polar>
  For $z!=0$, this expression is unique up to the $2pi$-periodicity of $theta$.
]
#proof[
  Let $z=a+b ii$ with $a, b in RR$.
  For $z=0$, the statement is valid because $r=|z|=0$. Now we assume $z !=0$ and, with $r:=|z|$, consider a point P at $(a\/r, b\/r)$ on $x y$-plane.
  Since $(a\/r)^2+(b\/r)^2=1$, P is on the unit circle around the origin O and thus can be expressed by $(cos theta, sin theta)$ with $theta$ being the angle from the positive x-axis to $arrow("OP")$ and the choice of $theta$ is unique up to the $2pi$-periodicity. It means $a\/r=cos theta$ and $b\/r = sin theta$, i.e., $z=r cos theta + ii r sin theta$. $qed$
]
#advanced-note[
  In this document, the #keyword[trigonometric functions] $cos theta$ and $sin theta$ are defined using the unit circle in $x y$-plane and this proof employs that definition.
  In advanced mathematics, we often take another approach, where we first define $ee^x$ for $x in RR$ by a #keyword[power series]. Then we extend $ee^x$ to $CC$ and, from this complex function $ee^z$, we define $cos x$ and $sin x$ for $x in RR$ by Euler's formula. See #TODO[#lorem(4)] for further discussion.
]

#quizzes[
  + Find the complex number expressed by the following polar form:
    #h-enum(cols: 3)[
      + $r=sqrt(2), theta=pi\/4$
      + $r=2, theta=-pi\/6$
      + $r=4, theta=pi\/2$
      + $r=sqrt(2), theta=9pi\/4$
      + $r=2, theta=-5pi\/6$
      + $r=4, theta=-pi$
    ]

]

Similar to $Re(z)$ and $Im(z)$, we may consider a function $Arg(z)$ to return its argument.
Here, however, we need to care the #keyword(key: "multivalued", display: "multivalued")[multivaluedness] in $theta$. For example, #thick-sf[(1)] and #thick-sf[(4)] in the above quiz express the same number $z=1+ii$, so there can be multiple values of $theta$ for $z=1+ii$ (and, in fact,  for any other numbers).
A convenient choice is to define $-pi < Arg(z) <= pi$:
#definition[
  For $z in CC$, $z !=0$,
  $
    Arg(z) := "the argument of " z, "chosen between" -pi "(exclusive) and" pi "(inclusive)".
  $
]
We often call it "we choose the #keyword[principle value] of the argument of $z$ so that $-pi<Arg(z)<=pi$".

#quizzes[
  + Find $Arg(5ii)$, $Arg(2+2ii)$, $Arg(-1-ii)$, and $Arg(1-ii)$.
]

= Euler's formula
So far, we have seen $z+w$, $z w$, and $z^n$ for $n in ZZ$, very similar to the real numbers, and $overline(z)$ and $|z|$.
Next, we want to define $ee^z$ for $z in CC$. Here, we want to keep the key properties of $ee^x$ such as $upright(d)ee^(a x)\/upright(d)x = a ee^(a x)$ and $ee^(a+b) = ee^a ee^b$ even for $a, b in CC$.
So,
#theorem(type: "Definition")[
  We *define*, for a complex number $z=a+b ii$ ($a, b in RR$),
  $
    ee^(a + b ii) := ee^a lr(size: #150%, (cos b + ii sin b)).
  $
  $
    "In particular, for" theta in RR, quad ee^(ii theta) = cos theta + ii sin theta quad (#keyword[Euler’s formula]).
  $
]
#advanced-note[
  Let $a, b, x in RR$. Then, we want to keep $ee^((a+b ii)x)=ee^(a x) ee^(b ii x)$ and thus we just have to define $ee^(ii theta)$ for a real number $theta = b x$. Letting $ee^(ii theta)=f(theta) + ii g(theta)$, the requirement of derivative is given by
  $upright(d)ee^(ii b x)\/upright(d)x = ii b ee^(ii b x)$, where the LHS is $b dot upright(d)ee^(ii theta)\/upright(d)theta = b f'(theta) + ii b g'(theta)$ and the RHS is $ii b (f(theta)+ii g(theta)) )$.
  It means $f'(theta)=-g(theta)$ and $g'(theta)=f(theta)$. Together with $f(0)=1$ and $g(0)=0$, we get $f(theta)=cos(theta)$ and $g(theta)=sin(theta)$ and now we have understand our wanted definition is $ee^(a+ii b)=ee^(a)(cos b+ii sin b)$.
]
Accordingly, the polar form of complex numbers is given by
$ z = a + b ii = r(cos theta + ii sin theta) =r exp(ii theta) = |z|exp lr(size: #180%, (ii Arg(z))). $

As we defined $ee^z$ so that the key properties are kept, the following formulae are valid.
(Compare with @exp-properties!).
#theorem(title: [Properties of Exponential Functions (2)])[
  $
    "For" z, w in CC,quad
    1/(e^z) = e^(-z), quad
    e^z e^w = e^(z+w), quad (e^z)/(e^w) = e^(z-w), quad (e^z)^w = e^(z w).
  $

  Because $ln a$ is already defined for $a>0$, we can use it to consider $a^z$ (but now only for $a>0$):
  $
    "For" z in CC "and" a>0, quad a^z = (e^(ln a))^z = e^(z ln a).
  $
]
We will #TODO[later?] discuss $a^z$ for non-positive $a$, such as $a=-1$ or $ii$.


#quizzes[
  + Express the following number in the form $a+b ii$:
    #h-enum(cols: 6)[
      + $ee^(ii)$
      + $ee^(2ii)$
      + $ee^(-ii)$
      + $ee^(1+ii)$
      + $(ee^ii)^4$
      + $ee^ii^4$
      + $ee^(ii ln 3)$
      + $2^ii$
      + $2^(2+ii)$
      + $2^(2+2ii)$
      + $4^(1+ii)$
      + $5^(ii^2)$
    ]
]

The next theorem is extremely important:
#theorem[
  $
    "For" theta in RR,quad
    cos theta = Re(ee^(ii theta)) = (ee^(ii theta) + ee^(-ii theta))/2, quad
    sin theta = Im(ee^(ii theta)) = (ee^(ii theta) - ee^(-ii theta))/(2ii).
  $ <eq:euler-trig>
]
Then for $theta in RR$ and $n in ZZ$, #index[de Moivre's theorem] de Moivre's theorem $(cos theta + ii sin theta)^n = cos(n theta) + ii sin(n theta)$ holds, but we do not need to memorize it. Just use the equation $ee^(ii n theta) = (ee^(ii theta))^n$, e.g.,
#example[
  Express $cos 4theta$ in terms of $cos theta$.
]
#solution[
  Write $c = cos theta$ and $s = sin theta$ for brevity. Then.
  #no-num[
    $
      cos 4theta = Re(ee^(4ii theta)) = Re(ee^(ii theta))^4 = Re(c + ii s)^4 = Re(c^4+4c^3 ii s +6c^2ii^2s^2+4c ii^3s^3 +ii^4s^4).
    $
  ]
  As $s^2=1-c^2$, we obtain $cos 4theta = c^4-6c^2(1-c^2)+(1-c^2)^2 = 8cos^4theta - 8cos^2theta + 1.$
]
#quizzes[
  + Using the above properties, express $cos 3theta$, $sin 3theta$, $cos(theta+phi)$, and $sin(theta+phi)$ in terms of $cos theta$, $sin theta$, $cos phi$, and $sin phi$.
  #fail-safe[Expand both sides of the equality $ee^(ii(theta + phi)) = ee^(ii theta) ee^(ii phi)$.]
]
#problems[
  + `9` Compute the following and express in the form $a + b i$.
    #h-enum(cols: 4)[
      + $ee^(i pi \/ 6)$
      + $ee^(i pi)$
      + $ee^(2 i pi)$
      + $2 ee^(-i pi \/ 3)$
      + $sqrt(2) ee^(-i pi \/ 4)$
      + $ee^(i pi \/ 2) + ee^(-i pi \/ 2)$
      + $(1 + i)^4$
      + $(sqrt(3) + i)^6$
    ]
  + `4` Convert to polar form $r ee^(i theta)$, choosing $Arg(z) in (-pi, pi]$.
    #h-enum(cols: 4)[
      + $1 + sqrt(3) i$
      + $-2$
      + $-i$
      + $3 - 3i$
      + $-1 + i$
      + $-sqrt(3) - i$
      + $4i$
      + $1 - sqrt(3) i$
    ]
  + `3` Using the polar form, compute the following. Express in the form $a + b i$.
    #h-enum(cols: 3)[
      + $(1 + i)^8$
      + $\((sqrt(3) + i)\/2)^12$
      + $(1 - i)^(10)$
      + $(1 + sqrt(3)i)^(-3)$
      + $((1 + i)\/(1 - i))^(20)$
      + $((sqrt(3) + i)\/(1 + i))^6$
    ]
  + `3` Use de Moivre's theorem to expand $cos(4theta)$ and $sin(4theta)$ in terms of $cos theta$ and $sin theta$.
  + `2` Express $cos^3 theta$ and $sin^3 theta$ as a linear combination of $cos(n theta)$ and $sin(n theta)$ for various $n$.
  #fail-safe[Cube the identity $cos theta = (ee^(i theta) + ee^(-i theta))\/2$, then simplify using @eq:euler-trig.]
  + `2` Show the following addition formulas using Euler's formula:
    #h-enum(cols: 1)[
      + $cos(alpha + beta) = cos alpha cos beta - sin alpha sin beta$.
      + $sin(alpha + beta) = sin alpha cos beta + cos alpha sin beta$.
    ]
  #fail-safe[Expand $ee^(i(alpha + beta)) = ee^(i alpha) ee^(i beta)$ and match real and imaginary parts.]
]


#example(title: [Square roots of $-1$])[
  Find all square roots of $-1$.
]
#solution[
  Write $w = -1 = ee^(i pi)$ (so $R = 1$, $phi = pi$, $n = 2$).
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
  Write $w = 1 = ee^(i dot 0)$ ($R = 1$, $phi = 0$, $n = 3$).
  #no-num[
    $
      z_0 = 1, quad
      z_1 = ee^(2pi i \/ 3) = -1/2 + sqrt(3)/2 i, quad
      z_2 = ee^(4pi i \/ 3) = -1/2 - sqrt(3)/2 i.
    $
  ]
  These three points form an equilateral triangle inscribed in the unit circle.
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



