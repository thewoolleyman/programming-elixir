defmodule MyEnum do
  def all?([], _func), do: true
  def all?([head | tail], func), do: func.(head) && all?(tail, func)

  def each([], _func), do: []
  def each([head | tail], func), do: [func.(head) | each(tail, func)]

  def filter([], _func), do: []
  def filter([head | tail], func) do
    if func.(head) do
      [ head | filter(tail, func) ]
    else
      filter(tail, func)
    end
  end

  def take([], _n), do: []
  def take(_list, n = 0), do: []
  def take([head | tail], n), do: [head | take(tail, n-1)]
end

IO.inspect(true = MyEnum.all?([1,1], &(&1 == 1)))
IO.inspect(false = MyEnum.all?([1,2], &(&1 == 1)))

IO.inspect([2,4] = MyEnum.each([1,2], &(&1 * 2)))

IO.inspect([2,3] = MyEnum.filter([1,2,3,4], &(&1 > 1 && &1 < 4)))

IO.inspect([1,2] = MyEnum.take([1,2,3,4], 2))

