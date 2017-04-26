printable = fn n ->
  if Enum.any?(n, &(&1 < 32)) || Enum.any?(n, &(&1 > 126)) do
    false
  else
    true
  end
end

IO.inspect(true = printable.('a'))
IO.inspect(true = printable.(' '))
IO.inspect(true = printable.('~'))
IO.inspect(false = printable.('∂'))
