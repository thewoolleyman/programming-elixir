defmodule Waiter do
  import :timer, only: [ sleep: 1]

  def reply(sender) do
    send(sender, :reply)
    raise "FAIL"
  end

  def get_messages do
    receive do
      reply ->
        IO.inspect reply
        get_messages()
    after 500 ->
      IO.puts "No more messages"
    end
  end

  def run do
    Process.flag(:trap_exit, true)
    spawn_link(Waiter, :reply, [self()])
    sleep 100
    get_messages()
  end
end

Waiter.run