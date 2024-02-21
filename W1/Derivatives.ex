defmodule Derivatives do

  @type literal() :: {:num, number()} | {:var, atom()}

  @type expr() :: {:add, expr(), expr()} | {:mul, expr(), expr()} | literal()

  def test() do
    e = {:add, {:mul,{:num, 2}, {:var, :x}}, {:num, 4}}
    d = deriv(e, :x)
    simplify(d)
  end

  def test2() do
    e = {:exp,{:var, :x},{:num,2}}
    d = deriv(e, :x)
    simplify(d)
  end

  def test3() do
    e = {:ln,{:add, {:var, :x},{:num,2}}}
    d = deriv(e, :x)
    simplify(d)
  end

  def test4() do
    e = {:div,{:num, 1},{:add, {:var, :x},{:num,2}}}
    d = deriv(e, :x)
    simplify(d)
  end

  def test5() do
    e = {:sq, {:mul, {:num, 2}, {:var, :x}}}
    d = deriv(e, :x)
    simplify(d)
  end

  def test6() do
    e = {:sin,{:mul, {:var, :x}, {:num, 2}}}
    d = deriv(e, :x)
    simplify(d)
  end

  def deriv({:num, _}, _), do: {:num, 0}

  def deriv({:var, v}, v), do: {:num, 1}

  def deriv({:var, _}, _), do: {:num, 0} #! idk what's happening

  def deriv({:mul, e1, e2}, v), do: {:add, {:mul, deriv(e1,v),e2}, {:mul,e1, deriv(e2,v)}}

  def deriv({:add, e1, e2}, v), do: {:add, deriv(e1, v), deriv(e2, v)}

  def deriv({:exp, e, {:num, n}}, v), do: {:mul,{:mul,{:exp, e, {:num, n-1}}, deriv(e,v)}, {:num, n}}

  def deriv({:ln,e}, v), do: {:div, deriv(e, v), e}

  def deriv({:div, {:num, 1}, e}, v), do: {:div, {:mul, {:num, -1}, deriv(e, v)}, {:mul, e, e}}

  def deriv({:sq, e}, v), do: {:mul,{:div, {:num, 1}, {:sq, e}}, deriv(e, v)}

  def deriv({:sin, e}, v), do: {:mul, {:cos,e}, deriv(e, v)}

  def simplify({:num, n}) do {:num, n} end

  def simplify({:var, v}) do {:var, v} end

  def simplify ({:add,e1 , e2}) do
    simplify_add(simplify(e1), simplify(e2))
  end

  def simplify ({:mul,e1 , e2}) do
    simplify_mul(simplify(e1), simplify(e2))
  end

  def simplify({:exp, e1, e2}) do
    simplify_exp(simplify(e1),simplify(e2))
  end

  def simplify({:div,e1 ,e2 }) do
    simplify_div(simplify(e1), simplify(e2))
  end

  def simplify({:sq, e}) do
    simplify_sq(simplify(e))
  end

  def simplify({:sin, e}) do
    simplify_sin(simplify(e))
  end

  def simplify({:cos, e}) do
    simplify_cos(simplify(e))
  end

  def simplify_add({:num, 0}, e2) do e2 end

  def simplify_add(e1, {:num, 0}) do e1 end

  def simplify_add({:num, n1}, {:num, n2}) do {:num, n1 + n2} end



  def simplify_mul({:num, 0},_) do {:num, 0} end

  def simplify_mul(_, {:num, 0}) do {:num, 0} end

  def simplify_mul({:num, 1}, e2) do e2 end

  def simplify_mul(e1, {:num, 1}) do e1 end

  def simplify_mul({:num, n1}, {:num, n2}) do {:num, n1*n2} end

  def simplify_exp(e ,{:num, 0}) do {:num, 1} end

  def simplify_exp(e ,{:num, 1}) do e end

  def simplify_div({:num, 0}, e) do {:num, 0} end

  def simplify_sq({:num, o}) do {:num, o} end

  def simplify_sq({:num, 1}) do {:num, 1} end

  def simplify_sq({:exp, e, {:num, 2}}) do e end

  def simplify_sin({:num, 0}) do {:num, 0} end

  def simplify_cos({:num, 0}) do {:num, 1} end

  #Base cases:

  def simplify_add(e1, e2) do {:add, e1, e2} end

  def simplify_mul(e1, e2) do {:mul, e1, e2} end

  def simplify_div(e1, e2) do {:div, e1, e2} end

  def simplify_exp(e1, e2) do {:exp, e1, e2} end

  def simplify_sq(e) do {:sq, e} end

  def simplify_sin(e) do {:sin, e} end

  def simplify_cos(e) do {:cos, e} end

end
