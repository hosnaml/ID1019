defmodule Philosopher do

  @dreaming 2000
  @eating 1000
  @delay 100
  @timeout 4000

  def sleep(0) do :ok end
  def sleep(t) do
    :timer.sleep(:rand.uniform(t))
  end

  def start(name, left, right, hunger, ctrl, gai) do
    #We give an process and what we get back is  aprocess identifier.
    spawn_link(fn() -> dreaming(name, left, right,hunger, ctrl, gai) end);
  end



  def dreaming(name, _left, _right, 10, ctrl, gai) do
      IO.puts("#{name} is starved to death");
      send(gai, {:action, name, :died});
      #send();
  end

  def dreaming(name, _left, _right, 0, ctrl, gai) do
    IO.puts("#{name} is happy");
    send(gai, {:action, name, :done});
    #send();
end

  def dreaming(name, left, right, hunger, ctrl, gai) do
    IO.puts("#{name} is dreaming");
    sleep(@dreaming)
    waiting(name, left, right, hunger, ctrl, gai)
  end

  def waiting(name, left, right, hunger, ctrl, gai) do
    case Chopstick.request(left) do
      :ok ->
        sleep(@delay)
        case Chopstick.request(right) do
          :ok ->
            eating(name, left, right, hunger, ctrl, gai)
          :sorry ->
            Chopstick.return(left)
            send(gai, {:action, name, :leave})
            dreaming(name, left, right, hunger + 1, ctrl, gai)
        end
      :sorry ->
        send(gai, {:action, name, :leave})
        dreaming(name, left, right, hunger + 1, ctrl, gai)
    end
  end


  def eating(name, left, right, hunger, ctrl, gai) do
    IO.puts("#{name} is eating")
    sleep(@eating)
    Chopstick.return(left)
    Chopstick.return(right)
    dreaming(name, left, right, hunger - 1, ctrl, gai)
  end
end
