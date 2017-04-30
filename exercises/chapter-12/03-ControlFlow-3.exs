defmodule Bang do
  def ok!({:ok, data }), do: data
  def ok!({_, data}), do: raise RuntimeError, message: "Not cool, yo: #{data}"
end

IO.inspect(1 = Bang.ok!({:ok, 1}))
Bang.ok!(File.open('notarealfile'))