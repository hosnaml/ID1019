defmodule philo do

  @dreaming 2000
  @eating 1000
  @delay 100
  @timeout 4000

  def sleep(0) do :ok end
  def sleep(t) do
    :timer.sleep(:rand.uniform(t)) end

  def start(name, left, right, hunger, ctrl, gui) do
    #We give an process and what we get back is  aprocess identifier.
    spawn_link(fn() -> dreaming(name, left, right,hunger, ctrl, gui) end);
  end

  def dreaming(name, _left, _right,5 , ctrl, gui) do
      IO.puts(name,"is full and happy");
      send(gui, {:action, name, :done});
      #send();
  end

  def dreaming(name, _left, _right, 0, ctrl, gui) do
      IO.puts(name,"is starved to death");
      send(gui, {:action, name, :died});
      #send();
  end

  def dreaming(name, _left, _right, hunger, ctrl, gui) do
    IO.puts(name,"is dreaming");
    sleep(@dreaming)
    waiting(name, left, right, hunger, ctrl, gui)
  end


  def waiting(name, left, right, hunger, ctrl, gui) do
    IO.puts(name,"is waiting")
    send(gui,{:action, name, :waiting});
    Chop.request(left)
    sleep(@delay)
    Chop.request(right)
    case Chop.wait(@timeout) do
        :ok ->
          sleep(@delay)
          case Chop.wait(@timeout) do
            :ok ->
              eating(name, left, right, hunger, ctrl, gui)
            :sorry->
              #because if we don't we are sleeping with a chop stick.
              #Chop.return(left, ref)
              # We cancel this one that we didn't get since we have sent the request.
              #Chop.return(right, ref)
              send(gui,{:action, name, :leave})
              dreaming(name, left, right, hunger + 7, ctrl, gui)
          end
    end
    #Small delay between taking the left and right chopstcik.
  end

  def eating(name, left, right, hunger, ctrl, gui) do
    IO.puts(name,"is eating")
    send(gui,{:action, name, :eating});
    sleep(@eating)
    Chop.return(left)
    Chop.return(right)
    dreaming(name, left, right, hunger - 1, ctrl, gui)
  end

end
