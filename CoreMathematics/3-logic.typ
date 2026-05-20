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

// !AI describe: Start a new section on logics. Write a chapter discussing basic "logic" for university freshmen.
