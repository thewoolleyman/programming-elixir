fizzbuzz = fn
  0, 0, _ -> "FizzBuzz"
  0, _, _ -> "Fizz"
  _, 0, _ -> "Buzz"
  _, _, a -> a
end

"FizzBuzz" = fizzbuzz.(0,0,1)
"Fizz" = fizzbuzz.(0,1,1)
"Buzz" = fizzbuzz.(1,0,1)
"Wibble" = fizzbuzz.(1,1,"Wibble")