# 逆ポーランド記法電卓 (関数型スタイル)

"use strict"

_ = if require? then require("underscore") else this._

OPERATORS = {
  "+": (x, y) -> y + x
  "-": (x, y) -> y - x
  "*": (x, y) -> y * x
  "/": (x, y) -> y / x
}

calculate = (rpn) ->
  calc = (stack, expr) ->
    if _.isEmpty(expr)
      return stack[0]

    [x, xs...] = expr
    if /^\d+$/.test(x)
      calc([parseInt(x, 10)].concat(stack), xs)
    else if stack.length >= 2
      calc([opeFn(x)(stack[0], stack[1])].concat(_.rest(stack, 2)), xs)
    else
      throw new Error("unexpected pattern found")
  calc([], rpn.split(/\s+/))

opeFn = (ope) ->
  if _.has(OPERATORS, ope)
    OPERATORS[ope]
  else
    throw new Error("unsupported operator '#{ope}' is used")

RPNCalculator2 = {calculate: calculate}
if module?.exports?
  module.exports = RPNCalculator2
else
  this.RPNCalculator2 = RPNCalculator2

# 利用例
rpn = "1 2 + 3 / 4 - 5 *"
console.log rpn, "\n = ", RPNCalculator2.calculate(rpn)
