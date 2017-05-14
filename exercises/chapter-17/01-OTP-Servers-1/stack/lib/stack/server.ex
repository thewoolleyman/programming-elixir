defmodule Stack.Server do
  use GenServer

  def handle_call(:pop, _from, stack) do
    [head | tail] = stack
    {:reply, head, tail}
  end
end