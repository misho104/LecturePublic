#import "misho-text.typ": *
#import "physica.typ": Im, Re, bra, braket, ket  // cspell: disable-line
#import "2-units.typ": writing
#import "5-vector.typ": dm, va, vc, vcu, vector-three-ways
// cspell: ignore multivaluedness Moivre Schwarz

#let Arg = math.op("Arg")
#let vk(x) = ket(vc(x))
#let lbk(x, y) = $chevron.l thin#x thin|thin#y thin chevron.r$ // loose bra-ket
#let cip(x, y) = $lbk(vc(#x), vc(#y))$
#let cop(x, y) = $|thin #x thin chevron.r chevron.l thin #y thin |$

You have learned complex numbers in high school but it is worth reviewing them in a university style.
As you learned in @sec:logic-type, try to distinguish between definitions and derived consequences.

#remark[
  Geometrical discussions, such as #keyword[complex planes], are not included in this document, mainly because you are expected to be familiar with it.
]

= Complex numbers <sec:comp-intro>
#definition(title: [Complex numbers])[
  A #keyword[complex number] is given by the form
  $ z = a + b ii, quad "where" a, b in RR quad "and" quad ii "is a symbol satisfying" ii^2=-1. $<eq:i-def>
  We call the newly-introduced symbol $ii$ the #keyword[imaginary unit].
  Also, $a$ is called the #keyword[real part] of $z$ and $b$ is called the #keyword[imaginary part] of $z$, written by
  #no-num[$ Re(z) := a, quad Im(z) := b. $]
  The set of all complex numbers is written by $CC$.
]
#be-careful[
  $Re(z)$ and $Im(z)$ are both real. If $z = 3 + 5ii$, then $Im(z) = 5$, not $5ii$.
]
#remark[
  We use $ii$ to denote the imaginary unit.
  You may see other notations such as $i$, $j$, $upright(j)$, or $sqrt(-1)$.
  However, Sho recommends you *not* to write $sqrt(-1)$ since it may make you confused.
  Recall, in @chap:pow, we _avoided_ definitions of $sqrt(x)$ for $x<0$.
]
#advanced-note[
  Notice that $ii$ is just a symbol and it has only one property $ii dot ii=-1$.
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
and powers of complex numbers $z^n$ for integer $n$ are defined as usual:

- $alpha^1 = alpha, quad alpha^2 = alpha alpha, quad alpha^3 = alpha alpha alpha, ...$

- For $display(alpha != 0\, quad alpha^0 = 1\, quad alpha^(-1)= 1/alpha\, quad alpha^(-2)=1/alpha^2\, quad...)$

#remark[Here we define $z^n$ for $n in ZZ$.]

Furthermore, two more important operations are defined:
#definition(title: [Complex conjugate and Absolute value])[
  For $z = a + b ii in CC$, we define

  - its #keyword[complex conjugate] by $overline(z) := a - b ii$,

  - its #keyword[absolute value] by $|z| := (overline(z)med z)^(1\/2) = (a^2 + b^2)^(1\/2)$.
]<def:comp-conj>
//#remark[
//  Geometrically, $|z|$ is the distance from $z$ to the origin in the complex plane, and $overline(z)$ is the reflection of $z$ in the real axis.
//]
#quizzes[
  + Prove that, if $z=a + b ii$, then $overline(z)z$ is a real and non-negative number.
  + Explain why $|z| >= 0$. #hint[See the definition carefully. What does $x^(1\/2)$ mean?]
  + For each $z$ below, find $Re(z)$, $Im(z)$, $overline(z)$, and $|z|$.
    #no-num(comma-gap: auto)[
      $ z = 2 + 7ii, z = -3 - ii, z = 5, z = -4ii, z = 0. $
    ]
  + Find $x, y in RR$ such that $(x + 1) + (2y - 3)ii = 4 - ii$.
]

The fact $z overline(z) in RR$ is used to calculate fractions of complex numbers:
$
  w / z = (w overline(z)) / (z overline(z)) = (w overline(z)) / (|z|^2).
  quad
  "For example, "
  (11+4ii)/(1+2ii) = ((11+4ii)times(1-2ii)) / ((1+2ii)times(1-2ii)) = (19-18ii)/5.
$
Thus, for $z = a+b ii != 0$ and $n in ZZ$,
$
  z^(-n)
  = 1/(z^n)
  = overline(z)^n/(z^n overline(z)^n)
  = overline(z)^n/((z overline(z))^n)
  = overline(z)^n/(|z|^(2n))
  = ((a-b ii)^n)/(a^2+b^2)^n.
$

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
    + What are the real part, imaginary part, and complex conjugate of each? (goal time: )
    + What are their absolute values? (goal time: 120 seconds)
  + `9` Calculate the following.
    #h-enum(cols: 3)[
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
  + `2` Find $z in CC$ that satisfies $z^2 = 1 + 2ii$.
]

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
]<comp:properties>
#theorem[
  $ Re(z) = (z + overline(z))/2, quad Im(z) = (z - overline(z))/(2ii). $
]

#problem-style-label.update(true)
#example[
  Express $Re(z)^2$, $Re(z^2)$, and $Re(z)Im(z)$ without using "Re" and "Im", i.e., only with $z$ and $overline(z)$.
]
#solution[
  $display(Re(z)^2 = ((z+overline(z))/(2))^2 = ((z+overline(z))^2)/4);quad
  display(Re(z^2) = (z^2 + overline(z^2))/2 = (z^2 + overline(z)^2)/2);quad
  display(Re(z)Im(z) = (z^2-overline(z)^2)/(4ii)).$
]
#problem-style-label.update(false)

#quizzes[
  + Calculate them.
    #h-enum(cols: (1fr, 0.8fr, 0.8fr, 1fr))[
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

= Polar form <sec:comp-polar>
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
  In this document, the #keyword(key: "trigonometric function", [trigonometric functions]) $cos theta$ and $sin theta$ are defined using the unit circle in $x y$-plane and this proof employs that definition.
  In advanced mathematics, we often take another approach, where we first define $ee^x$ for $x in RR$ by a #index[power series]. Then we extend $ee^x$ to $CC$ and, from this complex function $ee^z$, we define $cos x$ and $sin x$ for $x in RR$ by Euler's formula. See #TODO[#lorem(4)] for further discussion.
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
Here, however, we need to care the #keyword(key: "multivalued", display: "multivalued")[multivaluedness] in $theta$. For example, #thick-sf[(1)] and #thick-sf[(4)] in the above quiz express the same number $z=1+ii$, so there can be multiple values of $theta$ for $z=1+ii$.
So we need to choose one; a convenient choice is to define $-pi < Arg(z) <= pi$:
#definition[
  For $z in CC$, $z !=0$,
  $ Arg(z) := "the argument of" z, "chosen between" med -pi "(exclusive) and" pi "(inclusive)". $
]
This strategy is called "choosing the #keyword[principle value] of the argument of $z$ so that $-pi<Arg(z)<=pi$".
#quizzes[
  + Find $Arg(5ii)$, $Arg(2+2ii)$, $Arg(-1-ii)$, and $Arg(1-ii)$.
]
Due to the subtlety of $Arg(z)$, we do not discuss $Arg(z)$ in the rest of this document.
#advanced-note[
  You can see the subtlety in the next example. Consider $z = ee^(2ii)$. Then, $Arg(z)=2$, but $Arg(z^2)=Arg(ee^(4ii)) approx -2.3$ (Why?). Similarly, $Arg(z^3) approx -0.28$ and $Arg(z^4)approx 1.72$.
]


= Euler's formula <sec:comp-e>
We have seen five types of operations on complex numbers: $overline(z)$, $|z|$, $z+w$, $z w$, and $z^n$ for $n in ZZ$.
The next step is to define $ee^z$ for $z in CC$, but we want to define it nicely: we want to keep the key properties of $ee^x$ such as $upright(d)ee^(a x)\/upright(d)x = a ee^(a x)$ and $ee^(a+b) = ee^a ee^b$ even for $a, b in CC$.
So,
#theorem(type: "Definition")[
  We *define*, for a complex number $z=a+b ii$ ($a, b in RR$),
  $
    ee^(a + b ii) := ee^a lr(size: #150%, (cos b + ii sin b)).
  $
  #no-shift[$
    "In particular, for" theta in RR, quad ee^(ii theta) = cos theta + ii sin theta quad (#keyword[Euler’s formula]).
  $]
]
#advanced-note[
  Let $a, b, x in RR$. Then, we want to keep $ee^((a+b ii)x)=ee^(a x) ee^(b ii x)$ and thus we just have to define $ee^(ii theta)$ for a real number $theta = b x$. Letting $ee^(ii theta)=f(theta) + ii g(theta)$, the requirement of derivative is given by
  $upright(d)ee^(ii b x)\/upright(d)x = ii b ee^(ii b x)$, where the LHS is $b dot upright(d)ee^(ii theta)\/upright(d)theta = b f'(theta) + ii b g'(theta)$ and the RHS is $ii b (f(theta)+ii g(theta)) )$.
  It means $f'(theta)=-g(theta)$ and $g'(theta)=f(theta)$. Together with $f(0)=1$ and $g(0)=0$, we get $f(theta)=cos theta$ and $g(theta)=sin theta$ and now we have understand our wanted definition is $ee^(a+ii b)=ee^(a)(cos b+ii sin b)$.
]
Accordingly, the polar form of complex numbers is given by
$ z = a + b ii = r(cos theta + ii sin theta) =r exp(ii theta) = |z|exp lr(size: #180%, (ii Arg(z))). $

As we defined $ee^z$ so that the key properties are kept, the following formulae are valid.
(Compare with @thm:exp-prop).
#theorem(title: [Properties of Exponential Functions (2)])[
  #no-shift[$
    "For" z, w in CC,quad
    1/(e^z) = e^(-z), quad
    e^z e^w = e^(z+w), quad (e^z)/(e^w) = e^(z-w), quad (e^z)^w = e^(z w).
  $]
  #no-shift[$
    "For" z in CC "and" a>0, quad a^z = (e^(ln a))^z = e^(z ln a).
  $]
]<exp-complex-properties>
Currently, we know $ln a$ only for $a>0$. So, the second statement is only for $a>0$ (see @tab:power-summary).
Discussions on $a^z$ for $a<=0$ and $a in.not RR$ will be given in #TODO[later?].

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
Then for $theta in RR$ and $n in ZZ$, #index[de Moivre#sym.quote.r.single;s theorem] de Moivre's theorem $(cos theta + ii sin theta)^n = cos(n theta) + ii sin(n theta)$ holds, but we do not need to memorize it. Just use the equation $ee^(ii n theta) = (ee^(ii theta))^n$, e.g.,
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
  + Express $cos 3theta$, $sin 3theta$, $cos(theta+phi)$, and $sin(theta+phi)$ in terms of $cos theta$, $sin theta$, $cos phi$, and $sin phi$.  #hint[Expand both sides of $ee^(ii(theta + phi)) = ee^(ii theta) ee^(ii phi)$.]
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
  + `3` Use de Moivre's theorem to express $cos(4theta)$ and $sin(4theta)$ only with $cos theta$ (without $sin theta$).
  + `2` Express $cos^3 theta$ and $sin^3 theta$ as a linear combination of $cos(n theta)$ and $sin(n theta)$ for various $n$.
  + `2` Using the polar form $z=r ee^(i theta)$, find all solutions of the following equations in $CC$.
    #h-enum(cols: 3)[
      + $z^3 - 8 = 0$
      + $z^4 + 16 = 0$
      + $z^6 - 1 = 0$
      + $z^3 + i = 0$
      + $z^4 - 4z^2 + 3 = 0$
      + $z^6 + z^3 - 2 = 0$
    ]
  + `2` For $n in NN^+$ the equation $z^n=1$ has $n$ solutions. They are called the $n$-th roots of unity.
    + Let $omega = ee^(2pi i\/n)$. Show that $omega^k$ with $k=0, 1, ..., n-1$ are the solutions of $z^n=1$.
    + Show the following equations for $n>=2$:
      #h-enum(cols: (.7fr, 1fr, 1.9fr))[
        + $display(sum_(k=0)^(n-1) omega^k = 0)$
        + $display(product_(k=0)^(n-1) omega^k = (-1)^(n+1))$
        + $display(sum_(k=0)^(n-1) cos((2pi k)/n) =sum_(k=0)^(n-1) sin((2pi k)/n)= 0)$
      ]
]


= Trigonometric and Hyperbolic functions <sec:comp-trig>
For real numbers, we have defined the trigonometric and hyperbolic functions (see #ref(form: "page", <prob:hyperbolic>)) by
#no-num[$
  & cos x = Re ee^(ii x) = (ee^(ii x) + ee^(-ii x))/(2),   & #h(4em) & cosh x = (ee^(x)+ee^(-x))/2, \
  & sin x = Im ee^(ii x) = (ee^(ii x) - ee^(-ii x))/(2ii), &         & sinh x = (ee^(x) - ee^(-x))/(2).
$]
We naturally extend this definition to complex numbers:
#no-num[$
  cos z := (ee^(ii z) + ee^(-ii z))/(2), quad
  sin z := (ee^(ii z) - ee^(-ii z))/(2ii), quad
  cosh z := (ee^(z)+ee^(-z))/2, quad sinh z := (ee^(z) - ee^(-z))/(2).
$]
Then, almost obviously,
#theorem[
  For $x in RR$,
  $
    cos ii x = cosh x,quad
    sin ii x = ii sinh x,quad
    cosh ii x = cos x,quad
    sinh ii x = ii sin x.
  $
]
Other functions, such as $tan z$, $cot z$, $tanh z$, ... are defined similarly.

#pagebreak()

= Complex vectors <sec:comp-vec>
The next step is "complex vectors". Let us recall three interpretations of vectors, given in @chap:vector:
#vector-three-ways
There we started from the first interpretation (@def:v-arrow) and reached the second interpretation (@def:va-comp).
For complex vectors, the first interpretation seems not nice, but @def:va-comp looks nice to _define_ complex vectors: we just extend real numbers to complex numbers.
#definition(title: "Inner product of Complex vectors")[
  We define $n$-dimensional #EMPH[complex vectors] by a list of $n$ complex number:
  (cf. @def:va-comp)
  $ vc(v) = mat(v_1; v_2; dots.v; v_n); quad v_k in CC, quad n in NN^+. $
]
#index("vector", "complex vector")
#index-see("complex vector", "vector")

With this definition, we can analyze complex vectors similarly as real vectors, except for one caveat.
We would like to use @eq:va-ip-comp to define inner products, but then it would break nice properties such as @eq:vip-norm and #thick-sf[(C)] of @thm:va-ip-prop.
#quizzes[
  + Confirm that we cannot use @eq:va-ip-comp for complex vectors since it would break @eq:vip-norm and #thick-sf[(C)] of @thm:va-ip-prop in some cases such as $mat(1; ii)$ or $mat(0; ii)$.
]
So, we define inner products for complex vectors by (compare with @eq:va-ip-comp)
#definition(title: "Complex vectors")[
  Consider $n$-dimensional complex vectors $vc(a)$ and $vc(b)$. We define the #keyword[inner product] by
  $
    cip(a, b) = overline(a_1)thin b_1 + overline(a_2)thin b_2 + dots + overline(a_n)thin b_n = sum_(k=1)^n overline(a_k)thin b_k wide "(for complex vectors)."
  $
  We use a different notation $cip(a, b)$ to indicate it is _complex_ inner product.
]<def:vc-ip>
#quizzes[
  #be-careful(indent: false)[Important quizzes!]
  + Check that #RED[$cip(a, b) = cip(b, a)$] is false (incorrect). #hint[Find a counterexample.]
  + Let $vc(v) = k vc(a)$ with $k in CC$. Check that #RED[$cip(v, b) = k cip(a, b)$] is false.
]
#remark[Cross products are not defined for complex vectors.]
#block(breakable: false)[
  For completeness, we give the definition of addition and scalar multiplication of complex vectors:

  #definition(title: "Addition and Scalar multiplication of complex vectors")[
    #no-shift[
      $
        "For complex vectors"
        vc(a)=mat(a_1; dots.v; a_n) "and" vc(b)=mat(b_1; dots.v; b_n),quad
        vc(a)+vc(b)=mat(a_1+b_1; dots.v; a_n+b_n),quad
        k vc(a)=mat(k a_1; dots.v; k a_n),
      $<eq:vc-arith>
    ]
    where $k in CC$.
    (Compare with @eq:va-arith-comp: there we only considered $k in RR$, but here $k in CC$.)
  ]]

With these definitions, @thm:va-axiom holds *as is* for complex vectors (compare!):
#theorem[
  For $n$-dimensional complex vectors $vc(a)$ and $vc(b)$ and $p,q in CC$,
  #v-enum(
    cols: 2,
    label-style: "(A)",
  )[
    + $vc(a)+vc(b) = vc(b)+vc(a),$
    + $\(vc(a)+vc(b))+vc(c) = vc(a)+\(vc(b)+vc(c)),$
    + $vc(a)+vc(0)=vc(a),$
    + $vc(a)+(-vc(a))=vc(0),$
    + $p vc(a) + p vc(b) = p\(vc(a)+vc(b)),$
    + $p vc(a) + q vc(a) = (p+q) vc(a),$
    + $(p q)vc(a) = p\(q vc(a)),$
    + $1 vc(a)= vc(a).$
  ]
] <thm:vc-axiom>
Properties in @thm:va-ip-prop are also valid for complex vectors _with slight modifications_.
#theorem(title: "Complex-vector inner product")[
  For $n$-dimensional complex vectors $vc(a)$ and $vc(b)$ and a constant $k in CC$,
  #v-enum(cols: 2, label-style: "(A)")[
    + $cip(a, b)=overline(cip(b, a)),$
    + $cip(a, a) >= 0 "for any vector" vc(a),$
    + $cip(a, a) > 0 "for any vector" vc(a)!=vc(0),$
    + $cip(a, a)=0 <==> vc(a)=vc(0),$
    + $lbk(vc(a)+vc(b), vc(c)) = cip(a, c)+cip(b, c),$
    + $lbk(vc(a), vc(b)+vc(c)) = cip(a, b)+cip(a, c),$
    + $lbk(k vc(a), vc(b)) = overline(k)cip(a, b),$
    + $lbk(vc(a), k vc(b)) = k cip(a, b).$
  ]
]<thm:vc-ip-prop>
Using #thick-sf[(B)] of the above, we can define the #EMPH[magnitude] of complex vectors by
#theorem(title: "Magnitude of complex vectors")[
  #no-shift[$
      "For a complex vector" vc(a)", we define its" #EMPH[magnitude] "by"
      va(a) := sqrt(cip(a, a)).
    $
  ]#index("magnitude (vector)")
]
#theorem(title: "Properties of complex-vector magnitude")[
  For complex vectors $vc(a)$ and $vc(b)$ and a constant $k in CC$,
  $
    |vc(a)| >= 0, wide |vc(a)| = 0 <==> vc(a) = vc(0), wide |k vc(a)| = |k| |vc(a)|, wide |vc(a)+vc(b)| <= |vc(a)| + |vc(b)|.
  $<eq:vc-magnitude-prop>
]<thm:vc-magnitude-prop>
#quizzes[
  + In @eq:vc-magnitude-prop, what do $|k|$ and $|vc(a)|$ mean, respectively? What are their definitions?
  + Compare @thm:vc-ip-prop with @thm:va-ip-prop and find all the differences.
  + Prove #thick-sf[(A)] and #thick-sf[(G)] of @thm:vc-ip-prop using component-wise notation.
  + Prove #thick-sf[(B)] and #thick-sf[(H)] of @thm:vc-ip-prop.
    #hint[(A) and (G) might be useful.]
]

#problems[
  Compare these problems with @thm:va-ip-prop2.
  + `4`
    + Verify $|vc(a) + vc(b)|^2 = |vc(a)|^2 + 2Re cip(a, b) + |vc(b)|^2$.
    + Simplify $|(3+4ii) vc(v)|+|5 vc(v)|.$
    + Expand $lr(size: #120%, |vc(v) - vc(w)|^2)$, $lr(size: #120%, |vc(v) + ii vc(w)|)^2$, and $lr(size: #120%, |vc(v) + k vc(w)|)^2$ with $k in CC$.
  + `3` Prove #thick-sf[(C)], #thick-sf[(D)], #thick-sf[(E)], #thick-sf[(F)] of @thm:vc-ip-prop.
  + `2` Prove @thm:vc-magnitude-prop. Also, prove #keyword[Cauchy-Schwarz inequality], $lr(|cip(a, b)|) <= |vc(a)||vc(b)|.$
]

#make-indent
Linear combinations of complex vectors are defined similarly as real vectors (see @sec:vec-lc); the only difference is that we can use complex coefficients instead of real coefficients.
Linear dependence and independence are defined in the same manner, and @thm:va-lin-dep holds, but the solutions now allow complex numbers.

Recall that the component-wise notation was introduced in @sec:vec-comp with respect to a _specific_ orthonormal basis vectors.
Our discussion in this section is also built over a _specific_ orthonormal basis vectors,
$
  vc(e)_1 = mat(1; 0; dots.v; 0), quad vc(e)_2 = mat(0; 1; dots.v; 0), dots, quad vc(e)_n = mat(0; 0; dots.v; 1), quad "with which"
  vc(v) = mat(v_1; v_2; dots.v; v_n) = sum_(k=1)^n v_k vc(e)_k.
$<eq:vc-comp-basis>
#definition(title: "Orthonormal basis vectors for complex vectors")[
  Assume that we are considering $n$-dimensional _complex_ vectors. If $n$ _complex_ vectors $vc(e)_1, ..., vc(e)_n$ satisfy the following properties, we call them #EMPH[an] #keyword[orthonormal basis] (for complex vectors):

  - All of them are unit vectors, i.e., $|vc(e)_i|=1$ for all $i$.

  - Any of them are perpendicular, i.e., $i!=j ==> lbk(vc(e)_i, vc(e)_j)=0$.

  - We cannot add any more vectors without violating the above two rules.
]<def:vc-ortho-basis>
#quizzes[
  + Compare this definition with @def:va-ortho-basis and find the differences.
  + Check that ${vc(e)_1, ..., vc(e)_n}$ in @eq:vc-comp-basis is a basis.
]

#advanced-note[
  In mathematical literature, you may find different notations for the inner product.
  Most physicists write $cip(a, b)=sum overline(a_k)b_k$, which we use in this document. Meanwhile, mathematicians tend to denote inner products by $\(vc(a), vc(b)\)$ and define it by $\(vc(a), vc(b)\)=sum a_k overline(b_k)$, or even $cip(a, b)=sum a_k overline(b_k)$.
]
