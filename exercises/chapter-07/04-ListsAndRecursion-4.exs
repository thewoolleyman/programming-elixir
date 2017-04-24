defmodule MyList do
  def span(from, to) when from == to, do: [to]
#   def span(_from = to, to), do: [to]  # more concise, uses pattern matching rather than when
  def span(from, to) do
    [from | span(from + 1, to)]
  end
end

IO.puts([2,3,4,5,6,7] = MyList.span(2,7))
