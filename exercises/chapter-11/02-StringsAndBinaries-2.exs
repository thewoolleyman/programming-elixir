anagram? = fn a, b ->
  # parens are needed!  Order of operations!
  if (to_charlist a) == Enum.reverse(to_charlist b) do
    true
  else
    false
  end
end

IO.inspect(true = anagram?.("abc", "cba"))
IO.inspect(false = anagram?.("abc", "abc"))
