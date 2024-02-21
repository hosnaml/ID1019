defmodule Reduce do

  #@spec len([integer()]) :: integer()
  #@spec even([integer()]) :: [integer()]
  #@spec inc([integer()], integer()) :: [integer()]
  #@spec sum([integer()]) :: integer()
  #@spec dec([integer()], integer()) :: [integer()]
  #@spec mul([integer()], integer()) :: [integer()]
  #@spec odd([integer()]) :: [integer()]

  def len([]) do 0 end

  def len([_ | t]) do
    1 + len(t)
  end


  def sum([list]) do
    sum(list,summ)
  end

  def sum([],summ) do
    summ
  end

  def sum([h|t], summ) do
    sum(t ,summ+h)
  end

  def even([h|t],acc) do
    case rem(h,2) do
      0 ->
        even(t, [h | acc])
      _ ->
        even(t,acc)
    end
  end

  def inc([h|t], i) do inc([h|t], i, []) end

  def inc([h|t], i, acc) do
    inc(t, i, [h + i | acc])
  end

  def inc([], _i, acc) do
    acc
  end

  #def sum(list) do sum(list, 0) end



  def dec([h|t], i) do inc([h|t], i, []) end

  def dec([h|t], i, acc) do
    inc(t, i, [h - i | acc])
  end

  def mul([h|t], i) do inc([h|t], i, []) end

  def mul([h|t], i, acc) do
    inc(t, i, [h * i | acc])
  end

  def odd([h|t], acc) do
    case rem(h,2) do
      0 ->
        even(t, acc)
      _ ->
        even(t, [h | acc])
    end
  end

  def rema([], _i, rem) do
    rem
  end

  def rema([h|t], i, []) do
    rema(t,i, [rem(h,i)])
  end

  def prod([]) do nil end

  #def prod([h|t]) do prod([h|t], 1) end

  def prod([h|t], acc) do
    prod(t, acc * h)
  end

  def prod([], acc) do
    acc
  end

  def div([], _integer) do
    []
  end

  def div([h|t], acc, i) do
    case rem(h, i) do
      0 ->
        even(t, [h | acc])
      _ ->
        even(t,acc)
    end
  end

  #def map([a()], ( a() -> b())) do

  #end

end
