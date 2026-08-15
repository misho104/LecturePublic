= Linear Transformations
In formal mathematics, matrices are introduced as #EMPH[linear transformations] of vectors.
We are not going into the details, but let us "see" the situation briefly.

Consider a real function $f(x)$. If $f$ satisfies $f(x+y) = f(x) + f(y)$ and $f(k x) = k f(x)$ with any $k in RR$, we say $f$ is a #keyword[linear function].
#quizzes[
  + Check $f(x)=x^2$ is not linear. #hint[Compare $f(1+1)$ and $f(1)+f(1)$]
  + For $f(x) = 3x+c$ to be a linear function, what is the value of $c$?
]
In these examples, $f(x)$ receives a number $in RR$ and returns a number $in RR$.
As an extension, we can consider a function $vc(F)(vc(x))$ that receives a vector $vc(x) in KK^n$ a and returns a vector $vc(F)(vc(x))$.
#example[
  - The electrostatic potential $V(x, y, z)$ is a function that receives a vector $mat(x; y; z) in RR^3$ and returns a real value $V in RR$.
  - The electric field $vc(E)(x, y, z)$ is a function that receives a vector in $RR^3$ and returns a vector in $RR^3$.
]
Now, what if we require the linearity?

#definition[
  Consider a function $F$ that receives a vector $x in KK^m$ and returns a vector $vc(f) = F(vc(x)) in KK^n$. If

  - $F(vc(x) + vc(y)) = F(vc(x)) + F(vc(y))$ for any $vc(x), vc(y) in KK^m$,

  - $F(k vc(x)) = k F(vc(x))$ for any $vc(x)in KK^m$ and $k in KK$,

  we call $F$ a #keyword[linear function] or #keyword[linear operator].
]
#remark[
  We can safely mix these two concepts "functions" and "operators", but also you are advised to be cautious about the difference between $f(g(x))$ and $g(f(x))$.
]
#theorem[
  There is an one-to-one correspondence between

  - a matrix in $KK^(m,n)$ and
  - a linear function that receives a vector $in KK^n$ and returns a vector $in KK^m$.

  In other words, any _linear_ function receiving a vector $in KK^n$ and returning a vector $in KK^m$ can be uniquely described as a $m times n$ matrix $in KK^(m,n)$ and, conversely, any matrix $in KK^(m,n)$ corresponds to a linear function receiving a vector $in KK^n$ and returning vector $in KK^m$.
]

