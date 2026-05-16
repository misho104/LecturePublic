
== Expressing Uncertainty

A measurement is properly reported as
$ x = x_0 plus.minus delta x, $
where $x_0$ is the measured (best) value and $delta x > 0$ is the #keyword[absolute uncertainty]---the half-width of the interval in which the true value is expected to lie.
For example, $ell = 1.35 plus.minus 0.02 thin upright("m")$ means the true length is between $1.33 thin upright("m")$ and $1.37 thin upright("m")$.

It is also useful to express how large the uncertainty is _relative_ to the measured value.
The #keyword[relative uncertainty] (or fractional uncertainty) is defined as
$ frac(delta x, x_0), $
and is often written as a percentage.
For $ell = 1.35 plus.minus 0.02 thin upright("m")$, the relative uncertainty is $0.02 / 1.35 approx 1.5%$.
A small relative uncertainty means a precise measurement; a large one means a rough estimate.

== Propagation of Uncertainty

When you compute a result from several measured quantities, each with its own uncertainty, the uncertainty in the result must be estimated.
This process is called #keyword[error propagation].

*Addition and subtraction.*
If $z = x + y$ (or $z = x - y$), the absolute uncertainty of $z$ is the sum of the absolute uncertainties of $x$ and $y$:
$ delta z = delta x + delta y. $
In words: when you add or subtract quantities, their absolute uncertainties add.
Note that uncertainties always _add_, even for subtraction, because errors in $x$ and $y$ can both push the result in the same direction.


*Multiplication and division.*
If $z = x y$ (or $z = x / y$), the relative uncertainty of $z$ is the sum of the relative uncertainties of $x$ and $y$:
$ frac(delta z, z) = frac(delta x, x) + frac(delta y, y). $
In words: when you multiply or divide quantities, their relative uncertainties add.
To find $delta z$ itself, multiply both sides by $z$.

For example, if $x = 3.0 plus.minus 0.1 thin upright("m")$ and $t = 2.0 plus.minus 0.1 thin upright("s")$, the speed $v = x / t$ is
$
  v = frac(3.0, 2.0) = 1.5 thin upright("m/s"), quad frac(delta v, v) = frac(0.1, 3.0) + frac(0.1, 2.0) approx 0.033 + 0.050 = 0.083,
$
so $delta v approx 0.083 times 1.5 approx 0.12 thin upright("m/s")$, giving $v = 1.5 plus.minus 0.1 thin upright("m/s")$ (rounded to one significant figure in the uncertainty).

#remark[
  The rules above assume the uncertainties are independent and use the worst-case (maximum) estimate.
  More advanced treatments use statistical methods (root-sum-of-squares), which you will encounter in experimental courses.
]

