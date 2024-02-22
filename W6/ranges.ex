defmodule Ranges do

  def parser (descr) do

    [seeds | maps] = String.split(descr, "\n\n")
    [ _ | seeds] = String.split(seeds, " ")

    seeds = Enum.map(seeds, fn(x) ->
      {nr, _} = Integer.parse(x)
      nr
    end)

    acc = []

    maps = Enum.map(maps, fn(map) ->
      [_ | transf] = String.split(map, "\n")

      row = Enum.map(transf, fn r ->
        r
        |> String.split(" ")
        |> Enum.map(fn s -> String.to_integer(s) end)
      end)

      acc = acc ++ [row]

      #acc
      #|> IO.inspect(charlists: :as_lists)

    {seeds, acc}
    end)
  end

    def test() do
      {:ok, content}  = File.read("test.txt")
      [{seeds, maps} | tail] = parser(content)
      #Enum.each(seeds, fn seed ->
      #source_to_destination(maps, seed)
        #Enum.min()
      #end)

    end

    #if the map is empty is returns the seeds.
    def source_to_destination([], seeds) do
      seeds
    end

    def source_to_destination(maps, seeds) do

    end

end
