#import "misho-text.typ": chapter, misho-text

#let metadata = (
  title: "Core Mathematics",
  description: "A Lecture note for \"Mathematics for Fundamental Physics\".",
  copyright-years: [2024–2026],
  subtitle: "A Practical Guide on Mathematics for Physics Learners",
  revision: "v0.0.1",
)
#show: misho-text.with(metadata)

#import "0-title.typ": title
#title(metadata, [
  Lecture notes for first-year university students in physics or physical science, covering mathematical tools you the students need most. Calculus, logic, complex numbers, and vectors, with introductions to vector calculus, differential equations, and statistical analysis.
  Exercises are central to these notes. Practice each topic repeatedly until you can work through problems quickly and accurately.
])

#include "0-preface.typ"

#set heading(numbering: "1.1.1")
#show heading.where(level: 4): set heading(numbering: none)

#chapter(key: "chap:deriv")[Derivative (Review)]
#include "1-derivative.typ"

#chapter(key: "chap:units")[Units and Significant figures]
#include "2-units.typ"

#chapter(key: "chap:logic")[Logic]
#include "3-logic.typ"

#chapter(key: "chap:pow")[Power, Exponential, and Logarithm]
#include "4-power.typ"

#chapter(key: "chap:vector")[Vectors as arrows]
#include "5-vector.typ"

#chapter(key: "chap:complex")[Complex Numbers]
#include "6-complex.typ"

#chapter(key: "chap:matrix")[Matrices]
#include "7-matrix.typ"
