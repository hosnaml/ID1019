defmodule Ranges do

  def parser (descr) do

    [seeds | maps] = String.split(descr, "\n\n");
    [ _ | seeds] = String.split(seeds, " ");

    seeds = Enum.map(seeds, fn(x) -> {nr, _} = Integer.parse(x); nr end)

    maps = Enum.map(maps, fn(map) ->
      [_ | transf] = String.split(map, "\n")
      Enum.map(transf, fn(tr) ->
        String.split(tr, " ")
      maps
      end)
    {seeds, maps}
    end)
  end

    def test() do
      {:ok, content}  = File.read("input.txt");
    end

end
