defmodule Calculator do
  @space 32

  def calc(n) do
    [n1, op, n2] = Enum.chunk_by(n, &is_space?([&1])) |> Enum.reject(&is_space?(&1))
    _calc(binary_to_int(n1), op, binary_to_int(n2))
  end

  defp is_space?([n | _tail]), do: n == @space

  defp binary_to_int(n), do: n |> to_string |> String.to_integer

  defp _calc(n1, '+', n2), do: n1 + n2
  defp _calc(n1, '-', n2), do: n1 - n2
  defp _calc(n1, '*', n2), do: n1 * n2
  defp _calc(n1, '/', n2), do: n1 / n2
end

IO.inspect(3 = Calculator.calc('1 + 2'))
IO.inspect(1 = Calculator.calc('2 - 1'))
IO.inspect(4 = Calculator.calc('2 * 2'))
IO.inspect(2.0 = Calculator.calc('4 / 2'))
IO.inspect(22 = Calculator.calc('11 + 11'))
#IO.inspect(2.0 = Calculator.calc('4.1 / 2.1'))  # TODO: handle floats
