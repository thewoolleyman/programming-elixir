defmodule Stack.Server do
  use GenServer

  # External API

  def start_link(initial_stack) do
    GenServer.start_link(__MODULE__, initial_stack, name: __MODULE__)
  end

  def pop do
    GenServer.call(__MODULE__, :pop)
  end

  def push(value) do
    GenServer.cast(__MODULE__, {:push, value})
  end

  def stop(reason) do
    GenServer.cast(__MODULE__, {:stop, reason})
  end

  # GenServer implementation

  def handle_call(:pop, _from, stack) do
    [head | tail] = stack
    {:reply, head, tail}
  end

  def handle_cast({:push, value}, stack) do
    cond do
      value < 10 -> {:stop, :value_must_be_greater_than_ten, stack}
      true -> {:noreply, [value | stack ]}
    end
  end

  def handle_cast({:stop, reason}, stack) do
    {:stop, reason, stack}
  end

  def terminate(reason, stack) do
    IO.puts("Terminating.  Reason: #{reason}, Stack: #{inspect stack}")
  end
end