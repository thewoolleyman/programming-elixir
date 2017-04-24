# http://erlang.org/doc/man/io_lib.html#format-2
# http://erlang.org/doc/man/io.html#fwrite-1
:ok = :io.format("~10.2f~n", [123.456])

# https://hexdocs.pm/elixir/System.html#get_env/1
IO.puts System.get_env("HOME")

# https://hexdocs.pm/elixir/Path.html#extname/1
IO.puts (".exs" = Path.extname("dave/test.exs"))

# https://hexdocs.pm/elixir/System.html#cwd/0
IO.puts System.cwd!()

# https://hex.pm/packages?_utf8=%E2%9C%93&search=json&sort=downloads

# https://hexdocs.pm/elixir/System.html#cmd/3
{output, _} = System.cmd "echo", ["hello"]
IO.puts output

