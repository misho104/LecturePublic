#import "misho-text.typ": *
#import "physica.typ": *
#import "2-units.typ": bare, quiz-for-logic, writings

Solve the quiz on #ref(<quiz-for-logic>, form: "page") again.

#quiz-for-logic

The answers are
~$omega = ±1.4 unit(s^(-1))$,~
~$t=1.0 unit(s), 2.5 unit(s)$,~
~~and~~$x=5.0 unit(m), y=4.0 unit(m)$, but *what do they mean?*

#quizzes[
  + `4` Guess the correct meaning of each of above expressions.
    + #box(width: 1fr)[$omega$ is both $+1.4 unit(s^(-1))$ and $-1.4 unit(s^(-1))$]  v.s.~~~~
      #box(width: 1fr)[$omega$ is either $+1.4 unit(s^(-1))$ or $-1.4 unit(s^(-1))$]
    + #box(width: 1fr)[$t$ is both $1.0 unit(s)$ and $2.5 unit(s)$]  v.s.~~~~
      #box(width: 1fr)[$t$ is either $1.0 unit(s)$ or $2.5 unit(s)$]
    + #box(width: 1fr)[$x$ is $5.0 unit(m)$ and $y$ is $4.0 unit(m)$]  v.s.~~~~
      #box(width: 1fr)[Either $x$ is $5.0 unit(m)$, or $y$ is $4.0 unit(m)$].
]

In elementary educations, these differences are often ignored because kids do not know *logical thinking*; now, you need to do it, as you are a grown-up university student.

= Basic Logics

You have written many equalities and inequalities, such as
$
  3+5=8, quad 6 + 2 = 10, quad 1+3 > -3, quad 1+3 != 0,
  quad 3^3 = 9,quad 1>2, quad "and" quad sin(pi)!=0.
$
An equality or inequality can be #keyword[true] (T) or #keyword[false] (F).
#quizzes[
  + `4` For each of the above statements, state whether it is true or false.
]
Usually, *we only write true things*. When you write something, you need to confirm that it is true.<write-true-things>

We can combine those statements (with a fixed true/false value) with "AND", "OR", and "NOT".

#align(center, table(
  columns: 3,
  align: (center, center, left),
  inset: (x: 1mm),
  stroke: (x: 0pt, y: 0.5pt),
  keyword[and], [(conjunction)], ["$A$ AND $B$" ($A and B$) is true if both $A$ and $B$ are true, and false otherwise.],
  keyword[or],
  [(disjunction)],
  ["$A$ OR $B$" ($A or B$) is true if at least one of $A$ and $B$ is true. False if both are false.],

  keyword[not], [(negation)], ["NOT $A$" ($not A$) is true if $A$ is false, and false if $A$ is true.],
))

Note that "$1+2=3 "OR" 3+4=7$" is true.


#remark[
  This example shows the word "or" is a bit different from everyday English. In daily conversation, _"Sho will eat ramen or sushi tonight"_ usually means "but not both". However, in mathematics, if Sho eats both ramen and sushi for a dinner, the statement _"Sho had sushi or ramen tonight"_ is true.
]
#quizzes[
  + `4` State whether it is true or false for the following statements.
    #h-enum(cols: 2)[
      + $1 + 2 = 3$ and $3 + 4 < 5$.
      + $10 div 3 > 0$ or $10 div 2 > 0$.
      + not ($3 > 5$).
      + $6 + 3 > 0$ and not $(5 - 2 > 0)$.
    ]
]
We can discuss the following statements: are they true or false?

#example({
  let f(w: 40mm, x, y) = list.item[#box(width: w, x) #sym.dots #y]
  (
    list(
      //      tight: false,
      f[If $x > 5$, then $x > 1$.][This is true.],
      f[If $x < 9$, then $x < 2$.][This is false, because we have a counterexample $x = 5$.],
      f[If $x^2 < 1$, then $x<1$.][This is true.],
      f[If $x^2 = 1$, then $x=-1$.][This is false, because we have a counterexample $x=1$.],
    )
      + [We often write $P=>Q$ to mean "If $P$, then $Q$". So,]
      + list(
        //       tight: false,
        f(w: 50mm, [$x > 5 => x > 1$], [This is the first example above, and true.]),
        f(w: 50mm, [$(x^2=4 and x<0) => (x = -2)$.], [This is true. Recall "$and$" means "and".]),
      )
  )
})
To claim a statement is _false_, you need to find one #keyword[counterexample]. In the second example above, $x=5$ satisfies $x < 9$ but does not satisfy $x < 2$, so it is one counterexample.
Meanwhile, it is more difficult to claim a statement is _true_; you need to write a #keyword[proof].

#advanced-note[
  In formal logic, we need to write, e.g.,
  $forall x in RR, (x > 5) => (x > 1),$
  to be more precise that we are thinking of all real numbers (but not complex numbers).
  Physicists usually omit the $forall$-part, but it may help your understanding if you keep it in mind.
]

= Equivalent Statements---What does "solve" mean?

You have solved many equations. But what does "solving an equation" mean?

#quizzes[
  +
    + Choose the true statements.

      #h-enum(cols: 2, label-style: "(a)")[
        + $2x - 1 = 0 quad => quad x=1\/2$.
        + $x^2 = 4 quad => quad x=-2$.
        + $2x - 1 = 0 quad => quad x > -10.$
        + $x^2 = 4 quad => quad x = 0$.
        //      + $(x+y=2) and (x-y=0) quad => quad (x=1) and (y=1)$.
      ]
    + Do you think these statements can be considered as "solving an equation"?
]
Among the statements, (a) and (c) are correct, and (a) looks "solving an equation", but (c) is not.
So, the symbol "$=>$" is not enough to characterize "solving the equation".
#quizzes[
  + Choose the true statements.

    #h-enum(cols: 1, label-style: "(a)")[
      + $(2x - 1 = 0 quad => quad x=1\/2)$~~~~and~~~~$(2x - 1 = 0 quad arrow.l.double quad x=1\/2)$
      + $(x^2 = 4 quad => quad x=-2)$~~~~and~~~~$(x^2 = 4 quad arrow.l.double quad x=-2)$.
      + $(2x - 1 = 0 quad => quad x > -10)$~~~~and~~~~$(2x - 1 = 0 quad arrow.l.double quad x > -10)$.
      + $(x^2 = 4 quad => quad x = 0)$~~~~and~~~~$(x^2 = 4 quad arrow.l.double quad x = 0)$.
      //      + $(x+y=2) and (x-y=0) quad => quad (x=1) and (y=1)$.
    ]
]
Here, only (a) is true. In (b), the second half (#sym.arrow.l.double) is true but the first half (#sym.arrow.r.double) is false.
In (c), the first half (#sym.arrow.r.double) is true as we saw above, but the second half is false. [Quiz: find one counterexample.]

We use the symbol $<=>$ to express both $=>$ and $arrow.l.double$ at the same time.

#theorem(type: "Definition", title: "Equivalent")[
  If both $A => B$ and $A arrow.l.double B$ are true, we call "$A$ and $B$ are #keyword[equivalent]", and write $A <=> B$.
]
#remark[
  We can discuss if $A<=>B$ is true or not.
  For example, "$x^2=4 <=> x=2$" is false and "$x^2=4 <=> (x=2 or x=-2)$" is true. However, *we usually write true things only* (see #ref(<write-true-things>, form: "page")). So, if you write $A<=>B$, you are claiming $A$ and $B$ are equivalent.
]
If the statement "$A=>B$" is true, then

- $B$ is called a #keyword[necessary condition] for $A$, because $B$ is necessary for $A$; if not $B$, then not $A$.

- $A$ is called a #keyword[sufficient condition] for $B$, because if $A$ is true, $B$ is "sufficiently" true.

So, if $A$ and $B$ are equivalent, $B$ (resp. $A$) is called _necessary-and-sufficient condition_ for $A$ (resp. $B$).

#divider()

We may understand that "solving an equation" means "finding an equivalent equation".
So, when you solve an equation, you have to check that the solution is *necessary and sufficient*.

- If you don't check necessity, you may have an "incomplete solution".

- If you don't check sufficiency, you may have an "extraneous solution".

#quizzes[
  + `4`
    + Solve $sqrt(x + 2) = x$. You might find an "extraneous solution", which you need to _exclude_ it.
    + Solve $sqrt(x^2)=4$. You might find an "incomplete solution", where you need to find more solutions.
  #fail-safe[
    Recall that $sqrt(x^2)=x$ is incorrect. (What should it be?)
  ]
]


#problems[
  + `9` State whether each compound statement is true (T) or false (F). ($3>1$ is T; $2>5$ is F; $1=1$ is T; $0>1$ is F.)

    *AND / OR / NOT*
    #h-enum(cols: 3)[
      + $(3>1) and (2<5)$
      + $(3>1) and (2>5)$
      + $(3>1) or (2>5)$
      + $(3<1) or (2>5)$
      + $not(3>1)$
      + $not(2>5)$
      + $not(3>1) and (2<5)$
      + $(3>1) and not(2>5)$
      + $not((3>1) and (2<5))$
      + $not((3>1) or (2>5))$
      + $(3>1) or not(2<5)$
      + $not(3>1) or not(2<5)$
    ]

    *Implication $=>$* (state T or F; if F, give a counterexample)
    #h-enum(cols: 2)[
      + $x = 2 => x^2 = 4$
      + $x^2 = 4 => x = 2$
      + $x = 0 => x^2 = 0$
      + $x^2 = 0 => x = 0$
      + $x > 2 => x > 0$
      + $x > 0 => x > 2$
      + $x = 3 => |x| = 3$
      + $|x| = 3 => x = 3$
      + $(x=1) or (x=-1) => x^2 = 1$
      + $x^2 = 1 => (x=1) or (x=-1)$
      + $(x>0) and (y>0) => x y > 0$
      + $x y > 0 => (x>0) and (y>0)$
    ]

    *Equivalence $<=>$* (state T or F)
    #h-enum(cols: 2)[
      + $x = 2 <=> x^2 = 4$
      + $x^2 = 4 <=> (x=2 or x=-2)$
      + $x = 0 <=> x^2 = 0$
      + $x > 0 <=> x^2 > 0$
      + $|x| = 2 <=> (x=2 or x=-2)$
      + $x(x-1) = 0 <=> (x=0 or x=1)$
      + $x^2 = x <=> (x=0 or x=1)$
      + $x + 1 = 0 <=> x = -1$
    ]

  + `9` Solve each equation. State the complete solution set, including all real solutions. If there is no real solution, say so.

    #h-enum(cols: 3)[
      + $sqrt(x) = 3$
      + $sqrt(x - 1) = 2$
      + $sqrt(x + 3) = x - 1$
      + $sqrt(2x + 1) = x$
      + $|x| = 5$
      + $|x - 2| = 3$
      + $|2x + 1| = 7$
      + $|x + 4| = 0$
      + $x^2 + 1 = 0$
      + $x^2 + 4 = 0$
    ]

  + `4` Each of the following "solutions" contains a logical error. Identify the error and find the correct solution set.

    + A student solves $x^2 - 3x = 0$ by dividing both sides by $x$, obtaining $x - 3 = 0$, so $x = 3$. What is wrong? Find the complete solution set.
    + A student solves $x^2 = 9$ and writes $x = 3$. What is wrong? Find the complete solution set.
    + A student solves $(x-1)(x+2) = 0$ by dividing both sides by $(x+2)$, obtaining $x - 1 = 0$, so $x = 1$. What is wrong?
    + A student solves $x = sqrt(x^2)$ and concludes this holds for all real $x$. Is this correct?

  + `3` For each pair of statements $A$ and $B$, determine the relationship: $A => B$ only, $B => A$ only, $A <=> B$, or neither.

    + $A$: $x^2 - 5x + 6 = 0$. ~~~ $B$: $x = 2$ or $x = 3$.
    + $A$: $x > 0$ and $y > 0$. ~~~ $B$: $x + y > 0$.
    + $A$: $|x - 1| < 1$. ~~~ $B$: $0 < x < 2$.
    + $A$: $x^2 = y^2$. ~~~ $B$: $x = y$.
    + $A$: $sin(theta) = 0$. ~~~ $B$: $theta = 0$.

  + `3` De Morgan's laws state:
    $ not(A and B) <=> (not A) or (not B), wide not(A or B) <=> (not A) and (not B). $
    Verify each law using a truth table (list all four combinations of T/F for $A$ and $B$).

  + `3` For each statement, write its negation in a natural form (do not just write "it is not the case that..."). Then state whether the original or its negation is true.

    + $x^2 >= 0$ for all real $x$.
    + There exists a real $x$ such that $x^2 = -1$.
    + $x > 0 => x^2 > 0$ for all real $x$.
    + $|x| = x$ for all real $x$.

  + `2` Each step below is labelled with either $=>$ or $<=>$. Find all incorrectly labelled steps and explain why.
    $
      x^2 - x = 0 & quad arrow.r.double.long quad x(x-1) = 0                   && "(factor)" \
                  & quad arrow.l.r.double.long quad x = 0 quad "or" quad x = 1 && "(zero product)" \
    $
    $
      sqrt(x+1) + 1 = x & quad arrow.r.double.long quad sqrt(x+1) = x - 1            && "(rearrange)" \
                        & quad arrow.r.double.long quad x + 1 = (x-1)^2              && "(square both sides)" \
                        & quad arrow.l.r.double.long quad x + 1 = x^2 - 2x + 1       && "(expand)" \
                        & quad arrow.l.r.double.long quad x^2 - 3x = 0               && "(rearrange)" \
                        & quad arrow.l.r.double.long quad x = 0 quad "or" quad x = 3 && "(factor)" \
    $
]

#pagebreak()

= A few more about logic
The statement $A => B$ is read by _"if $A$, then $B$"_, but also by _"$B$ if $A$"_. Similarly, we may read $A <=> B$ by _"$B$ if and only if $A$"_. We abbreviate it as "$B$ #keyword[iff] $A$".

In general, $A => B$ and $B => A$ are different. However, if $A=>B$, then $not B => not A$ ($"not" A => "not" B$) is always correct.
It is called the #keyword[contrapositive] of $A => B$.
Let's see an example.

#example[
  If $0 < x < 2$, then $x^2$ is always less than 4.  We can write it by $(0<x<2) => (x^2 < 4)$.
  Let $A$ be the statement "$0 < x < 2$" and $B$ be the statement "$x^2 < 4$".
  "Not $A$" is "$x <= 0$ or $x >= 2$. Meanwhile, "not $B$" is "$x^2 >= 4$".

  - Its #keyword[conversion] ($A arrow.l.double B$) is $(x^2 < 4) => (0 < x < 2)$, which is false (counterexample: -1).

  - Its #keyword[inversion] ($"not" A => "not" B$) is $(x <= 0 "or" x >= 2) => (x^2 >= 4)$, which is false.

  - Its contrapositive ($"not" A arrow.l.double "not" B$) is $(x^2 >= 4) => (x <= 0 "or" x >= 2)$, which is true.
]
Because the contrapositive of a true statement is always true, we can prove a statement by proving its contrapositive. This method is called _proof by contrapositive_.
#quizzes[
  + `4` For each of the following statements, write its conversion, inversion, and contrapositive. Then state whether each of them is true or false.

    #h-enum(cols: 2)[
      + If $x > 3$, then $x > 0$.
      + If $x = 2$, then $x^2 = 4$.
      + If $|x| = 0$, then $x = 0$.
      + If $x^2 = 4$, then $x = 2$ or $x = -2$.
    ]
]

// !AI d: not(or) とか not(and) の，ド・モアブル？ド・モルガン？もやrないといけないんだった。。。。

#pagebreak()
= Assumptions, definitions, and conclusions

A large source of confusion in university physics is mixing up three types of statements:

#align(center, table(
  columns: (auto, 1fr),
  stroke: none,
  align: (left, left),
  table.hline(),
  [*Assumption* (#keyword[hypothesis])],
  [A statement we *declare to be true* for the purpose of an argument. Example: "Let $m = 2.0 thin unit("kg")$." We do not prove it; we simply accept it.],
  table.hline(stroke: 0.3pt),
  [*Definition*],
  [A statement that *gives meaning* to a symbol or concept. Example: "Let $v := dv(x, t)$." A definition is true by construction; it cannot be wrong.],
  table.hline(stroke: 0.3pt),
  [*Conclusion* (#keyword[deduction])],
  [A statement that is *derived* from assumptions and definitions by logical steps. Example: "Therefore $v = 3.0 thin unit(m/s)$." Its truth depends on the truth of the assumptions.],
  table.hline(),
))

#remark[
  In a calculation, every line is one of these three types. Being clear about which type each line is will prevent many errors.
]

#make-indent
Here is a typical example of how the three types appear together:

#example(title: "Types of statements in a calculation")[
  A particle moves as $x(t) = 3t^2 + 1 thin unit(m)$. Find the velocity at $t = 2.0 thin unit(s)$.
]
#solution[
  - *Definition*: Let $v(t) := dv(x, t)$. (This defines what "velocity" means here.)
  - *Deduction*: $v(t) = 6t thin unit(m/s)$. (Derived by differentiating.)
  - *Assumption*: $t = 2.0 thin unit(s)$. (Given in the problem.)
  - *Deduction*: $v(2.0 thin unit(s)) = 12 thin unit(m/s)$. (Substituting the assumption.) #sym.square
]

#be-careful[
  A common mistake is to treat a *conclusion* as if it were an *assumption*.
  For example, from $x^2 = 9$ you can deduce $x = 3$ or $x = -3$.
  But you *cannot* then assume $x = 3$ without justification and use it to derive further results---unless the problem or context confirms it.
  The solution $x = 3$ is a conclusion, not a new assumption.
]

#quizzes[
  + `4` In the following solution, label each line as "assumption", "definition", or "deduction".

    #tab[
      A spring has spring constant $k = 50 thin unit("N/m")$.
      A block of mass $m = 2.0 thin unit("kg")$ is attached.
      Let $omega := sqrt(k slash m)$.
      Then $omega = 5.0 thin unit(s^(-1))$.
      The period is $T = 2pi slash omega = 1.26 thin unit(s)$.
    ]
]

== Assumptions change conclusions

The previous section defined assumptions and conclusions in the abstract. Let us see what happens in practice when we change the assumptions.

Consider the equation
$ a x^2 + b x + c = 0. $ <quadratic>
A student is asked to "solve for $x$." What does that mean?
It means: *given assumptions about $a$, $b$, $c$, deduce the value(s) of $x$.*

#example(title: "Solving a quadratic---carefully")[
  Solve @quadratic for $x$.
]
#solution[
  We must state our assumptions before deducing anything.

  *Case 1.* Assume $a = 0$ and $b = 0$ and $c = 0$.
  Then every $x$ satisfies @quadratic. The conclusion is: $x$ can be any real number.

  *Case 2.* Assume $a = 0$ and $b = 0$ and $c != 0$.
  Then @quadratic becomes $c = 0$, which contradicts $c != 0$.
  The conclusion is: there is no solution.

  *Case 3.* Assume $a = 0$ and $b != 0$.
  Then @quadratic becomes $b x + c = 0$, so $x = -c/b$.
  The conclusion is: $x = -c/b$.

  *Case 4.* Assume $a != 0$.
  Then we may divide by $a$. Completing the square gives
  $ x = (-b plus.minus sqrt(b^2 - 4 a c)) / (2a), $
  provided $b^2 - 4 a c >= 0$. (If $b^2 - 4 a c < 0$, there is no real solution.)
  #sym.square
]

#be-careful[
  Many students jump straight to Case 4 and write $x = (-b plus.minus sqrt(b^2 - 4 a c))/(2 a)$ without checking whether $a = 0$.
  This is a logical error: the formula is a *conclusion* that is only valid *under the assumption $a != 0$*.
  If $a = 0$, the formula gives division by zero---which is undefined.

  In physics, variables like $a$ or $m$ are often assumed nonzero without comment, because the physical context makes it obvious.
  But in mathematics, and in any careful argument, you must state every assumption explicitly before you draw a conclusion from it.
]

#make-indent
This is the essence of logical thinking in problem-solving:

#align(center, block(inset: 1em, stroke: 0.5pt, radius: 4pt)[
  *Every conclusion is valid only under specific assumptions.*\
  Change the assumptions, and the conclusion may change.
])

#quizzes[
  + `4` A student writes the following solution to "solve $m x = F$ for $x$":
    #tab[$x = F/m$.]
    What assumption is missing? What happens if that assumption is violated? Write a complete solution that covers all cases.

  + `3` Solve $x^2 = k$ for $x$, carefully stating all assumptions and covering all cases (consider $k > 0$, $k = 0$, $k < 0$).

  + `4` In each transformation below, state whether the step is $<=>$, $=>$ only, or $arrow.l$ only (for real $x$). Justify briefly.
    #h-enum(cols: 1)[
      + $x - 1 = 0 quad ? quad x = 1$.
      + $x^2 = 1 quad ? quad x = 1$.
      + $x(x-1) = 0 quad ? quad x - 1 = 0$.
      + $(x-2)^2 = 0 quad ? quad x = 2$.
    ]
  + `4` For each pair, decide whether the first condition is sufficient, necessary, both (iff), or neither for the second.
    #h-enum(cols: 1)[
      + "$x = 3$" and "$x^2 = 9$".
      + "$x > 0$ and $y > 0$" and "$x y > 0$".
    ]
]

#problems[
  + `4` Let $P(x)$ be "$x^2 > 0$". Write the negation of each statement and decide whether the original and the negation are true (for $x in RR$).
    #h-enum(cols: 2)[
      + $forall x, P(x)$
      + $exists x, not P(x)$
    ]

  + `3` Show that "If $a^2 = b^2$ then $a = b$" is false by giving a counterexample. Write the contrapositive, the converse, and the inverse. Determine which of the four statements are true.

  + `3` Suppose $P => Q$ and $Q => R$. Prove $P => R$. (This is called the *law of syllogism*.)

  + `2` Let $P$, $Q$, $R$ be propositions. Using truth tables or logical rules, show that
    $ (P => Q) and (P => R) quad <=> quad P => (Q and R). $
]

#problems[
  + `4` The statements 1--6 and the expressions A--F each describe the same logical meaning. Match each numbered statement with the lettered expression that means the same thing.

    #grid(
      columns: (1fr, 1fr),
      gutter: 1em,
      align(left)[
        + $A and (not B)$
        + $not A and not B$
        + $not (A and B)$
        + $not (A or B)$
        + $(not A) or (not B)$
        + $A or (not B)$
      ],
      align(left)[
        #set enum(numbering: "A.")
        + $not (not A or B)$
        + $not A and not B$
        + $not B or not A$
        + $not (A and B)$
        + $(not A) or (not B)$
        + $not (not A and B)$
      ],
    )
]


#advanced-note[In this lecture, we do not discuss #keyword[quantifiers], such as $forall$ and $exists$.]

