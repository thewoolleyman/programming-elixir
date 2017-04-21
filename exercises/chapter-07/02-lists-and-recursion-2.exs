defmodule MyList do
  def max([]), do: raise "you cannot pass an empty list"
  def max([head | tail]) do
    _max([head | tail], head)
  end

  def _max([], current) do
    current
  end

  def _max([head | tail], current) do
    max_tail = _max(tail, head)
    if current > max_tail do
      current
    else
      max_tail
    end
  end
end

IO.puts(3 = MyList.max([1,2,3]))
IO.puts(-1 = MyList.max([-2,-1]))
IO.puts(-1 = MyList.max([]))