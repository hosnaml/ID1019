defmodule Philosopher do

  @dreaming 2000
  @eating 1000
  @delay 100
  @timeout 4000

  def sleep(0) do :ok end
  def sleep(t) do
    :timer.sleep(:rand.uniform(t))
  end

  def start(name, left, right, hunger, ctrl, Gai) do
    #We give an process and what we get back is  aprocess identifier.
    spawn_link(fn() -> dreaming(name, left, right,hunger, ctrl, Gai) end);
  end



  def dreaming(name, left, _right, 0, ctrl, Gai) do
      IO.puts("#{name} is starved to death");
      send(Gai, {:action, name, :died});
      #send();
  end

  def dreaming(name, left, right, hunger, ctrl, Gai) do
    IO.puts("#{name} is dreaming");
    sleep(@dreaming)
    waiting(name, left, right, hunger, ctrl, Gai)
  end


  def waiting(name, left, right, hunger, ctrl, Gai) do
    IO.puts("#{name}is waiting")
    send(Gai, {:action, name, :waiting});
    Chopstick.request(left)
    sleep(@delay)
    Chopstick.request(right)
    case Chopstick.wait(@timeout) do
        :ok ->
          sleep(@delay)
          case Chopstick.wait(@timeout) do
            :ok ->
              eating(name, left, right, hunger, ctrl, Gai)
            :sorry->
              #because if we don't we are sleeping with a chop stick.
              #Chop.return(left, ref)
              # We cancel this one that we didn't get since we have sent the request.
              #Chop.return(right, ref)
              send(Gai,{:action, name, :leave})
              dreaming(name, left, right, hunger + 7, ctrl, Gai)
          end
    end
    #Small delay between taking the left and right chopstcik.
  end

  def eating(name, left, right, hunger, ctrl, Gai) do
    IO.puts("#{name} is eating")
    send(Gai, {:action, name, :eating});
    sleep(@eating)
    Chopstick.return(left)
    Chopstick.return(right)
    dreaming(name, left, right, hunger - 1, ctrl, Gai)
  end

end
