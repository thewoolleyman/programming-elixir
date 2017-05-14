defmodule Stack.Server do
  use GenServer

  # External API

  def start_link(stash_pid) do
    IO.puts("DEBUG: #{__MODULE__} start_link, stash_pid: #{inspect stash_pid}")
    {:ok,_pid} = GenServer.start_link(__MODULE__, stash_pid, name: __MODULE__)
    :sys.trace(__MODULE__, true)
    {:ok,_pid}
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

  def init(stash_pid) do
    current_stack = Stack.Stash.get_stack stash_pid
    { :ok, {current_stack, stash_pid} }
  end

  def handle_call(:pop, _from, {stack, stash_pid}) do
    [head | tail] = stack
    {:reply, head, {tail, stash_pid}}
  end

  def handle_cast({:push, value}, {stack, stash_pid}) do
    cond do
      value < 10 -> {:stop, :value_must_be_greater_than_ten, {stack, stash_pid}}
      true -> {:noreply, {[value | stack ], stash_pid}}
    end
  end

  def terminate(_reason, {current_stack, stash_pid}) do
    Stack.Stash.save_stack stash_pid, current_stack
  end
end