defmodule Oscar do

  def hello do "Hello" end

  def r([h | []]) do
    h
  end

  def r([_h | t]) do
    r(t)
  end

end
