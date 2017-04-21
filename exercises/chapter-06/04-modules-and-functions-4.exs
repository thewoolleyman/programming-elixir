defmodule Adder do
  def sum(1), do: 1
  def sum(n), do: n + sum(n - 1)
end

10 = Adder.sum(4)