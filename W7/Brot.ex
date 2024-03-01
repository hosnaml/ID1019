defmodule Brot do

  #c is a complex number, m is the maximum number of iterations.
  def mandelbrot(c, m) do
    #initialize z0 to 0
    z0 = Cmplx.new(0, 0)
    #keep track of the number of iterations
    i=0
    test(i, z0, c, m)
  end

  #if we have reached the max- imum iteration, in which case it returns zero
  def test(i, z0, c, m) when i < m do
    if Cmplx.abs(z0) > 2 do
      i
    else
      z = Cmplx.add(Cmplx.sqr(z0), c)
      test(i + 1, z, c, m)
    end
  end

  #When i is >=m
  def test(_, _, _, _), do: 0


end
