#import "misho-text.typ": *
#let metadata = (
  title: "Core Mathematics",
  description: "A Lecture note for \"Mathematics for Fundamental Physics\".",
  copyright-years: [2024–2025],
  subtitle: "A Practical Guide on Mathematics for Physics Learners",
  revision: "v0.0.1",
)
#show: misho-text.with(metadata)

#import "title.typ": title
#title(metadata, [
  This document is a set of lecture notes for first-year university students in physics or physical science.
  The notes cover the mathematical tools most immediately needed: calculus, logic, complex numbers, vectors, and include introductions to vector calculus, differential equations, and statistical analysis.
  Exercises are central to this document. "Drill" the topics until you can use the tools fast and precisely!
])

#include "preface.typ"

#set heading(numbering: "1.1.1")
#chapter[Chapter 1: Mechanics]

= Newton's Laws
= Newton's Laws
= Newton's Laws
#chapter[Chapter 2: Mechanics]

_Newton's first law_: An object at rest remains at rest, and an object in motion remains in motion at constant velocity, unless acted upon by a *net* external force. `Net` means the vector sum of all forces acting on the object

So, `raw` and#text-tt[raw] and #text-tt("raw") should be all the same size

#set text(size: 16pt)
So, `raw`#text-tt[raw]#text-tt("raw")
#text-tt(true-size: 16pt * 0.85)[raw]#text-tt(size: 16pt)[raw]#text-tt(true-size: .85em)[raw]#text-tt(size: 1em)[raw] should all be the same size

#set text(size: 10pt)
So, `raw`#text-tt[raw]#text-tt("raw")
#text-tt(true-size: 10pt * 0.85)[raw]#text-tt(size: 10pt)[raw]#text-tt(true-size: .85em)[raw]#text-tt(size: 1em)[raw] should all be the same size

#set text(size: 10pt)

#lorem(400)


#show heading.where(level: 1): set heading()
#chapter[Hogehoge]

#lorem(400)
