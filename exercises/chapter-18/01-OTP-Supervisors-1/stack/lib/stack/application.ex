defmodule Stack.Application do
  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    initial_stack = Application.get_env(:stack, :initial_stack)
    IO.puts("DEBUG: #{__MODULE__} start, initial_stack: #{inspect initial_stack}")
    {:ok, _pid} = Stack.Supervisor.start_link(initial_stack)
  end
end
