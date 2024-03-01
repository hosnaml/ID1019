defmodule Cmplx do

  def sign(x) do
    cond do
      x < 0 -> -1
      x > 0 -> 1
      true -> 0
    end
  end

  def new(r, i) do
    {:cpx,r, i}
  end

  def add({:cpx, x1, x2}, {:cpx, y1, y2}) do
    #elem/2 is to access elements in a tuple.
    #{elem(a, 0) + elem(b, 0), elem(a, 1) + elem(b, 1)}
    {:cpx, x1 + y1, x2 + y2}
  end

  def sqr({:cpx, a, b}) do
    {:cpx, (a * a) - (b * b), 2 * a * b}
  end

  def abs({:cpx, x1, x2}) do
    #sqr(elem(a, 0)* elem(a, 0)  + elem(a, 1) * elem(a, 1))
    :math.sqrt(x1 * x1 + x2 * x2)
  end


end
