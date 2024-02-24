defmodule Dinner do
  #create chopsticks.
  #create philosophers then calll them with their attributes.
  def start(), do: spawn(fn -> init() end)

  def init() do
    c1 = Chopstick.start()
    c2 = Chopstick.start()
    c3 = Chopstick.start()
    c4 = Chopstick.start()
    c5 = Chopstick.start()
    ctrl = self()
    gai = Gai.start([:arendt, :hypatia, :simone, :elisabeth, :ayn])
    Philosopher.start(:arendt, c1, c2, 5, ctrl, gai)
    Philosopher.start(:hypatia, c2, c3, 5, ctrl, gai)
    Philosopher.start(:simone, c3, c4, 5, ctrl, gai)
    Philosopher.start(:elisabeth, c4, c5, 5, ctrl, gai)
    Philosopher.start(:ayn, c5, c1, 5, ctrl, gai)
    wait(5, [c1, c2, c3, c4, c5])
    end

  def wait(0, chopsticks) do
    Enum.each(chopsticks, fn(c) -> Chopstick.quit(c) end)
  end

  def wait(n, chopsticks) do
    receive do
    :done ->
    wait(n - 1, chopsticks)
    :abort -> Process.exit(self(), :kill)
    end
  end

end
