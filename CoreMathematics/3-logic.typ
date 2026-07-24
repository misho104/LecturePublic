#import "misho-text.typ": *
#import "physica.typ": *
#import "2-units.typ": bare, writings

#let bT = math.upright("T")
#let bF = math.upright("F")

Solve @quiz:for-logic (on #ref(<quiz:for-logic>, form: "page")) again.

#context {
  set enum(numbering: n => thick-sf([(#n)]))
  tab[
    #query(selector(figure.where(kind: "quiz")).before(<quiz:for-logic>)).last().body.children.at(2)
  ]
}

The answers are
#h-enum(cols: (1fr, 1fr, 1fr, 0.2fr), label-width: 3.7em, label-style: "(1)")[
  + $omega = ±1.4 unit(s^(-1))$
  + $t=1.0 unit(s), 2.5 unit(s)$
  + $x=5.0 unit(m), y=4.0 unit(m)$
]
but *what do they mean?*

#quizzes[
  + Guess the correct meaning of each of above expressions.
    + #box(width: 1fr)[$omega$ is both $+1.4 unit(s^(-1))$ and $-1.4 unit(s^(-1))$]  v.s.~~~~
      #box(width: 1fr)[$omega$ is either $+1.4 unit(s^(-1))$ or $-1.4 unit(s^(-1))$]
    + #box(width: 1fr)[$t$ is both $1.0 unit(s)$ and $2.5 unit(s)$]  v.s.~~~~
      #box(width: 1fr)[$t$ is either $1.0 unit(s)$ or $2.5 unit(s)$]
    + #box(width: 1fr)[$x$ is $5.0 unit(m)$ and $y$ is $4.0 unit(m)$]  v.s.~~~~
      #box(width: 1fr)[Either $x$ is $5.0 unit(m)$, or $y$ is $4.0 unit(m)$].
]

Elementary educations do not discuss these differences because kids do not know *logical thinking*. Now, you are a grown-up university student. You need to think about it.

= Basic Logics

Since elementary school, you have written many equalities and inequalities, such as
#no-num(comma-gap: auto, $3+5=8, 6+2=10, 1+3>-3, 1+3!=0, 3^3=9, 1>2, "and" quad sin(pi)!=0.$)
#quizzes[
  + The above statements are either #keyword[true] (T) or #keyword[false] (F).  For each of them, state whether it is true or false.
  + Confirm that the following statements are all true:
    #h-enum(cols: 2)[
      + $3+5=8$ is true.
      + $6 + 2 = 10$ is false.
      + $3 != 3$ is false.
      + False is false.
      + "False is false" is true.
      + "False is true" is false.
    ]
]
We can only write true things, such as "$3+5=8$", "$3^2=9$ is true", or "$6+2=10$ is false".
In other words, *when you write something, you must confirm that it is true.*<write-true-things>
Sometimes, you are asked to confirm a statement, or #EMPH[prove] a statement. The process is called #keyword[proof] of the statement.

Numbers can be manipulated by operators such as $+$, $div$. Similarly, true (T) and false (F) can be manipulated by #keyword(display: "and operator", "and"), #keyword(display: "or operator", "or"), and #keyword(display: "not operator", "not") operators.
#table(
  columns: 3,
  align: (center, center, left),
  inset: (x: 1mm),
  stroke: (x: 0pt, y: 0.5pt),
  [and], [(conjunction)], ["$A$ and $B$" ($A and B$) is true if both $A$ and $B$ are true, and false otherwise.],
  [or],
  [(disjunction)],
  ["$A$ or $B$" ($A or B$) is true if at least one of $A$ and $B$ is true. False if both are false.],

  [not], [(negation)], ["not $A$" ($not A$) is true if $A$ is false, and false if $A$ is true.],
)
#index-see("conjunction", "and")
#index-see("disjunction", "or")
#index-see("negation", "not")
#grid(
  columns: (2fr, .2fr, 1.3fr),
  align: bottom,
  [We can write these property as equations:
    #table(
      columns: (2fr, 5fr),
      align: left,
      stroke: none,
      inset: (left: 1em),
      $(bT and bT) = bT,$, $(bT and bF) = (bF and bT) = (bF and bF) = bF,$,
      $(bF or bF) = bF,$, $(bT or bT) = (bT or bF) = (bF or bT) = bT,$,
      $(not bT) = bF,$, $(not bF) = bT,$,
    )
    but the #keyword[truth table], shown to the right, is more useful.
  ],
  [],
  [#table(
    columns: 5,
    align: center,
    stroke: (x, y) => (left: if x == 2 { .3pt } else { 0pt }, y: 0.5pt),
    $A$, $B$, $A "and" B$, $A "or" B$, $"not" A$,
    $bT$, $bT$, $bT$, $bT$, $bF$,
    $bT$, $bF$, $bF$, $bT$, $bF$,
    $bF$, $bT$, $bF$, $bT$, $bT$,
    $bF$, $bF$, $bF$, $bF$, $bT$,
  )<tab:truth>],
)



#remark[
  Note that "$1+1 = 2 "or" 2+2 = 4$" is true, which says the word "or" is a bit different from everyday English. In daily conversation, _"Sho will eat ramen or sushi tonight"_ usually means "but not both". However, in mathematics, if Sho eats both ramen and sushi for a dinner, the statement _"Sho had sushi or ramen tonight"_ is true.
]
#quizzes[
  + State whether it is true or false for the following statements.
    #h-enum(cols: 2)[
      + $1 + 2 = 3$ and $3 + 4 < 5.$
      + $10 div 3 > 0$ or $10 div 2 > 0.$
      + $not (3 > 5)$.
      + $(6 + 3 > 0) and not (5 - 2 > 0).$
    ]
]
#fail-safe[
  Don't be confused by daily English.
  #list(
    marker: "",
    ["$x=1$ and $x=-1$ are the two solutions of $x^2=1$." (correct daily English)],
    ["$x^2=0$ if and only if $x=1$ or $x=-1$." (correct mathematical English)],
  )
  are both correct, but if you say "#RED[$x=1 "and" x=-1$]", then it means an impossible equality #RED[$x=1=-1$].
]
= Implication ⟹


We can discuss the following statements: are they true or false?

#example({
  let f(w: 40mm, x, y) = list.item[#box(width: w, x) #sym.dots #y]
  list(
    //      tight: false,
    f[If $x > 5$, then $x > 1$.][This is true. (Number larger than $5$ are larger than 1.)],
    f[If $x < 9$, then $x < 2$.][This is false, because we have a counterexample $x = 5$.],
    f[If $x^2 < 1$, then $x<1$.][This is true.],
    f[If $x^2 = 1$, then $x=-1$.][This is false, because we have a counterexample $x=1$.],
  )
})
<ex:implications>
In general, it is easy to claim that a statement is false, i.e., to _refute_ or _disprove_ a statement.
You just have to find one #keyword[counterexample].
Meanwhile, it is more difficult to claim that a statement is true. As mentioned above, you need to write a proof.

Now, let's try to find some counterexamples.
#quizzes[
  + The following statements are false. Find a counter example for each.
    #h-enum(cols: (2fr, 3fr))[
      + If $x^2 > 0$, then $x > 0$.
      + If $x^2-x = 0$, then $x=0$.
      + If $x^2=y^2$, then $x = y$.
      + If $x+y<1$, then $x < 1$ and $y<1$.
    ]
]

We use the symbol "$=>$" to express "if ... then ..." statement.
#writings(
  box: (true, false, true, false, true),
  $A==>B$,
  [means],
  [If $A$ is true, then $B$ is true.],
  [or equivalently,],
  [$A$ implies $B$.],
)
and this is called  #keyword[implication]. For example, the statements in the above quiz can be written as
#no-num(comma-gap: auto, $x^2>0 => x>0, x^2-x=0 => x=0, x^2=y^2 => x=y, x+y<1 => x<1 and y<1.$)
#quizzes[
  + Similarly rewrite the statements in @ex:implications with using the symbol "$==>$".
]

#advanced-note[
  In formal logic, $A=>B$ is defined by $(not A) or B$, which means "if $A$ is true, $B$ must also be true; but if $A$ is false, we do not care about $B$". So, if $A$ is always false, $A=>B$ is always true, no matter what $B$ is. For example, $(x in RR and x^2 < -1) => x=999$ is a true statement.
  Through this definition, it is clear that $A=>B$ is equivalent to $not B => not A$, which we will see below.
]

= Equivalent Statements---What does "solve" mean?

Since elementary school, you have solved many equations, but what does "solving an equation" mean?

#quizzes[
  +
    + Choose the true statements.

      #h-enum(cols: 2, label-style: "(a)")[
        + $2x - 1 = 0 ==> x=1\/2.$
        + $x^2 = 4 ==> x=2.$
        + $2x - 1 = 0 ==> x > -10.$
        + $x^2 = 4 ==> x = 0.$
        //      + $(x+y=2) and (x-y=0) quad => quad (x=1) and (y=1)$.
      ]
    + Do you think these statements can be considered as "solving an equation"?
]
(b) and (d) are false statements (find counterexamples!), so we cannot write them. (a) and (c) are true statements, and (a) looks "solving an equation", but we do not consider (c) is "solving an equation".
The difference between (a) and (c) is that
#no-num[$2x - 1 = 0 <== x=1\/2 quad "is true, but" quad 2x - 1 = 0 <== x > -10 quad "is false."$]
So, for (a), both $==>$ and $<==$ are correct: we use $<==>$ to express such cases.

#definition(title: "Equivalent")[
  If both $A ==> B$ and $A <== B$ are true, we call "$A$ and $B$ are #keyword[equivalent]", and write $A <==> B$.
]
$A=>B$ is read by "$B$ if $A$" in English. Similarly, $A <=> B$ is read by "$B$ if and only if $A$" or "$B$ #keyword[iff] $A$". (namely, #EMPH[if]-and-only-i#EMPH[f]).



Now you need to do a bit of practice. It is actually tough, unfortunately, but this drill is important for logical thinking.

#problems[
  #let b = $thick #blank() thick$
  + `9` Fill in the blanks with $==>$, $<==$, or $<==>$, where $x$ is a real number.
    #h-enum(cols: 3)[
      + $x=2 #b x>0$
      + $x > 1 #b x > 0$
      + $x=1 #b x>0$
      + $x = -3 #b x^2 = 9$
      + $x = 0 #b x^2 = 0$
      + $x < 0 #b x^2 > 0$
      + $x=3 #b x != 5$
      + $3x=3 #b x = 1$
      + $x^3=x^2 #b x = 1$
    ]
]


If the statement "$A=>B$" is true, then

- $B$ is called a #keyword[necessary condition] for $A$, because $B$ is necessary for $A$; if not $B$, then not $A$.

- $A$ is called a #keyword[sufficient condition] for $B$, because if $A$ is true, $B$ is "sufficiently" true.

So, if $A$ and $B$ are equivalent, $B$ (resp. $A$) is called _necessary-and-sufficient condition_ for $A$ (resp. $B$).
For example, because $x=1 ==> x^2=1$,

- $x=1$ is sufficient to satisfy $x^2=1$. #h(2em) ($x=1$ is a sufficient condition for $x^2=1$.)

- $x^2=1$ is necessary to satisfy $x=1$.  #h(2em) ($x^2=1$ is a necessary condition for $x=1$.)

#quizzes[
  + Fill in the blanks with "a sufficient condition" or "a necessary condition".
    #h-enum(cols: 2)[
      + $x=-1$ is #blank() for $x^2=1$.
      + $x^2=4$ is #blank() for $x=2$.
      + $x>1$ is #blank() for $x>0$.
      + $x^2>0$ is #blank() for $x<0$.
      + $x<0$ is #blank() for $x^2>0$.
      + $x^2>0$ is #blank() for $x>0$.
    ]
]
#divider()

"To solve an equation" means "to find an _equivalent_ equation in the form of $x=#blank()$". Since
$2x-1=0 <=> x=1\/2$ and $x^2=4 <=> x=±2$, we say $x=1\/2$ and $x=±2$ are the solutions of the equations, respectively.

When you solve an equation, you have to check that the solution is *necessary and sufficient*.

- If you don't check necessity, you may have an "incomplete solution".

- If you don't check sufficiency, you may have an "extraneous solution".

#quizzes[
  +
    + Solve $sqrt(x + 2) = x$. You might reach an _extraneous solution_, which you need to _exclude_ it.
    + Solve $sqrt(x^2)=4$. You might reach an _incomplete solution_, where you need to find more solutions. (Hint: $sqrt(x^2)=x$ is a false statement.)
]

Before discussing advanced topics on logics, you should do some drills.

#problems[
  #let b = $#h(.6em) #blank() #h(.6em)$
  #let blr(content) = $lr(size: #150%, content)$
  + `9` State whether each statement is true (T) or false (F). For example, $2 > 5$ is "F".
    #h-enum(cols: 3)[
      + $(3>1) and (2<5)$
      + $3<1 or 2>5$
      + $not(3>1)$
      + $not(2>5)$
      + $(not(3<1)) and (2<5)$
      + $not(3<1 and 2<5)$
      + $(4=4) and not(2>5)$
      + $(3<1) or not(3=1)$
      + $(not(3<1)) or not(3>1)$
    ]
  + `9` State whether each statement is true or false. If false, give a counter example.
    #h-enum(cols: 2)[
      + $"If" x = 2, "then" x^2 = 4.$
      + $"If" x^2 = 4, "then" x = 2.$
      + $x^2 = 0 ==> x = 0$
      + $x > 2 ==> x > 0$
      + $x > 0 ==> x > 2$
      + $x = 3 ==> |x| = 3$
      + $(x=1) or (x=-1) ==> x^2 = 1$
      + $x^2 = 1 ==> (x=1) or (x=-1)$
    ]
  + `4` Solve each equation, assuming $x$ is a real number.
    #h-enum(cols: 4)[
      + $sqrt(x) = 3$
      + $sqrt(x - 1) = 2$
      + $|x| = 5$
      + $|x| = lr(|-3|)$
      + $sqrt(x^2) = 3$
      + $|x^2| = 5$
      + $|x - 2| = 3$
      + $|2x + 1| = 7$
    ]
  + `2` Solve each equation, assuming $x$ is a real number.
    #h-enum(cols: 3)[
      + $sqrt(x-3) = 2$
      + $sqrt(x-3) = x-3$
      + $sqrt(x-3) = 3-x$
      + $sqrt((x - 3)^2) = 2$
      + $sqrt((x - 3)^2) = x-1$
      + $sqrt((x - 3)^2) = x-3$
      + $sqrt((x - 3)^2) = 3-x$
      + $sin x = 1\/2$
      + $tan x = 0$
    ]

  + `4` Let $x$ and $y$ be real numbers. Fill in the blanks with $==>$, $<==$, or $<==>$. If your answer is $==>$ or $<==$, explain the reason by giving relevant counter examples.
    #h-enum(cols: (1fr, 1.5fr))[
      + $x = 2 #b x^2 = 4$
      + $x^2 = 4 #b x=2 or x=-2$
      + $x > 0 #b x^2 > 0$
      + $|x| = 2 #b (x=2 or x=-2)$
      + $x + 1 = 0 #b x = -1$
      + $x^2 = x #b x(x-1)=0 #b x=0$
      + $sqrt(x)=123 #b x=123^2$
      + $sqrt(x^2)=0 #b x=0$
      + $sqrt(x^2)=3 #b x=3$
      + $sqrt(x^2)=3 and x>0 #b x=3$
      + $sqrt(x^2)=sqrt(y^2) #b x=y$
      + $x+y>0 #b x>0 and y>0$
      + $x y=0 #b x=y=0$
      + $x^2+y^2 = 0 #b x=y=0$
    ]
  + `2` Let $a$ be a real constant and $x$ be a real number. For (1)--(4), fill in the blanks with $==>$, $<==$, or $<==>$. If your answer is $==>$ or $<==$, explain the reason by counter examples.
    #h-enum(cols: 2)[
      + $sqrt(x)=4 #b x= 16$
      + $sqrt(x^2)=4 #b x= 4$
      + $sqrt(x)=a^2 #b x=a^4$
      + $sqrt(x^2)=a^2 #b x=a^2$
    ]
    #h-enum(cols: 1, label-start: 5)[
      + Solve the equation $sqrt(x^2)=a$, noting that $a$ can be negative.
    ]
  + `4` The following "solutions" have logical errors. Identify errors and find the right answer.

    + A student solves $x^2 = 9$ and writes $x = 3$.
    + He solves $x^2 - 3x = 0$ by dividing both sides by $x$, obtaining $x - 3 = 0$, so $x = 3$.
    + He solves $x^6 = x^4$ by dividing both sides by $x^4$, obtaining $x^2=1$, so $x = ±1$.

    Next, fill in the blanks  with $==>$, $<==$, or $<==>$.

    #h-enum(cols: (1fr, 2fr), label-start: 4)[
      + $x^2=9 #b x=3$
      + $x^2-3x=0 #b x-3 = 0 #b x=3$
    ]
    #h-enum(cols: 1, label-start: 6)[
      + $x^6 = x^4 #b x^2 = 1 #b x=±1$
    ]
  + `2`
    + Recall that $A=>B$ is defined by $(not A) or B$. Also, recall that $A<=>B$ is defined by $A=>B and A arrow.l.double B$.
      Write a truth table (see #ref(<tab:truth>, form: "page")) for $A=>B$, $A arrow.l.double B$, and $A<=>B$.
    + Explain the reason we can understand $A<=>B$ as $A=B$.
    + Write a truth table for the following expressions:
      #no-num(comma-gap: auto, $A and B, not(A and B), (not A)or(not B), not(A or B), (not A)and(not B)$)
      Explain that this truth table is considered as a _proof_ of #keyword[de Morgan's theorem]
      $
        not(A or B) = (not A)and(not B), quad quad not(A and B) = (not A)or(not B).
      $
    + Prove the following, which we will discuss in the next section.
      $ blr((A=>B)) =blr(((not B)=>(not A))), quad quad blr((A=>B)) =not blr((A and not B)). $<proofs>
    <prob:de-morgan>

  + `2` This lecture does not cover #keyword[quantifiers] "for-all $forall$" and "exists $exists$". Learn them by yourselves. In particular, prove the following:
    #h-enum(cols: 2)[
      + $exists x, P(x) <==> not blr((forall x, not P(x)))$
      + $not blr((exists x, P(x))) <==> forall x, not P(x)$
      + $forall x, P(x) <==> not blr((exists x, not P(x)))$
      + $not blr((forall x, P(x))) <==> exists x, not P(x)$
    ]
  + `2` For each statement, write its negation, such as "not (#box[$x>=0$] for all real $x$)", in a natural form. Then, state whether the original statement and the negated one are true or false.
    #h-enum(cols: (1fr, 1.3fr))[
      + $x^2 >= 0$ for all real $x$.
      + There exists a real $x$ such that $x^2 = -1$.
      + For all real $x$, $x > 0 => x^2 > 0$.
      + $|x| = x$ for all real $x$.
    ]
]

#pagebreak()

= A few more notes about logic and proof

There is a useful theorem for "not" operator, called #keyword[de Morgan's theorem].
#theorem(title: "De Morgan's theorem")[
  + "not (A and B)" is equivalent to "(not A) or (not B)", i.e., $not(A and B) = (not A) or (not B)$.

  + "not (A or B)" is equivalent to "(not A) and (not B)", i.e., $not(A or B) = (not A) and (not B)$.
]
The proof is given as @prob:de-morgan.

#quizzes[
  + Simplify the following statements by using de Morgan's theorem.
    #h-enum(cols: 2)[
      + $"not" (("not" A) "or" ("not" B))$
      + $"not" (("not" A) "and" ("not" B))$
      + $not ((not A) and (not B))$
      + $not (A or not B)$
    ]
  + For each of the following, write its negation ("not A").
    #h-enum(cols: 3)[
      + $x>0$ or $x<1$.
      + $x != 4$ and $x != 5$.
      + $0<x<1$.
      + $x>0$ or $y>0$.
      + $x=0$ and $y=0$.
      + $x!=0$ and $y!=0$.
    ]
]

#make-indent
In general, $A => B$ and $B => A$ are different. However, if $A=>B$, then $not B => not A$ ($"not" B => "not" A$) is always correct.
It is called the #keyword[contrapositive] of $A => B$.
Let's see an example.

#example[
  If $0 < x < 2$, then $x^2$ is always less than 4.  We can write it by $(0<x<2) => (x^2 < 4)$.
  Let $A$ be the statement "$0 < x < 2$" and $B$ be the statement "$x^2 < 4$".
  "Not $A$" is "$x <= 0$ or $x >= 2$". Meanwhile, "not $B$" is "$x^2 >= 4$".

  - Its #keyword[converse] ($A arrow.l.double B$) is $(x^2 < 4) => (0 < x < 2)$, which is false (counterexample: $x = -1$).

  - Its #keyword[inverse] ($"not" A => "not" B$) is $(x <= 0 "or" x >= 2) => (x^2 >= 4)$, which is false.

  - Its #keyword[contrapositive] ($"not" A arrow.l.double "not" B$) is $(x^2 >= 4) => (x <= 0 "or" x >= 2)$, which is true.
]
Because the contrapositive of a true statement is always true, we can prove a statement by proving its contrapositive. This method is called #keyword[proof by contrapositive].
#quizzes[
  + For each of the following statements, write its converse, inverse, and contrapositive. Then state whether each of them is true or false.
    #h-enum(cols: 2)[
      + If $x > 3$, then $x > 0$.
      + If $x = 2$, then $x^2 = 4$.
      + If $|x| = 0$, then $x = 0$.
      + If $x^2 = 4$, then $x != 3$.
    ]
  + Prove the following statements by _proof by contrapositive_. Namely, first write the contrapositive, then prove it.
    #h-enum(cols: (1fr, 1.5fr))[
      + If $x^2 > 1$, then $|x| > 1$.
      + If $x^3 + x^2 + x < 0$, then $x < 0$.
      + If $x y != 0$, then $x != 0$.
      + If $n^2$ is not integer, then $n$ is not integer.
    ]
]
Another powerful method is #keyword[proof by contradiction] (deductio ad absurdum). Imagine you prove "if $A$, then $B$". You assume "$A$" and "not $B$" are both true, and derive a contradiction. If you reach a contradiction, it means "$A$ and not $B$" is false, i.e., "not ($A$ and not $B$)" is true, which means $A=>B$.
#quizzes[
  + Prove the following statements by _proof by contradiction_.
    + If $x^2$ is an even integer, then $x$ cannot be an odd integer.
    + If $a$, $b$, and $c$ are integers and $a b c$ is even, at least one of $a$, $b$, or $c$ is even.
]

#remark[The validity of "proof by contrapositive" and "proof by contradiction" was already discussed on #ref(form: "page", <proofs>), @proofs.]

#advanced-note[
  You learned another useful method for proof, #keyword[mathematical induction], in high school. In university, you may learn more advanced methods, such as #keyword[infinite descent] and #keyword[transfinite induction].
]


= Facts, Definitions, Assumptions, and Conclusions

One of the main reasons students find university physics difficult is that they treat all statements in the same way.
In physics, every statement has its own role:

- #box(width: 13em)[experimental fact]
- #box(width: 13em)[definition]                  (in mathematics: definition)
- #box(width: 13em)[assumption / approximation]  (in mathematics: axiom or assumption)
- #box(width: 13em)[derived statements]          (in mathematics: theorem, corollary, or proposition)

You should always know which role each statement plays.

#remark[Mathematics does not have experimental facts because it is not based on experiments; it is purely based on definitions.]

#example(title: "Types of statements in a calculation")[
  A particle moves as $x(t) = k t^2 + x_0$, where $k$ and $x_0$ are constants. Find the averaged velocity between $t=0$ and $t=t_0$.
]

#solution[
  #show math.frac: math.display
  We should first clarify assumptions and definitions:

  - #text-sf[Assumptions (explicitly written):] $x(t) = k t^2 + x_0$. $k$ and $x_0$ are constants.

  - #text-sf[Assumptions (implicit):] $k$, $x_0$, and $t_0$ are real numbers, and $t$ means time.

  - #text-sf[Definition]: averaged velocity is _defined_ by $v_"avg" := (x(t_0)-x(0)) / (t_0 - 0)$.

  Now, we can calculate $(x(t_0)-x(0)) / (t_0 - 0) = ((k t_0^2 + x_0) - x_0) / t_0 = k t_0$ to give a derived statement:

  - #text-sf[Derived statement (conclusion)]: the averaged velocity between $t=0$ and $t_0$ is $v_"avg" = k t_0$.
]
#quizzes[
  + Carry out a similar discussion for "find the instantaneous velocity at $t=t_1$".
]

Consider an *experimental fact*, such as "gravity is always attractive". We have to accept it. We need to remember it and understand what it says.
"Protons have charge $+|e|$ and electrons have charge $-|e|$" is another experimental fact, but we can understand it as the definition of the elementary charge $|e|$.

*Definitions* often appear as mathematical equations, such as "instantaneous velocity is defined by $v(t) := dv(style: "horizontal", x, t)$".
Another example is "uniform circular motion is a motion with constant speed along a circle"; here, the word "uniform circular motion" is defined.

Meanwhile, *assumption* is what we can impose freely. For example, you can decide whether you ignore air resistance or not. However, every conclusion is valid only under its assumptions. If you impose bad assumptions, your conclusion will be meaningless. For example, if you want to analyze the free fall of a sheet of paper but you ignore air resistance, your result should be invalid and meaningless. You must be very careful when you make assumptions.

#remark[
  We often use "$A:=B$" to say "define $A$ by $B$". For example, $v(t) := dv(style: "horizontal", x, t)$ is the definition of instantaneous velocity, and $T := 1\/f$ is the definition of period.
  Meanwhile, "$A=B$" just means "$A$ is equal to $B$".

  Some physicists use $A ≡ B$ to say "$A$ is defined by $B$", but Sho does not recommend it because mathematicians use the symbol $≡$ for other purposes.
]

#problems[
  + `4` Prove the following statements by contrapositive or contradiction.
    + $x^2 + y^2 = 0 ==> x = 0$.
    + $a b = 0 ==> a = 0 "or" b = 0$.
    + $a b = 0 <== a = 0 "or" b = 0$.
  + `4` With de Morgan's theorem, rewrite the following statements in a form without "not".
    #h-enum(cols: 2)[
      + not ($x > 0$ and $y > 0$)
      + not ($x = 0$ or $y = 0$)
      + not (if $x > 1$, then $x^2 > 1$)
      + not ($x > 0$ iff $x^2 > 0$)
    ]
  + `4` Find the logical error: Let $a = b = 1$. Then $a^2 = a b$, so $a^2 - b^2 = a b - b^2$. So, $(a - b)(a + b) = b(a - b)$, which gives $a + b = b$, so $2 = 1$.

  + `3` For each of the following statements, write its converse, inverse, and contrapositive.   State T or F for the original statement, its converse, inverse, and contrapositive.
    + If $x^2 - 5x + 6 = 0$, then $x = 2$ or $x = 3$.
    + If $x > 0$ and $y > 0$, then $x + y > 0$.
    + If $x$ and $y$ are both even integers, then $x y$ is divisible by 4.
  + `3` A student claims: "I proved $not B => not A$, so I have proved $B => A$." Is this correct? Explain, and state what the student has actually proved.
  + `3` The following two statements look similar but are logically different. For each, state whether it is T or F and explain.
    + For all real $x$: if $x > 0$, then $x^2 > 0$.
    + For all real $x$: if $x^2 > 0$, then $x > 0$.
  + `3` True or false? Give a reason.
    #h-enum(cols: 1)[
      + The contrapositive of a false statement is also false.
      + If $A => B$ is true and $B => A$ is false, then $A$ and $B$ are not equivalent.
      + If $A$ is false, then $A => B$ is always true, for any $B$.
    ]

  + `1`
    + What is a #keyword[proposition]?
    + Prove the following statements on propositions $P$, $Q$, and $R$.
      + $(P => Q and Q => R) ==> P => R$. #h(1em) (#keyword[syllogism])
      + $(P => Q) and (P => R) <==> P => (Q and R).$
]
