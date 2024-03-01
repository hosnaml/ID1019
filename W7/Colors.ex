#This module is used to convert a depth value to RGB values.
#Color RED. (255, 0, 0)
defmodule Colors do
  def convert(d, m) do
    #Divide d by m and so that you have a fraction f
    f = d / m
    #multiply this fraction by four to generate a floating point a from 0 to 4
    a = f * 4
    #Round a to have a section.
    x = trunc(a)
    #generate an offset y that is the truncated value of 255 ∗ (a − x).
    y = trunc(255 * (a - x))
    case x do
      0 -> {:rgb, 255, y, 0}
      1 -> {:rgb, 255 - y, 255, 0}
      2 -> {:rgb, 0, 255, y}
      3 -> {:rgb, 0, 255 - y, 255}
      4 -> {:rgb, y, 0, 255}
    end
  end
end
