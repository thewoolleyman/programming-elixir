# Discussion: https://forums.pragprog.com/forums/322/topics/11959
defmodule Echo do
  def run do
    receive do
      {sender, token} -> send sender, token
    end
  end
end

Enum.map(1..100, fn(_) ->
  pid1 = spawn(Echo, :run, [])
  send pid1, {self(), :fred}
  first = receive do
    token -> token
  end

  pid2 = spawn(Echo, :run, [])
  send pid2, {self(), :betty}
  second = receive do
    token -> token
  end
  [:fred, :betty] = [first, second]
end)

IO.puts "all in order"