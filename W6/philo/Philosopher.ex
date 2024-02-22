defmodule philo do

  @dreaming 2000
  @eating 1000
  @delay 100
  @timeout 4000

  def start(name, left, right, hunger, strength, ctrl, gui) do
    #we give an process and what we get back is  aprocess identifier.
    spawn_link(fn() -> dreaming(name, left, right,hunger, strength, ctrl, gui) end);
  end

  def dreaming(name, _left, _right, 0, ctrl, gui) do
      IO.puts(name,"is starved to death");
      send(gui, {:action, name, :died});
      send();
      sleep(@dreaming)
  end

  def sleeping() do

  end

  def () do

  end

  def waiting() do
    send(gui,{:action, name, :waiting});
    ref = make_ref();
    Chop.request(left, ref)
    sleep(@delay)
    Chop.request(right, ref)
    case Chop.wait(ref, @timeout) do
        :ok ->
          sleep(@delay)
          case Chop.wait( ref, @timeout)
            :ok ->
              eating(name, left,right,hunger, strength, ctrl, gui)
            :sorry->
              #because if we don't we are sleeping with a chop stick.
              #Chop.return(left, ref)
              # We cancel this one that we didn't get since we have sent the request.
              #Chop.return(right, ref)
              send(gui,{:action, name, :leave})
              dreaming(name, left,right,hunger, strength, ctrl, gui)
    end
    #Small delay between taking the left and right chopstcik.
  end

  def eating(name, left,right,hunger, strength, ctrl, gui) do

  end

  def request() do
    send()
    receive do #in the process mail box we check with pattern matching.
      {:message_type, value} ->
        # code
    end

  end






end
