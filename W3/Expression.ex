defmodule Eval do

  #@type expr() :: {:add, expr(), expr()}
  #          | {:sub, expr(), expr()}
  #          | {:mul, expr(), expr()}
  #         | {:div, expr(), expr()}
  #          | literal()

  def test do
    env = [{:x, {:num, 2}}, {:y, {:num, 3}}]
    env2 = []
    expression = {:sub, {:mul, {:div, {:num, 3}, {:num, 2}}, {:var, :x}}, {:q, {:num,1}, {:num, 2}}}
    eval(expression, env2)
  end

  def eval({:num, n}, env) do {:num, n} end

  def eval({:var, x}, env) do
    case EnvList.lookup(env,x) do
    nil ->
      raise("Uh oh! Key-value pair not part of the environment")
    {key, value} ->
      value

    end

  end

  def eval({:add, a1,a2 }, env) do
    add(eval(a1, env), eval(a2, env))
  end

  def eval({:sub, a1,a2 }, env) do
    sub(eval(a1,env),eval(a2,env))
  end

  def eval({:q,{:num,n1},{:num,n2}}, _) do
    {:q,{:num,n1},{:num,n2}}
  end

  def eval({:mul,a1,a2}, env) do
    mul(eval(a1, env), eval(a2, env))
  end

  def eval({:div,a1,a2}, env) do
    divide(eval(a1, env), eval(a2, env))
  end




  def add({:num, n1},{:num, n2}) do
    {:num, n1 + n2}
  end

  def add({:q,{:num,n1},{:num,n2}}, {:num, n}) do
    {:q,{:num,n1+(n*n2)},{:num,n2}}
  end

  def add({:num, n}, {:q,{:num,n1},{:num,n2}}) do
    {:q,{:num,n1+(n*n2)},{:num,n2}}
  end

  def add({:q,{:num,n1},{:num,n2}} , {:q,{:num,n3},{:num,n4}}) do
    {:q,{:num,(n4*n1) + (n2*n3)},{:num,n2*n4}}
  end





  def sub({:num, n1},{:num, n2}) do
    {:num, n1 - n2}
  end

  def sub({:q,{:num,n1},{:num,n2}}, {:num, n}) do
    {:q,{:num,n1-(n*n2)},{:num,n2}}
  end

  def sub({:num, n}, {:q,{:num,n1},{:num,n2}}) do
    {:q,{:num,n1-(n*n2)},{:num,n2}}
  end

  def sub({:q,{:num,n1},{:num,n2}} , {:q,{:num,n3},{:num,n4}}) do
    {:q,{:num,(n4*n1) - (n2*n3)},{:num,n2*n4}}
  end




  def mul({:num, n1},{:num, n2}) do
    {:num, n1 * n2}
  end

  def mul({:q,{:num,n1},{:num,n2}}, {:num, n}) do
    {:q,{:num,n1*n},{:num,n2}}
  end

  def mul({:num, n}, {:q,{:num,n1},{:num,n2}}) do
    {:q,{:num,n1*n},{:num,n2}}
  end

  def mul({:q,{:num,n1},{:num,n2}} , {:q,{:num,n3},{:num,n4}}) do
    {:q,{:num,(n1*n3)},{:num,n2*n4}}
  end





  def divide({:num, n1},{:num, n2}) do
    {:q,{:num,n1},{:num,n2}}
  end

  def divide({:q,{:num,n1},{:num,n2}}, {:num, n}) do
    {:q,{:num,n1},{:num,n2*n}}
  end

  def divide({:num, n}, {:q,{:num,n1},{:num,n2}}) do
    {:q,{:num,n1},{:num,n2*n}}
  end

  def divide({:q,{:num,n1},{:num,n2}} , {:q,{:num,n3},{:num,n4}}) do
    {:q,{:num,(n1*n4)},{:num,n2*n3}}
  end


end
