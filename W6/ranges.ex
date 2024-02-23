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
        |> then (fn[a, b, c] ->
          [destination_range_start: a,
           source_range_start: b,
           range_length: c,
           source_range: b..(b + c - 1),
           distance: abs(a - b)
         ]

        end)
      end)
      acc = acc ++ [row]
      #IO.puts(destination_range_start: row)
    {seeds, acc}
    end)
  end

    def test() do
      {:ok, content}  = File.read("test.txt")
      [{seeds, maps} | tail] = parser(content)
      Enum.each(seeds, fn seed ->
        dest = source_to_destination(maps, seed)
        |> Enum.min()
          |> IO.inspect()
      end)

    end

    #if the map is empty is returns the seeds.
    def source_to_destination([], seed) do
      seed
    end

    def source_to_destination([map | tail], seed) do
      destination = map
      |> IO.inspect()
      |> Enum.find(fn x -> seed in x[:source_range]end)
      |> case do
        nil -> seed
        x -> seed + x[:distance]
      end
      source_to_destination(tail, destination)
    end

end
