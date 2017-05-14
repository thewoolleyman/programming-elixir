defmodule Stack.Stash do
  use GenServer

  #####
  # External API  

  def start_link(current_stack) do
    IO.puts("DEBUG: #{__MODULE__} start_link, current_stack: #{inspect current_stack}")
    {:ok,_pid} = GenServer.start_link( __MODULE__, current_stack)
#    :sys.trace(__MODULE__, true)  # TODO: Why doesn't this work like it does in Stack.Server ???
  end

  def save_stack(pid, current_stack) do
    GenServer.cast pid, {:save_stack, current_stack}
  end

  def get_stack(pid) do
    GenServer.call pid, :get_stack
  end

  #####
  # GenServer implementation

  def handle_call(:get_stack, _from, current_stack) do
    IO.puts("DEBUG: #{__MODULE__} get_stack, current_stack: #{inspect current_stack}")
    { :reply, current_stack, current_stack }
  end

  def handle_cast({:save_stack, current_stack}, _current_stack) do
    IO.puts("DEBUG: #{__MODULE__} save_stack, stack: #{inspect current_stack}")
    { :noreply, current_stack}
  end
end
