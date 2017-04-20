defmodule Times do
  def double(n), do: n * 2
  def triple(n), do: n * 3
end

4 = Times.double(2)
6 = Times.triple(2)
