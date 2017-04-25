Code.require_file("04-ListsAndRecursion-4.exs","exercises/chapter-07")

# failed, below is from Rebecca Skinner at https://forums.pragprog.com/forums/322/topics/11937
defmodule Prime do
  def nums(n) do
    for x <- MyList.span(2, n), _is_prime?(x), do: x
  end

  defp _is_prime?(2), do: true
  defp _is_prime?(x) do
    Enum.all?(MyList.span(2,x - 1), &(rem(x, &1) != 0))
  end
end

IO.inspect([2,3,5,7,11,13] = Prime.nums(16))


