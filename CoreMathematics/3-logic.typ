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

== Statements and truth values

A #keyword[statement] is a sentence that is either true or false---not both, not neither.
We call this its #keyword[truth value]: *true* (T) or *false* (F).

For example:
- "$2 + 2 = 4$" is a statement. Its truth value is T.
- "$3 > 5$" is a statement. Its truth value is F.
- "$sin(pi) = 0$" is a statement. Its truth value is T.

We use capital letters $P$, $Q$, $R$, ... as short names for statements.

#remark[
  "Please close the door" and "Is it raining?" are not statements, because they are neither true nor false.
]

== Logical connectives: AND, OR, NOT

Given statements $P$ and $Q$, we form new statements with #keyword[logical connectives].

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

#quizzes[
  + `4` Let $P$ be "$6$ is even" (T) and $Q$ be "$6$ is divisible by $4$" (F). Find the truth values of $P and Q$, $P or Q$, $not P$, and $not Q$.
]

== Open sentences

An expression such as "$x^2 = 4$" or "$x > 3$" contains a variable $x$.
Its truth value depends on the value of $x$---it is not T or F by itself.
We call such an expression an #keyword[open sentence].

Once we fix a value of $x$, an open sentence becomes a statement with a definite truth value:
- "$x^2 = 4$" is T when $x = 2$ or $x = -2$, and F for any other real $x$.
- "$x > 3$" is T when $x = 5$, and F when $x = 1$.

Open sentences also combine with AND, OR, and NOT---but only after we fix the value of the variable (or specify the set of values we care about).

#remark[
  In high school, you wrote equations with the silent assumption that each line is true.
  For instance, solving $x^2 - 5x + 6 = 0$, you wrote
  $ x^2 - 5x + 6 = 0 quad => quad (x-2)(x-3) = 0 quad => quad x = 2 quad "or" quad x = 3. $
  Each line is an open sentence, and "$=>$" says: any $x$ that makes the left side true also makes the right side true.
  You were doing logical reasoning---just without saying so.
]

#make-indent
Now we can answer the quiz from the previous page.

- $omega = plus.minus 1.4 thin unit(s^(-1))$ means $(omega = +1.4 thin unit(s^(-1)))$ OR $(omega = -1.4 thin unit(s^(-1)))$. Both values satisfy the original equation, but $omega$ has one specific value---either one.

- $t = 1.0 thin unit(s),\, 2.5 thin unit(s)$ means $(t = 1.0 thin unit(s))$ OR $(t = 2.5 thin unit(s))$.

- $(x, y) = (5.0 thin unit(m),\, 4.0 thin unit(m))$ means $(x = 5.0 thin unit(m))$ AND $(y = 4.0 thin unit(m))$ simultaneously.

The comma between separate values means OR; the comma inside a coordinate tuple means AND.

#quizzes[
  + `4` State the truth value of each open sentence for the given value of $x$.
    #h-enum(cols: 2)[
      + $x^2 = 4$ when $x = -2$
      + $x^2 = 4$ when $x = 3$
      + $x > 0$ when $x = -1$
      + $x^2 > x$ when $x = 2$
    ]
  + `4` Let $P(n)$ be "$n$ is even" and $Q(n)$ be "$n$ is divisible by 4". Find the truth values of $P(n) and Q(n)$, $P(n) or Q(n)$, and $not P(n)$ when (i) $n = 6$ and (ii) $n = 8$.
]

== What does "solve" mean?

You have solved many equations. But what does it mean exactly?

#align(center, block(inset: 1em, stroke: 0.5pt, radius: 4pt)[
  To *solve* an equation for $x$ means: find *all* values of $x$ that make the equation true---no more, no less.
])

"No more, no less" has two parts:
- *No less* (#keyword[exhaustiveness]): do not miss any solution.
- *No more* (#keyword[no extraneous solutions]): do not include values that do not satisfy the equation.

Both errors are common. Let us look at each.

#example(title: "Missing a solution")[
  Solve $x^2 = 4$.
]
#solution[
  The equation $x^2 = 4$ is true when $x = 2$ and also when $x = -2$, and false for every other real $x$.
  So the complete answer is: $x = 2$ OR $x = -2$, often written $x = plus.minus 2$.

  Writing only $x = 2$ is *incomplete*: it misses $x = -2$. #sym.square
]

#be-careful[
  Taking a square root does not simply give $x = sqrt(4) = 2$.
  It gives $|x| = 2$, which means $x = 2$ OR $x = -2$.
  Forgetting the negative root is one of the most common errors in high-school and university physics.
]

#make-indent
The set of all solutions is called the #keyword[solution set].
A correct solution is one whose solution set matches exactly.

#example(title: "Extraneous solution")[
  Solve $sqrt(x + 2) = x$.
]
#solution[
  Squaring both sides: $x + 2 = x^2$, so $x^2 - x - 2 = 0$, giving $(x-2)(x+1) = 0$,
  i.e., $x = 2$ or $x = -1$.

  But squaring can introduce false solutions, so we must check:
  - $x = 2$: $sqrt(4) = 2$. ✓
  - $x = -1$: $sqrt(1) = 1 != -1$. ✗

  The solution set is $\{2\}$ only. #sym.square
]

#remark[
  Why did $x = -1$ appear? Squaring $sqrt(x+2) = x$ gives the same equation as squaring $sqrt(x+2) = -x$.
  So we solved a slightly different (broader) equation by accident, and picked up an extra solution.
  Checking is not optional---it is part of the solution.
]

#quizzes[
  + `4` A student solves $x^2 - 3x = 0$ by dividing both sides by $x$ and gets $x = 3$. What is wrong? Find the complete solution set.
  + `4` Solve $|x - 1| = 3$. Verify both answers.
]

== Assumptions, definitions, and conclusions

A large source of confusion in university physics is mixing up three types of statements:

#align(center, table(
  columns: (auto, 1fr),
  stroke: none,
  align: (left, left),
  table.hline(),
  [*Assumption* (#keyword[hypothesis])], [A statement we *declare to be true* for the purpose of an argument. Example: "Let $m = 2.0 thin unit("kg")$." We do not prove it; we simply accept it.],
  table.hline(stroke: 0.3pt),
  [*Definition*], [A statement that *gives meaning* to a symbol or concept. Example: "Let $v := dv(x,t)$." A definition is true by construction; it cannot be wrong.],
  table.hline(stroke: 0.3pt),
  [*Conclusion* (#keyword[deduction])], [A statement that is *derived* from assumptions and definitions by logical steps. Example: "Therefore $v = 3.0 thin unit(m/s)$." Its truth depends on the truth of the assumptions.],
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

#make-indent
Implication connects naturally to equation solving.
When you transform an equation step by step, you are writing a chain of implications.
There are two kinds of step, and they are not the same:

- A step is #keyword[$=>$] (one-way) if the new equation follows from the old one, but not necessarily vice versa.
- A step is #keyword[$<=>$] (two-way, #keyword[equivalent]) if the two equations are true for exactly the same values of $x$.

For example:
$
  x = 3 &quad => quad x^2 = 9  &&quad "(squaring: one-way)" \
  x^2 = 9 &quad => quad x = 3 quad "or" quad x = -3 &&quad "(taking square root)"
$
The first step is only $=>$, not $<=>$: squaring loses the sign of $x$.
A chain of $<=>$ steps is ideal because it means your solution set is exactly correct.
A chain containing even one $=>$ step means you may have introduced #keyword[extraneous solutions] and must check each answer.

#example(title: "Extraneous solutions")[
  Solve $sqrt(x+2) = x$.
]
#solution[
  $
    sqrt(x+2) = x &quad => quad x + 2 = x^2 quad "(squaring: only =>)" \
                  &quad <=> quad x^2 - x - 2 = 0 \
                  &quad <=> quad (x-2)(x+1) = 0 \
                  &quad <=> quad x = 2 quad "or" quad x = -1.
  $
  Because we used $=>$ in the first step, we must check both candidates.
  - $x = 2$: $sqrt(4) = 2$. ✓
  - $x = -1$: $sqrt(1) = 1 != -1$. ✗ (extraneous)

  The only solution is $x = 2$. #sym.square
]

#be-careful[
  When a step is only $=>$, you do not lose solutions---you may *gain* false ones.
  When a step is only $arrow.l$ (the reverse direction fails), you may *lose* solutions.
  Multiplying both sides by an expression that could be zero is a common source of $arrow.l$-only steps.
]

#quizzes[
  + `4` In each transformation below, state whether the step is $<=>$, $=>$ only, or $arrow.l$ only (for real $x$). Justify briefly.
    #h-enum(cols: 1)[
      + $x - 1 = 0 quad ? quad x = 1$.
      + $x^2 = 1 quad ? quad x = 1$.
      + $x(x-1) = 0 quad ? quad x - 1 = 0$.
      + $(x-2)^2 = 0 quad ? quad x = 2$.
    ]
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
