defmodule Stack.Supervisor do
  use Supervisor

  def start_link(initial_stack) do
    IO.puts("DEBUG: #{__MODULE__} start_link")
    result = {:ok, sup } = Supervisor.start_link(__MODULE__, [initial_stack])
    start_workers(sup, initial_stack)
    result
  end

  def start_workers(sup, initial_stack) do
    IO.puts("DEBUG: #{__MODULE__} start_workers")
    # Start the stash worker
    {:ok, stash} = 
       Supervisor.start_child(sup, worker(Stack.Stash, [initial_stack]))
    IO.puts("DEBUG: #{__MODULE__} stash: #{inspect stash}")
    # and then the subsupervisor for the actual stack server
    Supervisor.start_child(sup, supervisor(Stack.SubSupervisor, [stash]))
  end

  def init(_) do
    supervise [], strategy: :one_for_one
  end
end
