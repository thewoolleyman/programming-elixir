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

Chop.guess(273, 1..1000)
Chop.guess(751, 1..1000)
Chop.guess(1, 1..1000)
Chop.guess(1000, 1..1000)