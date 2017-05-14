# remember to manually call Node.connect for all clients from Ticker iex

defmodule Ticker do
  @name     :ticker

  def start do
    pid = spawn(__MODULE__, :generator, [[]])
    :global.register_name(@name, pid)
  end

  def register(new_client_pid) do
    IO.puts("Ticker registering client #{inspect new_client_pid}")
    send :global.whereis_name(@name), { :register, new_client_pid }
  end

  def reset() do
    IO.puts("Resetting")
    send :global.whereis_name(@name), { :reset }
  end

  def generator(clients) do
    receive do
      { :reset } ->
        generator([])
      { :register, new } ->
        case clients do
          [] ->
            IO.puts("Adding first client #{inspect new}")
           send(new, {:set_next_client, new})
           generator([new])
          [old_first] ->
            IO.puts("Adding second client, new order: [#{inspect old_first},#{inspect new}")
            send(old_first, {:set_next_client, new})
            send(new, {:set_next_client, old_first})
            generator([old_first, new])
          [first|_] ->
            old_last = List.last(clients)
            new_clients = clients ++ [new]
            IO.puts "Adding #{inspect new} to end of list, new order: #{inspect new_clients}"
            send(old_last, {:set_next_client, new})
            send(new, {:set_next_client, first})
            generator(new_clients)
        end
    end
  end
end

defmodule Client do
  @interval 5000   # 2 seconds

  def start do
    pid = spawn(__MODULE__, :receiver, [:no_next_client_assigned])
    IO.puts("Registering from client #{inspect pid}")
    Ticker.register(pid)
    pid
  end

  def reset(pid) do
    # This doesn't work, when you try to manually call Ticker.register(pid) afterward,
    # the Ticker never sends {:set_next_client, pid}...
    send(pid, {:set_next_client, :no_next_client_assigned})
  end

  def receiver(next_client) do
    receive do
      { :set_next_client, new_next_client } ->
        IO.puts ":set_next_client: self (#{inspect self()}) ->    #{inspect new_next_client}\n"
        receiver(new_next_client)
      { :tick, sending_client } ->
        IO.puts "tock: #{inspect sending_client}    ->     self(#{inspect self()})\n"
        receiver(next_client)
    after
      @interval ->
        case next_client do
          :no_next_client_assigned ->
            IO.puts "No next client assigned, not sending tick...\n"
          _ ->
            IO.puts "tick: self (#{inspect self()})       ->       #{inspect next_client}\n"
            send next_client, { :tick, self() }
            receiver(next_client)
        end
    end
  end
end
