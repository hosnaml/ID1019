defmodule Ranges do

  def parser (descr) do

    [seeds | maps] = String.split(descr, "\n\n")
    seeds = String.trim(seeds, "seeds: ")
    IO.puts(seeds)
    [ _ | seeds] = String.split(seeds, " ")
    IO.puts(seeds)
    seeds = Enum.map(seeds, fn(x) -> {nr, _} = Integer.parse(x); nr end)


    #maps = String.split(maps, "\n")
    maps = Enum.drop(maps,1)
    maps = Enum.map(maps, fn (line) ->
      String.split(line, "\s")
      Integer.parse(line)
      |> then (fn [a, b, c, d] ->
        [destination_range_start: a,
             source_range_start: b,
             range_length: c,
             source_range: b..b+c-1,
             distance: a-b]
          end)

      end)
    {seeds, maps}
  end

    def test() do
      {:ok, content}  = File.read("test.txt");
      {seeds, maps} = parser(content)
      #using comprehensions it loops over and for eahc seeds the function is called.
      #for seeds <-
    end

    def source_to_destination(maps, seeds) do

    end



end
