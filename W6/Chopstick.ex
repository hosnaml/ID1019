defmodule Chopstick do

  def start() do
    spawn_link(fn() -> available() end)
  end

  def request(chopstick) do
    send(chopstick, {:request, self()})
    receive do
      :granted ->
        :ok
    end
  end

  def return(chopstick) do
    send(chopstick, :return)
  end

  def available() do
    receive do
      {:request, from} ->
        send(from, :granted)
        gone()
      :quit ->
        :ok
    end
  end

  def gone() do
    receive do
      :return->
        available()
      :quit ->
        :ok
    end

  end

  def quit(chopstick) do
    send(chopstick, :quit)
  end
end
