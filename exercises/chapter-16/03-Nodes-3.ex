defmodule Ticker do

  @interval 2000   # 2 seconds
  @name     :ticker

  def start do
    pid = spawn(__MODULE__, :generator, [[],[]])
    :global.register_name(@name, pid)
  end

  def register(client_pid) do
    send :global.whereis_name(@name), { :register, client_pid }
  end

  def generator(clients, unprocessed_clients) do
    receive do
      { :register, pid } ->
        IO.puts "registering new client: #{inspect pid}"
        generator([pid|clients], [pid|unprocessed_clients])
    after
      @interval -> tick(clients, unprocessed_clients)
    end
  end

  defp tick(clients, unprocessed_clients) do
    case unprocessed_clients do
      [] ->
        IO.puts("Ticked for all clients, starting over.")
        generator(clients, clients)
      [next_unprocessed_client|remaining_unprocessed_clients] ->
        IO.puts "Tick for next_unprocessed_client: #{inspect(next_unprocessed_client)}"
        send next_unprocessed_client, { :tick }
        generator(clients, remaining_unprocessed_clients)
    end
  end
end

defmodule Client do

  def start do
    pid = spawn(__MODULE__, :receiver, [])
    Ticker.register(pid)
  end

  def receiver do
    receive do
      { :tick } ->
        IO.puts "tock in client"
        receiver()
    end
  end
end
