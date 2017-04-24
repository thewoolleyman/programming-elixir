defmodule Gcd do
  def gcd(x,0), do: x
  def gcd(x,y) do
    IO.puts("x=#{x}, y=#{y}, rem(x,y)=#{rem(x,y)}")
    gcd(y, rem(x,y))
  end
end

2 = Gcd.gcd(404,42)