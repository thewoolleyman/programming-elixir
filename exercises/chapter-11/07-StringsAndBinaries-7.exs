defmodule Order do
  def orders do
    Stream.resource(
      fn -> File.open!("exercises/chapter-11/07-orders.csv") end,
      fn file ->
        case IO.read(file, :line) do
          data when is_binary(data) -> {[data], file}
          _ -> {:halt, file}
        end
    end,
    fn file -> File.close(file) end
    )
    |> Enum.to_list
    |> Enum.drop(1)
    |> Enum.map(&parse_order/1)
  end


  # NOTE: See http://shulhi.com/piping-to-second-argument-in-elixir/
  #       and https://groups.google.com/forum/#!topic/elixir-lang-core/WDePSnaiR5w
  #       for a discussion on the order of pipe and the Enum.zip trick below
  #       to pipe to the second argument.  It doesn't behave like
  #       haskell currying, `|>` always applies to the first argument.
  #       Couldn't make Macro.pipe/3  work either.
  def parse_order(order_line) do
    String.strip(order_line)
    |> String.split(",")
    |> (&Enum.zip([:id, :ship_to, :net_amount], &1)).()
    |> Enum.map(&convert_type/1)
  end

  def convert_type({:id, id}), do: {:id, String.to_integer(id)}
  def convert_type({:ship_to, ship_to}) do
    {:ship_to, String.trim_leading(ship_to, ":") |> String.to_atom}
  end
  def convert_type({:net_amount, net_amount}), do: {:net_amount, String.to_float(net_amount)}

  def total(tax_rates) do
    Enum.map(Order.orders, &_add_total_amount(&1, tax_rates))
  end

  defp _add_total_amount(order, tax_rates) do
    rate = tax_rates[order[:ship_to]] || 0.0
    tax = order[:net_amount] * rate
    total_amount = order[:net_amount] + tax
    Keyword.merge(order, [total_amount: total_amount])
  end
end

tax_rates = [ NC: 0.075, TX: 0.08 ]

IO.inspect(107.5 = Enum.at(Order.total(tax_rates),0)[:total_amount])
IO.inspect(48.384 = Enum.at(Order.total(tax_rates),3)[:total_amount])
