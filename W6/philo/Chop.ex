defmodule Chop do

  def start() do
    spawn_link(fn() -> available() end)
  end

  def request(side, time, ref) do
    send(chop, {:request, ref, self()})
    receive do
      :granted ->

    end

  end

  def return(chop, ref) do
    send(chop, :return)
  end

  def available() do
    receive do
      {:request, from} ->
      send(from, :granted)
      gone()

    end

  end

  def gone(ref) do
    receive do
      :return->
        available()
      :quit ->
        :ok
    end

  end
end
