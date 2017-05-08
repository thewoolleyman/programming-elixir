defmodule Parallel do
  import :timer, only: [sleep: 1]

  def pmap(collection, fun) do
    me = self()
    collection
    |> Enum.map(fn (elem) ->
         spawn_link fn -> (send me, { self(), fun.(elem) }) end
       end)
    |> Enum.map(fn (_pid) ->
         receive do { _pid, result } -> result end
       end)
#    |> Enum.map(fn (pid) ->
#         receive do { ^pid, result } -> result end
#       end)
  end

  def sleepy_double(n) do
    sleep 100
    n * 2
  end
end

IO.inspect(Parallel.pmap(1..50, &Parallel.sleepy_double/1))