defmodule Stack.Application do
  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    IO.puts("DEBUG: #{__MODULE__} start")
    {:ok, _pid} = Stack.Supervisor.start_link([1,2,3])
  end
end
