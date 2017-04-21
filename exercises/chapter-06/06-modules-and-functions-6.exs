defmodule Chop do
  def guess(actual, min..max) do
    IO.puts("Guessing a number between #{min} and #{max}, inclusive. (It's #{actual}, sshhh)'")
    IO.write("Is it ")
    try_guess(actual, div(max - min ,2), min-1..max+1)
  end

  def make_guess(actual, guess, _) when guess == actual, do: IO.puts " I know, it is #{guess}!\n"

  def make_guess(actual, guess, _..max) when guess < actual do
    new_guess = guess + div(max - guess, 2)
    try_guess(actual, new_guess, guess..max)
  end

  def make_guess(actual, guess, min.._) when guess > actual do
    new_guess = guess - div(guess - min, 2)
    try_guess(actual, new_guess, min..guess)
  end

  def try_guess(actual, new_guess, min..max) do
    IO.write "#{new_guess},"
    make_guess(actual, new_guess, min..max)
  end
end

# Alternate implementation, but breaks if actual == max
#defmodule Chop do
#  def guess(actual, min..max) do
#    IO.puts("Guessing a number between #{min} and #{max}, inclusive. (It's #{actual}, sshhh)'")
#    IO.write("Is it ")
#    do_guess(actual, min..max)
#  end
#
#  def do_guess(actual, min..max) do
#    guess = div(max + min ,2)
#    IO.write("#{guess},")
#    make_guess(actual, guess, min..max)
#  end
#
#  def make_guess(actual, guess, _) when guess == actual, do: IO.puts " I know, it is #{guess}!\n"
#
#  def make_guess(actual, guess, _..max) when guess < actual do
#    do_guess(actual, guess..max)
#  end
#
#  def make_guess(actual, guess, min.._) when guess > actual do
#    do_guess(actual, min..guess)
#  end
#end

# From https://github.com/rbishop/programming-elixir/blob/master/guess.exs
# also breaks if actual is max
#defmodule Chop do
#  def guess(actual, lower..upper) do
#    number = div(upper + lower, 2)
#    IO.puts "Is it #{number}"
#    make_guess(number, actual, lower..upper)
#  end
#
#  def make_guess(number, actual, _) when number == actual do
#    IO.puts "Nailed it!"
#  end
#
#  def make_guess(number, actual, lower.._) when number > actual do
#    guess(actual, lower..number)
#  end
#
#  def make_guess(number, actual, _..upper) when number < actual do
#    guess(actual, number..upper)
#  end
#end

Chop.guess(273, 1..1000)
Chop.guess(751, 1..1000)
Chop.guess(1, 1..1000)
Chop.guess(1000, 1..1000)