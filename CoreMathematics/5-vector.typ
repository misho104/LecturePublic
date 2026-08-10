#import "misho-text.typ": *
#import "physica.typ": dv  // cspell: disable-line
#import "2-units.typ": writing
#import "@preview/cetz:0.5.2": canvas, draw  // cspell: disable-line
// cspell: ignore Schwarz

// Vector notation: arrow over symbol
#let vc(v) = $accent(#v, arrow)$
#let va(v) = $lr(|vc(#v)|)$
// Unit vector: hat over symbol
#let vcu(v) = $accent(#v, hat)$
#let dm(..args) = math.display(math.mat(..args))

#let vip(a, b) = $vc(#a) dot vc(#b)$

#let xy-plus(p, q) = (p.at(0) + q.at(0), p.at(1) + q.at(1))
#let vector(p, d, label: none, end: "stealth", offset: (0, 0), color: black, thickness: 1.5pt, dash: none) = {
  draw.line(
    p,
    xy-plus(p, d),
    stroke: color + thickness,
    mark: (
      end: end,
      fill: color,
      stroke: color + thickness,
      transform-shape: false,
    ),
    dash: dash,
  )
  if label != none {
    draw.content(
      (
        p.at(0) + d.at(0) / 2 + offset.at(0),
        p.at(1) + d.at(1) / 2 + offset.at(1),
      ),
      label,
    )
  }
}
#let vector-three-ways = enum(
  indent: dim.left-margin - dim.label-sep - dim.label-width,
  body-indent: dim.label-sep,
  tight: false,
  [an arrow in $n$-dimensional space ($n in NN^+$, but usually $n=3$),],
  [a list of $n$ numbers arranged vertically ($n in NN^+$), and],
  [an element of a vector space (such as a Hilbert space).],
)

Physicists understand a vector in three ways:
#vector-three-ways
In this chapter, we will focus on the first two interpretations.
The last interpretation, more abstract and mathematical, will be discussed in #TODO[chap:linear-algebra].

#remark[
  This document discusses vectors mainly in terms of mathematics; more detailed _physical_ discussion about vectors can be found in  Sho's #link("https://misho104.github.io/LecturePublic/", "Vector Boot Camp").#footnote[Visit https://misho104.github.io/LecturePublic and find `gp2_boot2_vector.pdf`.]
]
#be-careful[
  In university, we *never* use the horizontal notation $vc(v)=(x, y, z)$ to describe vectors. Please *always* use the vertical form $vc(v)=mat(x; y; z)$ to be prepared for @chap:matrix.
]
#remark[
  We use the arrow notation $vc(v)$ because this is a first-year lecture.
  Usually, physicists use boldface ($bold(a), bold(x), bold(β)$, etc.) to denote vectors.
]
#advanced-note[
  The discussion in this chapter is only valid for _finite-dimensional_ vectors because here we will define vectors as arrows in a "space".
  As the "space", readers are expected to imagine _the 3d space_ of our Universe, a 2d-sheet of paper in our Universe, or something like those, and then the #EMPH[dimension] of the space (defined in @def:va-dimension) will be limited to a finite integer.
]

= What is a Vector? <sec:vec-intro>

You have seen vectors, such as $(5, -1)$, $(1, 0, 2)$, or $(-1, 3)$, or in the vertical form $mat(1; 2)$, $mat(1; 0; 0)$, etc.
However, it represents a _mathematical_ nature of vectors. As a *physicist*, you have to forget about such expressions in this section (we will return to it in @sec:vec-comp). Instead, we will first _define_ vectors in a more physical way.

#definition(title: "Vector for physicists")[
  Consider a space.
  A #keyword[vector] is a straight arrow drawn in the space, or in general, a quantity that has both #EMPH[magnitude] (= length) and #EMPH[direction] in the space.#index("direction (vector)")#index("magnitude (vector)")
]<def:v-arrow>
We here do not investigate what "the space" is, but you may well imagine a lecture room as the space.
#theorem(type: "Notation", title: "Vectors and Scalars")[
  We denote vectors with an arrow over the symbol, such as $vc(v)$, $vc(F)$, $vc(a)$, $vc(p)$.
  Their magnitudes are written as $va(v)$, $va(F)$, $va(a)$, $va(p)$, respectively.
  Meanwhile, a quantity that has no direction is called a #keyword[scalar]. Symbols without arrows, such as $v$, $F$, $a$, $p$, are scalars.
  #be-careful(indent: false)[
    $v$ and $vc(v)$ are *completely different objects*.
    They are totally unrelated, just as $A$ and $a$ are unrelated.
    However, in physics, we are sometimes _lazy_ enough to write $v$ to mean $va(v)$, the magnitude of $vc(v)$.
    Please not be confused.
  ]
]
#quizzes[
  + Choose scalar quantities. Choose vector quantities.
    #h-enum(cols: (1fr, 1fr, 1fr, 1.2fr, 1.7fr))[
      + $vc(a)$
      + $p$
      + $va(b)$
      + $|g|$
      + magnitude of $vc(v)$
      + mass
      + velocity
      + speed
      + $vc(x) + va(x)$
      + direction of $vc(v)$
    ]
  +
    + What do we call $va(v)$? Also, clearly write down its definition.
    + What do we call $|v|$?   Also, clearly write down its definition.
]
#fail-safe[
  #show math.cases: it => math.display(it)
  For $x in RR$, we define $|x| := cases(gap: #4pt, x quad && "if " x >= 0",", -x &&"if " x < 0,)quad$ and call it "the #keyword[absolute value] of $x$".
]

There is a special vector "#EMPH[zero vector]", which has magnitude $0$ and no direction.
#definition(title: "Zero vector")[
  There is a vector with magnitude 0 and no direction. We call it #EMPH[the] #keyword[zero vector] and denote $vc(0)$.
]
Any other vectors have a direction and *positive* magnitude. Namely,
$ |vc(0)|=0. wide va(v) = 0 <==> vc(v)=vc(0). wide va(v)>0 <==> vc(v) != vc(0). $
#quizzes[
  + Explain why $vc(0) != 0$. Explain why $|vc(0)| = 0$.
]
#advanced-note[
  The uniqueness of $vc(0)$ is easy to prove, once we clarify the definition of "=". Namely, "$vc(a) = vc(b)$" means "$vc(a)$ and $vc(b)$ have the same magnitude and direction". (Try to complete the proof.)
]

= Addition and Scalar multiplication <sec:vec-op>
Like $+$ and $div$ for numbers and $and$ and $or$ for true/false, we have two operations for vectors:

- #EMPH[addition]#index("addition (vector)"): two vectors $vc(a)$ and $vc(b)$ can be added; we write the result by $vc(a) + vc(b)$.

- #EMPH[scalar multiplication]#index("scalar multiplication (vector)"): a vector $vc(a)$ is multiplied by a scalar $k$; we write the result by $k vc(a)$.

#definition(title: "Vector addition")[
  If $vc(a)$ and $vc(b)$ are vectors drawn in the same space, we can define $vc(a)+vc(b)$ by the vector obtained by placing the tail of $vc(b)$ at the head of $vc(a)$.
]<def:va-add>

#grid(
  columns: (auto, 170pt),
  column-gutter: 2em,
  [
    #make-indent
    The triangle in the figure to the right represents this definition: the tail of $vc(b)$ is put at the head of $vc(a)$ to get the blue arrow $vc(a)+vc(b)$.
    You may also use the parallelogram method shown to the right: consider a parallelogram made by $vc(a)$ and $vc(b)$ sharing the same tail. Then its diagonal, the blue arrow, is $vc(a)+vc(b)$.],
  canvas({
    let O = (0, 0)
    let O2 = (3.2, -0.3)
    let A = (1.5, 0)
    let B = (-1.2, 2)
    vector(O, A, label: $vc(a)$, offset: (0, -0.3))
    vector(A, B, label: $vc(b)$, offset: (0.3, 0))
    vector(O, xy-plus(A, B), label: $vc(a)+vc(b)$, offset: (-0.5, 0.25), color: c.blue, thickness: 1.6pt)
    vector(O2, A, label: $vc(a)$, offset: (0, -0.3))
    vector(O2, B, label: $vc(b)$, offset: (0.2, 0.1))
    vector(O2, xy-plus(A, B), color: c.blue, label: $vc(a)+vc(b)$, offset: (0.8, 1))
    vector(xy-plus(O2, B), A, end: none, thickness: 0.7pt, dash: "dashed")
    vector(xy-plus(O2, A), B, end: none, thickness: 0.7pt, dash: "dashed")
  }),
)

#make-indent
Notice that the two horizontal arrows in the figure are both $vc(a)$, although their locations are different. Similarly, both blue arrows show the vector $vc(a)+vc(b)$.
Vectors are the same if and only if they have the same magnitude and direction; location does not matter.
#definition(title: "Scalar multiplication")[
  For a vector $vc(v)$ and a real number (scalar) $k$, we define $k vc(v)$ as follows:

  - if $k > 0$, $k vc(v)$ has the magnitude $|k|va(v)$ and has the same direction as $vc(v)$.

  - if $k < 0$, $k vc(v)$ has the magnitude $|k|va(v)$ and is anti-parallel to $vc(v)$.

  - if $k = 0$, $k vc(v) = vc(0)$.
]<def:va-sca>
#remark[
  The word "#keyword[anti-parallel]" means "in the opposite direction".
  Meanwhile, *we should avoid* the ambiguous word "#keyword[parallel]" for vectors, as it may mean either the same direction or the opposite direction; use the phrase "has the same direction" instead.
  For more vocabulary to describe directions, please check #link("https://misho104.github.io/LecturePublic/", "the Vector Boot Camp").
]
#advanced-note[Watch out we assume $k in RR$ in @def:va-sca. It restricts the discussion in this chapter to _real vectors_. In @sec:comp-vec, we will discuss _complex vectors_ by modifying this definition.]

We should carefully digest these definitions.
Let's see an example, and try the next quiz.
#problem-style-label.update(true)
#example[
  + Explain the meaning of $|k vc(v)|$ and $|k|va(v)$.

  + Prove $|k vc(v)| = |k|va(v)$, where $vc(v)$ is a vector and $k in RR$.

  + Based on the above definitions, explain what $-vc(v)$ is.
]
#solution[
  + $|k vc(v)|$ means the magnitude of a vector $k vc(v)$, which is a scalar multiplication of $vc(v)$ by $k$. Meanwhile, $|k|va(v)$ means the absolute value of $k$ times the magnitude of $vc(v)$.

  + If $k!=0$, then, according to the above definition, $k vc(v)$ has the magnitude $|k|va(v)$ and it means $|k vc(v)|=|k|va(v)$.
    If $k=0$, then $k vc(v)=vc(0)$ and thus $"LHS"=|k vc(v)|=0$, while $"RHS"=0 va(v)=0$.  $qed$

  + $-vc(v)$ is a shorthand notation of $(-1)vc(v)$, the scalar multiplication of $vc(v)$ by $-1$.  So, $-vc(v)$ has the same magnitude as $vc(v)$ but is anti-parallel to $vc(v)$.
]
#problem-style-label.update(false)

#quizzes[
  + Find out how the following vectors are defined based on the above definitions of addition and scalar multiplication.
    #h-enum(cols: (1.3fr, 1fr, 1.3fr, 1fr, 1.3fr, 1.3fr))[
      + $vc(a) + vc(a)$
      + $2 vc(a)$
      + $2 vc(a)+3vc(b)$
      + $-vc(a)$
      + $vc(a)-vc(b)$
      + $- vc(a)-2 vc(b)$
    ]
]

Addition and scalar multiplication have the following properties:
#theorem[
  For vectors $vc(a)$ and $vc(b)$ in the same space and $p,q in RR$,
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
] <thm:va-axiom>
These properties seem obvious, but in fact, they play a fundamental role in #TODO[...].
#problems[

  + `3` Consider a vector $vc(a)!=vc(0)$ and a constant $k in RR$. Consider three vectors $vc(a)$, $k vc(a)$, and $k^2 vc(a)$.
    + Which are in the same direction? Which are anti-parallel to each other?
    + Compare their magnitudes; which are the longest and the shortest?
  + `3` Consider a vector $vc(a)$ and a constant $k$.
    + Write a vector that has magnitude $va(a)$ and is anti-parallel to $vc(a)$.
    + Write a vector that has magnitude $3va(a)$ and is in the same direction as $vc(a)$.
    + Write a vector that has magnitude $3k va(a)$ and is in the same direction as $vc(a)$.
    Vectors with magnitude $1$ are called #keyword[unit vectors].
    #h-enum(cols: 1, label-start: 4)[
      + Write a vector that has magnitude $1$ and is in the same direction as $vc(a)$.\
        (Namely, write a unit vector that has the same direction as $vc(a)$.)
      + Write a unit vector that is anti-parallel to $vc(a)$.
    ]
  + `3` Prove the next "#keyword[triangle inequality]" geometrically, i.e., only with the above definitions.
    $ "For any two vectors" vc(a) "and" vc(b) "in the same space", |vc(a) + vc(b)| <= |vc(a)| + |vc(b)|. $
  + `2` Starting from @def:va-add and @def:va-sca, prove the properties in @thm:va-axiom.
  + `2` Prove that, for any two vectors $vc(a)$ and $vc(b)$ in the same space, $lr(|\|vc(a)\|-\|vc(b)\||) <= |vc(a)-vc(b)|$.
]

#pagebreak()

#restriction[#align(center)[
  Most of the following discussion is only for _real vectors_ and do not apply for _complex vectors_.
]]

= Inner product <sec:vec-ip>
Imagine two arrows. Probably you can think the angle $theta$ between the arrows. The angle leads you to the following *geometric* definition of the inner product.
#definition(title: "Inner product (geometrical definition)")[
  For vectors $vc(a)$ and $vc(b)$ drawn in the same space, the #keyword[inner product] is defined by
  $
    vc(a) dot vc(b) := |vc(a)| |vc(b)| cos theta,
  $
  where $theta$ is the angle between $vc(a)$ and $vc(b)$; if $vc(a) = vc(0)$ or $vc(b) = vc(0)$, then $vc(a) dot vc(b) := 0$.
]<def:va-ip>
#quizzes[
  + Assume the length of $vc(a)$ is 3 and the length of $vc(b)$ is 2.
    + If $vc(a)perp vc(b)$, then what is $vc(a) dot vc(b)$?
    + If $vc(a)$ and $vc(b)$ are anti-parallel, what is $vc(a) dot vc(b)$?
    + What is the maximum value of $vc(a) dot vc(b)$? When is it achieved?
    + If $vc(a) dot vc(b) = -3$, what can you say about the angle between $vc(a)$ and $vc(b)$?
  #fail-safe[
    $vc(a)perp vc(b)$ means that $vc(a)$ and $vc(b)$ are #keyword[perpendicular] to each other, or #EMPH[normal] to each other; in other words, the angle $theta$ between them is $pi\/2=90degree$.
    #index-see("normal (vector)", "perpendicular")
  ]
]
This inner product has the following properties:
#theorem(title: "Real-vector inner product")[
  For vectors $vc(a)$ and $vc(b)$ drawn in the same space and a constant $k in RR$,
  #let vd(x, y) = $vc(#x) dot vc(#y)$
  #v-enum(cols: 2, label-style: "(A)")[
    + $vd(a, b)=vd(b, a),$
    + $vd(a, a) >= 0 "for any vector" vc(a),$
    + $vd(a, a) > 0 "for any vector" vc(a)!=vc(0),$
    + $vd(a, a)=0 <==> vc(a)=vc(0),$
    + $\(vc(a)+vc(b))dot vc(c) = vd(a, c)+vd(b, c),$
    + $vc(a)dot\(vc(b)+vc(c)) = vd(a, b)+vd(a, c),$
    + $\(k vc(a))dot vc(b) = k\(vd(a, b)),$
    + $vc(a)dot \(k vc(b)) = k\(vd(a, b)).$
  ]
  #be-careful[These properties are valid only for "real vectors".]
]<thm:va-ip-prop>

We will skip their proof. Instead, we focus on these four very important properties.
You need to memorize them securely.
#theorem(title: "Properties of real-vector inner product")[
  $ "For a vector" vc(a), quad va(a) = sqrt(vc(a)dot vc(a)). $<eq:vip-norm>
  $ "For non-zero vectors" vc(a) "and" vc(b), quad vc(a)dot vc(b) = 0 <==> vc(a)perp vc(b). $<eq:vip-perp>
  $
    "For vectors" vc(a) "and" vc(b), quad -|vc(a)||vc(b)| <= vc(a)dot vc(b) <= |vc(a)||vc(b)|quad(#keyword[Cauchy-Schwarz inequality]).
  $<eq:vip-schwartz>
  $ "For vectors" vc(a) "and" vc(b), quad |vc(a) + vc(b)|^2 = |vc(a)|^2 + 2 vc(a)dot vc(b) + |vc(b)|^2 $<eq:vip-expand>
  #be-careful[These properties are valid only for "real vectors".]
]<thm:va-ip-prop2>

#quizzes[
  #let vd(x, y) = $vc(#x) dot vc(#y)$
  + Prove the following theorems directly from @def:va-ip.
    + $vc(a) perp vc(b) ==> vd(a, b)=0.$
    + $vd(a, b) = 0 ==> \(vc(a)perp vc(b))or\(vc(a)=vc(0))or\(vc(b)=vc(0)).$
    + $-|vc(a)| |vc(b)| <= vd(a, b) <= |vc(a)| |vc(b)|.$
    + $|vd(a, b)| <= |vc(a)| |vc(b)|.$ #h(1fr)#hint[Recall that $|x|<=3$ means $-3<=x<=3$.]
    + $|vc(a)|^2=vd(a, a)$.
    + $|vc(a)|=sqrt(vd(a, a))$. #h(1fr)#hint[Most students make mistakes in this question.]
  + Prove the following equation, using @def:va-ip, @thm:va-ip-prop, and the equations in the previous quiz.
    #h-enum(cols: 2)[
      + $\(vc(a)+vc(b))dot vc(a) = |vc(a)|^2 + vd(a, b).$
      + $|vc(a) + vc(b)|^2 = |vc(a)|^2 + 2 vd(a, b) + |vc(b)|^2$.
    ]
]

#problems[
  + `3` Two vectors $vc(a)$ and $vc(b)$ satisfy $|vc(a)| = 2$, $|vc(b)| = 3$, and $vc(a) dot vc(b) = 3$.
    Let $x$, $y$ be real numbers.
    + Find the angle between $vc(a)$ and $vc(b)$.
    + Calculate $|vc(a) + vc(b)|$.
    + Calculate the magnitude of $4 vc(a) + 3 vc(b)$ and $x vc(a) + y vc(b)$.
    + Explain why $|x vc(a) + y vc(b)|^2$ is *not* in general equal to $x^2 + y^2$.
    Now let $vc(e)_1$ and $vc(e)_2$ satisfy $|vc(e)_1| = |vc(e)_2| = 1$ and $vc(e)_1 dot vc(e)_2 = 0$.
    Let $p$, $q$ be real numbers.
    #h-enum(label-start: 5, cols: 1)[
      + Find the angle between $vc(e)_1$ and $vc(e)_2$.
      + Explain why $(p vc(e)_1 + q vc(e)_2) dot (x vc(e)_1 + y vc(e)_2) = p x + q y$.
      + Explain why $|x vc(e)_1 + y vc(e)_2| = sqrt(x^2 + y^2)$.
    ]

  + `2` Three vectors $vc(A)$, $vc(B)$, $vc(C)$ satisfy $|vc(A)| = 2$, $|vc(B)| = 3$, $vc(A) dot vc(B) = 3sqrt(2)$, and $vc(A) dot vc(C) = -1$.
    + Find the angle between $vc(A)$ and $vc(B)$.
    + Calculate $|vc(A) + vc(B)|^2$, $|vc(A) - vc(B)|^2$, and $|2 vc(A) + 4 vc(B)|^2$.
    + Calculate $\(vc(A) - 2 vc(B)) dot \(2 vc(A) + vc(B) + vc(C)) + 2 vc(B) dot vc(C)$.
    + Find $k$ such that $|vc(A) + k vc(B)| = sqrt(10)$.
    + Find $c$ such that $vc(B) + c vc(C)$ is perpendicular to $vc(A)$.
]

= Cross product (only for 3d real-vectors) <sec:vec-xp>
For two arrows drawn in three-dimensional space, we can define the #EMPH[cross product].
#definition(title: "Cross product")[
  For $vc(a)$ and $vc(b)$ drawn in a _three-dimensional_ space, the #keyword[cross product] $vc(a) times vc(b)$ is defined as follows:

  - It is a vector with magnitude $|vc(a)times vc(b)|=|vc(a)| |vc(b)| sin theta$, where $theta$ is the angle between $vc(a)$ and $vc(b)$.

  - If $|vc(a)times vc(b)|!=0$, we determine its direction so that $(vc(a)times vc(b))perp vc(a)$ and $(vc(a)times vc(b))perp vc(b)$.

  Here, we always have two possible directions. We impose another condition to make it unique:

  - If you hold the _right_ hand so that your thumb points in the direction of $vc(a)$ and your index finger in the direction of $vc(b)$, your middle finger points in the direction of $vc(a) times vc(b)$.\
    (This is often quoted that "the ordered triple $\(vc(a), vc(b), vc(a) times vc(b))$ obeys the #keyword[right-hand rule]".)
]
We will not discuss much about the cross product, but only the following properties:
#theorem[
  For vectors $vc(a)$, $vc(b)$, $vc(c)$ and real number $k$,
  #v-enum(cols: (1fr, 1.3fr), label-style: "(A)")[
    #let vt(x, y) = $vc(#x) times vc(#y)$
    + $vt(a, a)=vc(0).$
    + $vt(a, b)=-vt(b, a).$
    + $0 <= |vc(a) times vc(b)| <= |vc(a)| |vc(b)|.$
    + $\(k vc(a)) times vc(b) = vc(a) times \(k vc(b)) = k\(vc(a) times vc(b)).$
    + $vc(a)times\(vc(b)+vc(c))=vt(a, b)+vt(a, c).$
    + $vc(a) times vc(b) = vc(0)$ if $vc(a)$ and $vc(b)$ are parallel or anti-parallel.
    + $vc(a) dot (vc(a) times vc(b)) = vc(b) dot (vc(a) times vc(b)) = 0$.
    + $vc(a) dot \(vc(b) times vc(c)) = vc(b) dot \(vc(c) times vc(a)) = vc(c) dot \(vc(a) times vc(b))$.
  ]
]<thm:vxp-prop>
The equation #thick-sf[(B)] is the most important.
For #thick-sf[(A)], notice $vc(a) times vc(a)$ is not "zero".

#advanced-note[
  Geometrical interpretation of the cross product is sometimes useful:
  - $|vc(a)times vc(b)|$ is the area of the parallelogram formed by $vc(a)$ and $vc(b)$.

  - $\(vc(a)times vc(b))dot vc(c)$ is the (signed) volume of the parallelepiped formed by $vc(a)$, $vc(b)$, and $vc(c)$.
]

#problems[
  + `4` Prove #thick-sf[(A)], #thick-sf[(B)], #thick-sf[(C)], #thick-sf[(F)], and #thick-sf[(G)] of @thm:vxp-prop.
  + `2` In physics, we *always* use the #keyword(key: "right-handed system")[right-handed] #keyword[Cartesian coordinate system] to describe our three-dimensional space, which is characterized by three unit vectors $vc(e)_x$, $vc(e)_y$, $vc(e)_z$ defined so that they are perpendicular to each other and $(vc(e)_x, vc(e)_y, vc(e)_z)$ obeys the right-hand rule. Calculate their inner products and cross products, such as $vc(e)_x dot vc(e)_y$ and $vc(e)_x times vc(e)_z$
  + `1` Prove #thick-sf[(B)] of @thm:va-ip-prop and #thick-sf[(E)] of @thm:vxp-prop geometrically (i.e., based on the definitions given in this chapter). Sho has his own proof but not very confident. Can you find a better proof?
]

= Position vectors <sec:vec-pos>
We have defined vectors as arrows. Arrows are not positions, so vectors are not positions. However, _once we define the origin_ O in the space, we can use vectors to represent each position in the space.

#definition(title: "Position vector")[
  Consider a space and fix a point O as the origin. To each point P, we associate the vector $arrow("OP")$ and call it the #keyword[position vector] of P.  We often write $vc(p)=arrow("OP")$, $vc(q)=arrow("OQ")$, and so on.
]
Consider $vc(p)=arrow("OP")$, $vc(q)=arrow("OQ")$, and $vc(r)=arrow("OR")$.
They are obviously dependent on the choice of the origin O. Also, the point described by $vc(p)+vc(q)$ will be different if we chose a different point as the origin.
However, we can check that

- the vector $arrow("PQ")$ is given by $vc(q) - vc(p)$
- the length of the segment PQ is given by $|vc(q)-vc(p)|$.
- the middle point M of the segment PQ has the position vector $vc(m) = (vc(p)+vc(q))\/2$.

These properties are independent of the choice of O. Namely, whatever choice we did for origin, $(vc(p)+vc(q))\/2$ represents the midpoint of PQ.
For further discussion, please check #link("https://misho104.github.io/LecturePublic/", "the Vector Boot Camp").

#problems[
  + `3` Show that the length of the segment PQ is given by $|vc(q)-vc(p)|$, where $vc(p)$ and $vc(q)$ are the position vectors of points P and Q, respectively.
  + `2` Let $vc(p)$, $vc(q)$, and $vc(r)$ be the position vectors of points P, Q, R respectively, which are not on the same line.
    + Show that $(vc(p)+vc(q))\/2$ is the position vector of the midpoint of the segment PQ.
    + Show that $(vc(p)+vc(q)+vc(r))\/3$ is the position vector of the centroid of the triangle PQR.
  + `1` Let $vc(a)$, $vc(b)$, and $vc(p)$ be the position vectors of points A, B, P, respectively. Show the following.
    + #box(width: 10em)[P is on the segment AB] $<==> vc(p) = t vc(a)+(1-t)vc(b) quad "with" 0<= t<= 1$.
    + #box(width: 10em)[P is on the line AB] $<==> vc(p) = t vc(a)+(1-t)vc(b) quad "with" t in RR$.
]

= Linear combination <sec:vec-lc>
#remark[
  This is a bit advanced. You may well come back when you read @chap:matrix.
]
We often consider a #keyword[linear combination]. For example, linear combinations of $x$, $y$, and $z$ are given by $3x + 2y+5z$, $x+sqrt(2)y-1.4z$, $3x-pi y+2z$, $-5z$ $(=0x+0y-5z)$, etc.
Similarly, we can consider linear combinations of vectors.
#definition(title: "Linear combination of vectors")[
  For vectors living in the same space, $vc(a), vc(b), vc(c), ...$, and scalars $p, q, r, ...$, we call $ p thin vc(a) + q thin vc(b)+ r thin vc(c) + dots.c $ a #EMPH[linear combination] of $vc(a), vc(b), vc(c), ...$.

  Some of the coefficients $p, q, r, ...$ may be zero. Also, all the coefficients may be zero, where the linear combination results in $vc(0)$.
]
#advanced-note[It is sometimes important whether the summation allows infinite terms; in this document, we only allows finite summation as a linear combination.]

#definition(title: "Linearly dependent or independent")[
  Consider (a finite number of) vectors $\{vc(a), vc(b), vc(c), ...\}$ in the same space.
  Then, the equation
  $
    p thin vc(a) + q thin vc(b)+ r thin vc(c) + dots.c = vc(0)
  $
  always has a trivial solution $p=q=r=dots.c=0$.
  If there are other solutions, we say that $\{vc(a), vc(b), vc(c), ...\}$ are #keyword[linearly dependent]. Meanwhile, if there is no other solution, we say that they are #keyword[linearly independent].
]
#example[
  #let ss(m, c) = (
    ($lr(\{#m.join($,$)\})$, m.zip((c)).map(i => $#i.at(1) thin #i.at(0)$).join($+$))
  )
  #let (x1, x2) = ss(($mat(1; 0)$, $mat(1; 4)$), ($a$, $b$))
  + The set $x1$ is linearly independent; the equation $x2=vc(0)$ has only one solution $a=b=0$ (_the trivial solution_).

  #let (x1, x2) = ss(($mat(2; 4)$, $mat(1; 2)$), ($a$, $b$))
  + The set $x1$ is linearly dependent because $x2=vc(0)$ has a non-trivial solution $a=1, b=-2$.

  #let (x1, x2) = ss(($mat(1; 0; 0)$, $mat(1; 1; 0)$, $mat(1; 1; 1)$), ($a$, $b$, $c$))
  + The set $x1$ is linearly independent; $x2=vc(0)$ is satisfied only by the trivial solution $a=b=c=0$.

  #let (x1, x2) = ss(($mat(2; 0; 0)$, $mat(0; 2; 2)$, $mat(1; 1; 1)$), ($a$, $b$, $c$))
  + The set $x1$ is linearly dependent; $x2=vc(0)$ has a non-trivial solution $(a,b,c)=(1,1,-2)$.
]
If a set is linearly dependent, at least one vector among them can be described as a linear combination of the other vectors.
For example, in the example above,
$
  "(for the second example)" & quad mat(2; 4) = 2 times mat(1; 2), \
    "(for the last example)" & quad mat(2; 0; 0) = 1 times mat(0; 2; 2) + (-2)times mat(1; 1; 1).
$
So, we may understand that $mat(2; 0; 0)$ is "dependent" on $mat(0; 2; 2)$ and $mat(1; 1; 1)$.
Meanwhile, if a set is linearly independent, it is impossible to do so; every vector in the set is "independent" of the other vectors.

#theorem[
  Consider (a finite number of) vectors $\{vc(a), vc(b), vc(c), ...\}$.

  - If they are linearly dependent, at least one vector among them can be described as a linear combination of the other vectors.

  - If they are linearly independent, it is impossible to do so. Namely, we cannot express any vector among them as any linear combination of the remaining vectors.
]<thm:va-lin-dep>
#quizzes[
  + Consider the following sets of vectors. Determine whether they are linearly dependent or independent.
    #h-enum(cols: 3, v-sep: 0em, fixed-height: 3em)[
      + $lr(\{mat(1; 0), mat(0; 3)\})$
      + $lr(\{mat(1; 0), mat(1; 1)\})$
      + $lr(\{mat(1; 2), mat(3; 4)\})$
      + $lr(\{mat(1; -1), mat(-1; 1)\})$
      + $lr(\{mat(1; 0), mat(2; 0), mat(3; 0)\})$
      + $lr(\{mat(1; 0), mat(3; 3), mat(4; 3)\})$
      + $lr(\{mat(1; 0; 0), mat(0; 1; 0), mat(0; 0; 1)\})$
      + $lr(\{mat(1; 2; 0), mat(4; 8; 1)\})$
      + $lr(\{mat(1; 2; 0), mat(4; 8; 0)\})$
    ]
]
#problems[
  + `4` #TODO[prepare]
  + `3` #TODO[prepare]
  + `2` #TODO[prepare]

]

#pagebreak()


= Intermission: Vector or Scalar or Not <sec:vec-vsn>
Let us summarize the operations on vectors.
With $k$ a real number and $vc(a)$, $vc(b)$ vectors:

#align(center, table(
  columns: (auto, auto, auto),
  stroke: none,
  align: (left, center, left),
  table.hline(),
  [magnitude], [$|vc(a)|$], [$arrow.r$ scalar],
  [scalar multiplication], [$k vc(a)$], [$arrow.r$ vector],
  [addition], [$vc(a) + vc(b)$], [$arrow.r$ vector],
  [inner product], [$vc(a) dot vc(b)$], [$arrow.r$ scalar],
  [cross product], [$vc(a) times vc(b)$], [$arrow.r$ vector (only in 3d)],
  table.hline(),
))
Then, how about them? Try to ensure that you understand the meaning of each operation.

#problems[
  + `9` For each expression, answer *V* if it is a vector, *S* if scalar, and *N* if invalid (not defined).
    Here, $vc(a), vc(b), ...$ are three-dimensional vectors and $a, b, ...$ are scalars (real numbers).
    #h-enum(cols: 5, v-sep: 0em, fixed-height: 3em, block-spacing: (below: 0pt))[
      + $vc(a)$
      + $vc(a)^2$
      + $(vc(a))^2$
      + $|vc(a)|^2$
      + $|a|^2$
      + $vc(0)$
      + $vc(0)+0$
      + $vc(0)+vc(0)$
      + $0dot vc(0)$
      + $vc(0)dot vc(0)$
      //
      + $(med 1 med) / vc(a)$
      + $(med vc(a)med) / vc(a)$
      + $(med vc(a)med) / vc(b)$
      + $1 / (|vc(a)|)$
      + $1 / (|vc(a)|^2)$
      + $1 / (\(vc(a)\)^2)$
      + $vc(a) / (\(vc(a) dot vc(b)\))$
      + $vc(a) / (\(vc(a) dot vc(b)\)^2)$
      + $vc(a) / (|vc(a) dot vc(b)|)$
      + $vc(a) / (\(vc(a) dot vc(b)\))$
      + $sqrt(vc(a)^2)$
      + $sqrt(vc(a))$
      + $sqrt(|vc(a)|)$
      + $sqrt(|a|)$
      + $sqrt(a^2)$
      //
      + $a + 1$
      + $a + vc(a)$
      + $a times vc(a)$
      + $a dot vc(a)$
      + $a vc(a)$
      + $vc(a) + 1$
      + $vc(a) + vc(a)$
      + $vc(a) times vc(a)$
      + $vc(a) dot vc(a)$
      + $vc(a) vc(a)$
      //
      + $a^(-2)$
      + $|vc(a)|^(-2)$
      + $|vc(a)|^(-2)$
      + $|vc(a)|^(-1) vc(a)$
      + $|vc(a)|^(-1\/2) vc(a)$
    ]
    #h-enum(cols: 4, label-start: 41, v-sep: 0em, fixed-height: 3em)[
      + $vc(p) dot vc(q) + vc(p) times vc(q)$
      + $vc(p) times (vc(q) times vc(r))$
      + $vc(p) dot (vc(q) times vc(r))$
      + $p (vc(q) times vc(r))$
      + $(vc(p) times vc(q))^2$
      + $1/(\|vc(x)-vc(r)\|^(3\/2))$
      + $(vc(x)-vc(r))/(\|vc(x)-vc(r)\|^(3\/2))$
      + $(vc(d)times(vc(x)-vc(r)))/(\|vc(x)-vc(r)\|^(3\/2))$
      + $dv(vc(y), x)$
      + $dv(y, vc(x))$
    ]
]


= Axes and Components <sec:vec-comp>
So far, we have considered vectors as arrows drawn in a space. Vectors are characterized only by the magnitude and direction.
Now, we are going to _recall_ the component-wise notation such as $vc(a)=mat(1; 2)$. We define "orthonormal basis vectors" and then see we can _describe an arrow by a list of numbers_.

#index(display: "basis [bases]", "basis")
#definition(title: "Orthonormal basis vectors")[
  If $n$ vectors $vc(e)_1, ..., vc(e)_n$ satisfy the following properties, we call them #EMPH[an] #keyword[orthonormal basis]:

  - All of them are unit vectors, i.e., $|vc(e)_i|=1$ for all $i$.

  - Any of them are perpendicular, i.e., $i!=j ==> vc(e)_i dot vc(e)_j=0$.

  - We cannot add any more vectors without violating the above two rules.

  Precisely speaking, we call the set $\{vc(e)_1, ..., vc(e)_n\}$ "_an_ orthonormal basis". Then, if we fix _one_ orthonormal basis to use, we call its members "orthonormal basis vectors".
]<def:va-ortho-basis>
#fail-safe[A woman, two women. A nucleus, two nuclei. A basis, two bases. A matrix, two matrices.]
#example(title: "Basis vectors for arrows on this sheet")[
  #let p1 = $vc(p)_1$
  #let p2 = $vc(p)_2$
  #let q1 = $vc(q)_1$
  #let q2 = $vc(q)_2$
  #let r = $vc(r)$
  #grid(
    columns: (auto, 120pt),
    column-gutter: 2em,
    [
      Let's limit our "space" to this 2d sheet and consider the five vectors drawn to the right. Assume their length are all "1".

      If we choose #p1 and #p2, they form _an_ orthonormal basis $\{p1, p2\}$ because they are unit vectors, perpendicular to each other, and we cannot add any more.
      Similarly, $\{q1, q2\}$ is _another_ orthonormal basis.
    ],
    canvas({
      vector(thickness: 1pt, (0, 0), (1.5, 0.0), label: p1, offset: (0, -0.3))
      vector(thickness: 1pt, (0, 0), (0.0, 1.5), label: p2, offset: (0.3, 0))
      vector(thickness: 1pt, (2.2, 0.3), (1.2, 0.9), label: q1, offset: (0.2, 0.7))
      vector(thickness: 1pt, (2.2, 0.3), (-0.9, 1.2), label: q2, offset: (-0.1, 0.7))
      vector(thickness: 1pt, (3.5, 0.5), (0, -1.5), label: r, offset: (0.2, 0))
    }),
  )
  #make-indent
  Meanwhile, $\{p1, q2\}$ and $\{p1, p2, q1, q2\}$ are not orthonormal bases because the members are not orthogonal. $\{p1\}$ is not an orthonormal basis because we can add one more vector, such as #r, without breaking the conditions; after adding $#r$, we have an orthonormal basis $\{p1, #r\}$.
]
#quizzes[
  + Consider the figure in the above example. Which sets are orthogonal bases?
    #no-num[
      $
        \{vc(p)_1, -vc(p)_2\},quad
        \{vc(p)_1, vc(r)\},quad
        \{vc(p)_2, vc(r)\},quad
        \{vc(p)_1, vc(p)_2, vc(r)\},quad
        \{vc(q)_1, 2vc(q)_2\},quad
        \{-vc(q)_1, -vc(q)_2\}.
      $
    ]
]
This example shows we can find many orthogonal bases, but *the number* of the members is always two. This number is called the #EMPH[dimension] of the space, and this is why we call "this _2d_ sheet" in the above example.

In general, a space has _infinitely many_ orthonormal bases and we can choose _an_ orthonormal basis at our convenience; we will come back to this point in @sec:mat-basis-change. However, the number of the orthonormal basis vectors, the #EMPH[dimension], is fixed by the space we considered.

#theorem(title: "Properties of orthonormal basis vectors")[
  - Any orthonormal bases of a space have the same number of vectors. We call the number #EMPH[the dimension] of the space.#index("dimension (vector)")

  - If $\{vc(e)_1, vc(e)_2, ..., vc(e)_n\}$ is an orthonormal basis, any arrow $vc(v)$ in the space can be expressed as
    $
      vc(v)= c_1 vc(e)_1 + c_2 vc(e)_2 + dots + c_n vc(e)_n = sum_(k=1)^n c_k vc(e)_k, quad "where" quad c_k in RR
    $<eq:va-lin-comb>
    and this expression is _unique_, i.e., if $vc(v)$ is expressed by
    #no-num[$
      vc(v) & = c_1 vc(e)_1 + c_2 vc(e)_2 + dots + c_n vc(e)_n \
            & = d_1 vc(e)_1 + d_2 vc(e)_2 + dots + d_n vc(e)_n,
    $]
    then all the coefficients are equal: $c_k = d_k$.
]<def:va-dimension>
#quizzes[
  + Show that the numbers $c_k$ in @eq:va-lin-comb are actually determined by $c_k= vc(e)_k dot vc(v).$
]
#advanced-note[This theorem seems not difficult to prove because we only think finite-dimensional spaces, but there could be caveats that Sho did not notice. A more rigorous construction is in #TODO[abs-vec].]

#make-indent
If you choose an orthonormal basis, then it automatically defines the #keyword(display: "axis [axes]")[axes] of the space:<topic:basis-defines-axes>

- For a 2d space, we call the directions of the basis vectors as $x$-axis and $y$-axis, respectively. Sho usually writes the basis vectors by $vc(e)_x$ and $vc(e)_y$, but other textbooks may write as $hat(bold(upright(i)))$ and $hat(bold(upright(j)))$.

- For a 3d space, we call the directions of the basis vectors as $x$-axis, $y$-axis, and $z$-axis, respectively. The basis vectors are expressed by $(vc(e)_x,vc(e)_y,vc(e)_z)$ or $(hat(bold(upright(i))), hat(bold(upright(j))),hat(bold(upright(k))))$. Here, physicists *always* choose the axes so that $vc(e)_x,vc(e)_y,vc(e)_z)$ obeys  the #keyword[right-hand rule] (see @sec:vec-xp).

They are called #keyword(key: "Cartesian coordinate system")[2d Cartesian coordinate system] and #keyword(key: "right-handed system")[3d right-handed Cartesian coordinate system], respectively.
In general, a coordinate system defined by an orthonormal basis is called Cartesian coordinate system.
#index("coordinate system")

Now we are ready to express vectors in their #EMPH[components] because we have reached @eq:va-lin-comb:
#definition(title: "Components of a vector")[
  If we fix an orthonormal basis and label the basis vectors by $vc(e)_1, ..., vc(e)_n$, then @def:va-dimension says any vector $vc(v)$ can be written as
  $vc(v) = c_1 vc(e)_1 + dots + c_n vc(e)_n$ with uniquely determined $c_k := vc(e)_k dot vc(v) in RR.$
  We call $c_k$ #keyword(display: "component")[the $bold(k)$-th component] of $vc(v)$ and express $vc(v)$ with the components as
  $ vc(v) = mat(c_1; c_2; dots.v; c_n)= mat(vc(e)_1 dot vc(v); vc(e)_2 dot vc(v); dots.v; vc(e)_n dot vc(v)). $
]<def:va-comp>
Vectors in $n$-dimensional spaces are called #keyword(key: "$-dimensional vector", display: [$n$-dimensional vector])[$bold(n)$-dimensional vectors].
Since an orthonormal basis in a $n$-dimensional space has $n$ basis vectors, a $n$-dimensional vectors are expressed with $n$ real numbers $c_1, ..., c_n$.

#advanced-note[
  We have to make sure this representation is _well-defined_; we do not want to have two different expressions for one vector, or two different vectors having the same expressions.

  Because $c_k$ is uniquely determined, the component-wise notation is unique for a vector. Meanwhile, if $vc(a)$ and $vc(b)$ are different but have the same component-wise notation, it means $vc(a)-vc(b)=:vc(Delta)$ has the same notation as $vc(0)$ (why?). It means $vc(Delta)\/|vc(Delta)|$ is a unit vector orthogonal to all of $vc(e)_k$, which contradicts that $\{vc(e)_1,dots,vc(e)_n}$ is the basis (why?). Accordingly, different vectors must have different component-wise notation.
]
#index("$-dimensional space", display: [$n$-dimensional space])

#problem-style-label.update(true)
#example[
  Prove the following equations in a 2d space.
  #h-enum(cols: 3, label-style: "(1)")[
    + $display(mat(a; b) + mat(p; q) = mat(a + p; b + q))$
    + $display(mat(a; b) dot mat(p; q) = a p + b q)$
    + $display(lr(|mat(a; b)|) = sqrt(a^2 + b^2))$
  ]]
#solution[
  + Since $dm(a; b)$ means $a vc(e)_x + b vc(e)_y$ and $dm(p; q)$ means $p vc(e)_x + q vc(e)_y$ under some orthonormal basis $(vc(e)_x, vc(e)_y)$,
    #no-num[$
      "LHS" = ( a vc(e)_x + b vc(e)_y ) + ( p vc(e)_x + q vc(e)_y ) =( a +p) vc(e)_x + (b+q) vc(e)_y = "RHS",
    $]
    where we used the equations in @thm:va-axiom. $qed$

  + Similarly, using the equations in @thm:va-ip-prop and @def:va-ortho-basis,
    #no-num[$
      "LHS" & = ( a vc(e)_x + b vc(e)_y ) dot ( p vc(e)_x + q vc(e)_y ) \
      & = a p (vc(e)_x dot vc(e)_x) + b p (vc(e)_y dot vc(e)_x) + a q (vc(e)_x dot vc(e)_y) + b q (vc(e)_y dot vc(e)_y) = a p + b q. qed
    $]

  + Thanks to #thick-sf[(2)], $display("(LHS)"^2 = mat(a; b) dot mat(a; b) = a^2 + b^2)$. Since $"(LHS)" >= 0$, $"LHS"=sqrt(a^2+b^2)="RHS".qed$
]
#problem-style-label.update(false)

#fail-safe[
  In #thick-sf[(3)], you must write #writing[$"LHS" >= 0$]. Without it, you can only claim $"LHS"=±sqrt(a^2+b^2)$.
]

Notice that we _proved_ these equations based on @thm:va-axiom etc.
These equations are not _definitions_ or _assumptions_, but _derived statements_ #footnote[→ @sec:logic-type] with proofs.
There are a few more statements to be proved:

#quizzes[
  + Consider a 2d space.
    #h-enum(cols: 1, label-align: horizon)[
      + Prove $vc(0)=dm(0; 0)$, $vc(e)_x = dm(1; 0)$, and $vc(e)_y = dm(0; 1)$. #hint[Recall $c_k= vc(e)_k dot vc(v)$.]
      + Prove $k dm(a; b)= dm(k a; k b)$, where $k in RR$.
    ]
]
#problems[
  + `3` Consider a 3d space. An orthonormal basis $(vc(e)_x, vc(e)_y, vc(e)_z)$ is taken according to the right-hand rule. Let $vc(a) = dm(a; b; c)$ and $vc(p)=dm(p; q; r)$.
    #h-enum(cols: 1, label-align: horizon)[
      + Prove $vc(0)=dm(0; 0; 0)$, $vc(e)_x = dm(1; 0; 0)$, $vc(e)_y = dm(0; 1; 0)$, and $vc(e)_z = dm(0; 0; 1)$.
      + Prove $k vc(a)+ l vc(b) = dm(k a+l p; k b + l q; k c + l r).$
      + Prove $vc(a)dot vc(p)=a p+b q+c r$ and $|vc(a)|=sqrt(a^2+b^2+c^2)$.
      + Express $vc(a)times vc(p)$ with using $a, b, c, p, q, r$.
    ]
  + `2` Consider a $n$-dimensional space ($n in NN^+$) and an orthonormal basis $(vc(e)_1, ..., vc(e)_n)$ of it. Prove the following.
    - $vc(0) = dm(0; dots.v; 0)$ and $(i"-th component of" vc(e)_j) = display(cases(1 "if "i=j",", 0 "if" i!=j).)$
    - Consider $p, q in RR$ and $n$-dimensional vectors $vc(a)$ and $vc(b)$. Let the $k$-th component of $vc(a)$ be $a_k$ and the $k$-th component of $vc(b)$ be $b_k$. Then, the $k$-th component of $p vc(a) + q vc(b)$ is equal to $p a_k + q b_k$. Also,
      $display(vc(a)dot vc(b) = sum_(k=1)^n a_k b_k)$ and $display(|vc(a)|= sqrt(sum_(k=1)^n a_k^2)).$
]
Let us summarize the above discussion.
#theorem(title: "Component-wise interpretation of real-vector arithmetic")[
  Consider $n$-dimensional real vectors, $display(vc(a)=mat(a_1; dots.v; a_n))$ and $display(vc(b)=mat(b_1; dots.v; b_n))$, and $k in RR$. Then, addition, scalar multiplication by $k in RR$, and inner product are given by, respectively,
  $
    vc(a)+vc(b)=mat(a_1+b_1; dots.v; a_n+b_n), wide
    k vc(a)=mat(k a_1; dots.v; k a_n),
  $<eq:va-arith-comp>
  $
    vc(a)dot vc(b)=sum_(k=1)^n a_k b_k = a_1b_1+a_2b_2+dots+a_n b_n,
  $<eq:va-ip-comp>
]<thm:va-comp-arith>
#be-careful[
  Again, these formulas are _consequences_ of the definitions we gave earlier.  They are *not* new definitions.
]

Since you must be familiar with this component-wise notation and calculations based on it, we do not discuss it further.
Consult your high-school math textbook or Sho's #link("https://misho104.github.io/LecturePublic/", "Vector Boot Camp") if you are not confident in such calculations.

Vectors are closely related to matrices, the main topic of @chap:matrix.
We will there discuss both real and complex matrices, and thus complex vectors will be introduced there. Since complex vectors are not arrows, we need to _define_ complex vectors in a way different from what we did in this chapter.

To prepare for the discussion on complex matrices in @chap:matrix, we first review #EMPH[complex numbers] in the next chapter (@chap:complex).

#problems[
  + `1` Complete the proof in "Advanced Note" after @def:va-comp.
  + `1` When we define a Cartesian coordinate system for a 3d space, we require that $(vc(e)_x, vc(e)_y, vc(e)_z)$ satisfies the right-hand rule. However, similar rules are not required for 2d spaces. Why?
]
