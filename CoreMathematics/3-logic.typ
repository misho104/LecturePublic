#import "misho-text.typ": *
#import "physica.typ": *
#import "2-units.typ": quiz-for-logic, writings

Solve the quiz on #ref(<quiz-for-logic>, form: "page") again.

#let bare(body) = {
  show math.frac: it => [#it.num #sym.slash #it.denom]
  show sym.ast: h(0.05em) + sym.dot.op + h(.05em)
  $upright(#body)$
}
#let unit(body) = $thin bare(body)$
#quiz-for-logic

The answers are obviously

#writings(box: (true, false, true, false, true))[
  $omega = ±1.4 unit(s^(-1))$ ][][
  $t=1.0 unit(s), 2.5 unit(s)$][][
  $x=5.0 unit(m), y=4.0 unit(m)$]

but *what are the correct meaning of these commas or the symbol "±" ?*

#quizzes[
  + `9` Which are the correct meaning? Guess it.

    - [$omega$ is both $+1.4 unit(s^(-1))$ and $-1.4 unit(s^(-1))$] v.s. [$omega$ is either $+1.4 unit(s^(-1))$ or $-1.4 unit(s^(-1))$].

    - [$t$ is both $1.0 unit(s)$ and $2.5 unit(s)$] v.s. [$t$ is either $1.0 unit(s)$ or $2.5 unit(s)$].

    - [$x$ is $5.0 unit(m)$ and $y$ is $4.0 unit(m)$] v.s. [Either $x$ is $5.0 unit(m)$, or $y$ is $4.0 unit(m)$].
]

In elementary educations, these differences are often ignored because kids do not know *logical thinking*; now, you need to do it, as you are a grown-up university student.

= Logic

== Propositions

A #keyword[proposition] is a statement that is either true or false---not both, not neither.
For example, "$2 + 2 = 4$" is a proposition (and it is true). "$x > 3$" is also a proposition, once we know the value of $x$.

We write $P$, $Q$, $R$, ... for propositions.
Each proposition has a #keyword[truth value]: *true* (T) or *false* (F).

#remark[
  Everyday sentences such as "please close the door" or "what time is it?" are not propositions, because they are neither true nor false.
]

== Logical connectives: AND, OR, NOT

Given two propositions $P$ and $Q$, we form new propositions with #keyword[logical connectives].

#keyword[Conjunction] ($P and Q$, read "$P$ AND $Q$") is true *only when both* $P$ and $Q$ are true.

#keyword[Disjunction] ($P or Q$, read "$P$ OR $Q$") is true *when at least one* of $P$ and $Q$ is true.

#keyword[Negation] ($not P$, read "NOT $P$") is true when $P$ is false, and false when $P$ is true.

The #keyword[truth table] below summarises all cases:

#align(center, table(
  columns: (auto, auto, auto, auto, auto),
  stroke: none,
  table.header([$P$], [$Q$], [$P and Q$], [$P or Q$], [$not P$]),
  table.hline(),
  [T], [T], [T], [T], [F],
  [T], [F], [F], [T], [F],
  [F], [T], [F], [T], [T],
  [F], [F], [F], [F], [T],
))

#be-careful[
  In everyday English, "or" often means *exclusive or* (one or the other, but not both). In mathematics and physics, "or" always means *inclusive or*: $P or Q$ is true even when both $P$ and $Q$ are true.
]

#make-indent
Now we can answer the quiz from the previous page.

- $omega = plus.minus 1.4 thin upright(s^(-1))$ means $omega = +1.4 thin upright(s^(-1))$ OR $omega = -1.4 thin upright(s^(-1))$. (Both values satisfy the original equation, but $omega$ has one specific value---either one.)

- $t = 1.0 thin upright(s),\, 2.5 thin upright(s)$ means $t = 1.0 thin upright(s)$ OR $t = 2.5 thin upright(s)$.

- $(x, y) = (5.0 thin upright(m),\, 4.0 thin upright(m))$ means $x = 5.0 thin upright(m)$ AND $y = 4.0 thin upright(m)$ simultaneously.

The comma between separate values means OR; the comma inside a coordinate tuple means AND.

#quizzes[
  + `4` Decide whether the following are propositions. If yes, state whether they are true or false.
    #h-enum(cols: 2)[
      + $3 > 2$
      + $sin(pi) = 0$
      + $x^2 = 4$
      + $x^2 = 4$ when $x = -2$
    ]
  + `4` Let $P$ be "$n$ is even" and $Q$ be "$n$ is divisible by 4". Evaluate $P and Q$, $P or Q$, and $not P$ when $n = 6$ and when $n = 8$.
]

== Implication

A #keyword[conditional statement] (also called an #keyword[implication]) has the form:

#align(center)[*If $P$, then $Q$.* #h(2em) (written $P => Q$)]

Here $P$ is the #keyword[hypothesis] (or condition) and $Q$ is the #keyword[conclusion].

The implication $P => Q$ is false only when $P$ is true and $Q$ is false---you cannot have a true hypothesis lead to a false conclusion.

#align(center, table(
  columns: (auto, auto, auto),
  stroke: none,
  table.header([$P$], [$Q$], [$P => Q$]),
  table.hline(),
  [T], [T], [T],
  [T], [F], [F],
  [F], [T], [T],
  [F], [F], [T],
))

#remark[
  When $P$ is false, $P => Q$ is considered true regardless of $Q$. This may feel strange. Think of the promise: "If it rains, I will bring an umbrella." If it does not rain, you have not broken the promise---no matter what you do.
]

#make-indent
From $P => Q$ we define three related statements:

#align(center, table(
  columns: (auto, auto),
  stroke: none,
  align: (right, left),
  table.header([*Name*], [*Statement*]),
  table.hline(),
  [implication],        [$P => Q$],
  [converse],           [$Q => P$],
  [contrapositive],     [$not Q => not P$],
  [inverse],            [$not P => not Q$],
))

The implication and its contrapositive are *logically equivalent*: $P => Q$ is true exactly when $not Q => not P$ is true. The converse and inverse are also equivalent to each other, but they are *not* equivalent to the original implication.

#example(title: "Contrapositive")[
  Let $P$ be "$n$ is divisible by 4" and $Q$ be "$n$ is even".

  - Implication: "If $n$ is divisible by 4, then $n$ is even." (True.)
  - Contrapositive: "If $n$ is not even, then $n$ is not divisible by 4." (True---and equivalent to the implication.)
  - Converse: "If $n$ is even, then $n$ is divisible by 4." (False: $n = 6$ is a counterexample.)
]
#solution[
  We verify only the implication. If $4 | n$, then $n = 4k$ for some integer $k$, so $n = 2(2k)$---hence $n$ is even. #sym.square
]

#be-careful[
  The converse $Q => P$ is *not* generally equivalent to $P => Q$. Assuming the converse is true is a very common mistake in physics reasoning.
]

== Necessary and sufficient conditions

When $P => Q$, we say:
- $P$ is a #keyword[sufficient condition] for $Q$: knowing $P$ is enough to conclude $Q$.
- $Q$ is a #keyword[necessary condition] for $P$: if $Q$ is false, $P$ cannot be true.

When $P => Q$ *and* $Q => P$ both hold, we write $P <=> Q$ ("$P$ if and only if $Q$", abbreviated #keyword[iff]).
In this case, $P$ and $Q$ are *logically equivalent*, and $P$ is both necessary and sufficient for $Q$.

#example(title: "Necessary vs sufficient")[
  Let $n$ be an integer.

  - "$n$ is divisible by 4" $=>$ "$n$ is even": divisibility by 4 is *sufficient* for $n$ to be even.
  - "$n$ is even" is *necessary* for "$n$ is divisible by 4": an odd number can never be divisible by 4.
  - But the converse fails (as seen above), so they are not equivalent.
]
#solution[
  Already discussed. The key point: sufficient $!=$ necessary. #sym.square
]

#quizzes[
  + `4` For each pair, decide whether the first condition is sufficient, necessary, both (iff), or neither for the second.
    #h-enum(cols: 1)[
      + "$x = 3$" and "$x^2 = 9$".
      + "$x > 0$ and $y > 0$" and "$x y > 0$".
    ]
]

== Quantifiers

Many mathematical statements involve #keyword[quantifiers], which tell us *how many* objects satisfy a condition.

The #keyword[universal quantifier] $forall$ means "for all" (or "for every"):
#align(center)[$forall x, P(x)$ #h(1em) means #h(1em) "$P(x)$ is true for every $x$".]

The #keyword[existential quantifier] $exists$ means "there exists" (or "for some"):
#align(center)[$exists x, P(x)$ #h(1em) means #h(1em) "there is at least one $x$ for which $P(x)$ is true".]

The #keyword[negation] of quantified statements follows De Morgan's rules:
$
  not (forall x, P(x)) quad &<=> quad exists x, not P(x), \
  not (exists x, P(x)) quad &<=> quad forall x, not P(x).
$
In words: to disprove a "for all" statement, you only need *one counterexample*. To disprove a "there exists" statement, you must show the property fails for *every* object.

#example(title: "Negating a quantified statement")[
  Consider the statement "Every real number has a positive square root."

  Formally: $forall x in RR, exists y in RR, y > 0 and y^2 = x$.

  This is false. Its negation is: $exists x in RR, forall y in RR, y <= 0 or y^2 != x$.
  One counterexample: $x = -1$ has no real square root.
]
#solution[
  We only need to exhibit one $x$ for which no such $y$ exists.
  Take $x = -1$. For any real $y$, $y^2 >= 0 > -1$, so $y^2 != x$. #sym.square
]

#be-careful[
  The order of quantifiers matters. $forall x, exists y, P(x,y)$ is *not* the same as $exists y, forall x, P(x,y)$. The first says "for each $x$, we can find a (possibly different) $y$"; the second says "there is one fixed $y$ that works for all $x$".
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
