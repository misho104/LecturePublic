// cspell: disable

// Imported from Leedehai's Typst-Physica package (MIT License)
//    https://github.com/Leedehai/typst-physics
// and edited.


#let __combine_var_order(var, order) = {
  if order == 1 { return var }
  let order = if type(order) == int { [#order] } else { order }
  let naive_result = math.attach(var, t: order)
  if type(var) != content or var.func() != math.attach {
    return naive_result
  }

  if var.has("b") and (not var.has("t")) {
    // Place the order superscript directly above the subscript, as is
    // the custom is most papers.
    return math.attach(var.base, t: order, b: var.b)
  }

  // Even if var.has("t") is true, we don't take any special action. Let
  // user decide. Say, if they want to wrap var in a "(..)", let they do it.
  return naive_result
}

#let __derivative_display(upper, lower, style) = {
  if style == none {
    math.frac(upper, lower)
  } else if style == "large" {
    let operator = $#upper/#lower$
    /* Measure in math block mode for correct height
     * (See eg. https://github.com/ssotoen/gridlock/issues/2) */
    let size_op = measure($ #operator $).height
    let size_func = measure($ #func $).height
    let bestsize = calc.max(size_op, size_func)
    $#operator lr(#func, size: #bestsize)$
  } else if style == "horizontal" or style == sym.slash {
    math.frac(upper, lower, style: "horizontal")
  } else if style == "skewed" {
    math.frac(upper, lower, style: style)
  }
}
#let __rle(a) = {}

#let derivative(..args, d: $upright(d)$, style: none) = {
  let args = args.pos()
  assert(args.len() >= 1, message: "expecting at least one argument")
  if args.len() == 1 {
    return __derivative_display(d, d + [#args.at(0)], style)
  }
  let func = args.at(0)
  let upper-order = if type(func) == array and func.len() == 2 { func.at(1) } else { args.len() - 1 }
  let upper = __combine_var_order(d, upper-order) + (if type(func) == array { func.at(0) } else { func })
  // run-length encoding but keeping array element
  let vars = args
    .slice(1)
    .fold((), (acc, x) => {
      if type(x) == array {
        assert(x.len() in (1, 2), message: "invalid argument: " + repr(x))
        if x.len() == 1 { x = x.at(0) } else { return (..acc, x) }
      }
      if type(x) == array and x.len() == 1 { x = x.at(0) }
      let (last, c) = if acc.len() == 0 { (none, 0) } else { acc.at(-1) }
      if x == last { (..acc.slice(0, -1), (last, c + 1)) } else { (..acc, (x, 1)) }
    })
  let lower = vars.map(((v, c)) => (d, __combine_var_order(v, c))).flatten().join()
  __derivative_display(upper, lower, style)
}

#let dv = derivative
#let pdv(args) = derivative.with(..args, d: sym.partial)


#let eval(expr, size: 80% + 10pt) = $lr(#expr|, size: size)$
