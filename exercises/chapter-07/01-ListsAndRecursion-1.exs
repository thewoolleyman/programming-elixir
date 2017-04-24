defmodule MyList do
  def mapsum([], _), do: 0
  def mapsum([head | tail], func), do: func.(head) + mapsum(tail, func)
end

IO.puts(0 = MyList.mapsum([], &(&1)))
IO.puts(12 = MyList.mapsum([1,2,3], &(&1 * 2)))
IO.puts(14 = MyList.mapsum([1,2,3], &(round(:math.pow(&1, 2)))))