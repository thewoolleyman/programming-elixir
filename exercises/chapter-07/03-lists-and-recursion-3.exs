defmodule Caesar do
  def caesar(list, n), do: to_string _caesar(list, n)
  defp _caesar([], _n), do: []
  defp _caesar([head | tail], n), do: [_offset(head + n) | _caesar(tail, n)]
  defp _offset(n) when n <= 122, do: n
  defp _offset(n), do: rem(n, 122) + 96
end

IO.puts("elixir" = Caesar.caesar('ryvkve', 13))
