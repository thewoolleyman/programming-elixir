fizzbuzz = fn
  a, b, c ->
    case {a, b, c} do
      {0, 0, _} -> "FizzBuzz"
      {0, _, _} -> "Fizz"
      {_, 0, _} -> "Buzz"
      {_, _, a} -> a
  end
end

rembuzz = fn
  n -> fizzbuzz.(rem(n,3), rem(n,5), n)
end

"Buzz" = rembuzz.(10)
11 = rembuzz.(11)
"Fizz" = rembuzz.(12)
13 = rembuzz.(13)
14 = rembuzz.(14)
"FizzBuzz" = rembuzz.(15)
16 = rembuzz.(16)