defmodule Spring do

  def split(row) do
    # Split a row into two parts (separated by " ").
    [status_str, seq_str] = String.split(row, " ")

    # Convert status string to charlist and sequence string to list of integers.
    status = String.to_charlist(status_str)
    seq = String.split(seq_str, ",") |> Enum.map(&String.to_integer/1)

    {status, seq}
  end


  def test() do
    # Read input file
    {:ok, content} = File.read("input.txt")

    # Split content into rows
    rows = String.split(content, "\n")

    # Process each row
    data = Enum.map(rows, &split/1)

    # Generate arrangements and calculate sum
    data
    |> Enum.map(fn {status, seq} ->
      {List.flatten(Enum.intersperse(List.duplicate(status, 5), {:unknown, 1})),
        List.flatten(List.duplicate(seq, 5))}
    end)
    |> Enum.map(&count/1)
    |> Enum.sum()
  end



  def count({status, seq}) do
    result = %{}
    {n, _} = count(status, seq, result)
    n
  end

  def count(status, seq, memo) do
    case {status, seq} do
      {[{:broken, num_broken1}, {:broken, num_broken2} | as], ns} ->
        memo_count([{:broken, num_broken1 + num_broken2} | as], ns, memo)
      {[{:working, _} | as], ns} ->
        memo_count(as, ns, memo)
      {[{:broken, num_broken}, {:unknown, num_unknown} | as], [num_broken | ns]} ->
        # The first unknown following a broken sequence is always working.
        memo_count(add_unknown(as, num_unknown - 1), ns, memo)
      {[{:broken, num_broken} | as], [num_broken | ns]} ->
        memo_count(as, ns, memo)
      {[{:broken, num_broken}, {:unknown, num_unknown} | as], [expected | ns]} ->
        missing = min(expected - num_broken, num_unknown)
        if missing >= 0 do
          num_unknown = num_unknown - missing
          as = [{:broken, num_broken + missing} | add_unknown(as, num_unknown)]
          memo_count(as, [expected | ns], memo)
        else
          {0, memo}
        end
      {[{:unknown, num_unknown} | as], ns} ->
        as = add_unknown(as, num_unknown - 1)
        as1 = [{:working, 1} | as]
        as2 = [{:broken, 1} | as]
        {n1, memo} = memo_count(as1, ns, memo)
        {n2, memo} = memo_count(as2, ns, memo)
        {n1 + n2, memo}
      {[], []} ->
        {1, memo}
      {_, _} ->
        {0, memo}
    end
  end

  defp memo_count(as, ns, memo) do
    key = {as, ns}
    case memo do
      %{^key => n} ->
        {n, memo}
      %{} ->
        {n, memo} = count(as, ns, memo)
        {n, Map.put(memo, key, n)}
    end
  end

  defp add_unknown([{:unknown, num_unknown} | as], n) do
    [{:unknown, num_unknown + n} | as]
  end
  defp add_unknown(as, n) when n > 0 do
    [{:unknown, n} | as]
  end
  defp add_unknown(as, _n), do: as


end
