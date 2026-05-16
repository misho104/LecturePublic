#import "misho-text.typ": chapter, misho-text

#let metadata = (
  title: "Core Mathematics",
  description: "A Lecture note for \"Mathematics for Fundamental Physics\".",
  copyright-years: [2024–2025],
  subtitle: "A Practical Guide on Mathematics for Physics Learners",
  revision: "v0.0.1",
)
#show: misho-text.with(metadata)

#import "0-title.typ": title
#title(metadata, [
  These are lecture notes for first-year university students in physics or physical science.
  They cover the mathematical tools you need most: calculus, logic, complex numbers, and vectors, with introductions to vector calculus, differential equations, and statistical analysis.
  Exercises are central to these notes. Practice each topic repeatedly until you can work through problems quickly and accurately.
])

#include "0-preface.typ"

#set heading(numbering: "1.1.1")
#show heading.where(level: 4): set heading(numbering: none)

#chapter[Derivative (Review)]
#include "1-derivative.typ"

#chapter[Units and Significant figures]
#include "2-units.typ"

