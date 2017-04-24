#defmodule MyList do
#  def flatten([]) do
#    IO.puts('00000000000')
#    []
#  end
#  def flatten([head | []]) do
#    IO.inspect('111111111')
#    IO.inspect(head)
#    flatten(head)
#  end
#  def flatten([[inner_head | inner_tail]| tail]) do
#    IO.puts('333333333')
#    IO.inspect([[inner_head | inner_tail]| tail])
#    IO.inspect(inner_head)
#    IO.inspect(inner_tail)
#    IO.inspect(tail)
#    [flatten(inner_head) | flatten([flatten(inner_tail) | flatten(tail)])]
#  end
#  def flatten([head | tail]) do
#    IO.puts('4444444444')
#    IO.inspect(head)
#    IO.inspect(tail)
#    [head, flatten(tail)]
#  end
#  def flatten([head, tail]) when length(tail) == 1 do
#    IO.puts('55555555')
#    IO.inspect(head)
#    IO.inspect(tail)
#    [head, tail]
#  end
#  def flatten(a) do
#    IO.puts('7777777')
#    IO.inspect(a)
#    a
#  end
#end

# See discussion and alternate solutions at https://forums.pragprog.com/forums/322/topics/11936
defmodule MyList do
  def flatten([]), do: []
  def flatten([head | tail]) do
    flatten(head) ++ flatten(tail)
  end
  def flatten(element), do: [element]
end

IO.puts('1. ----------------')
IO.inspect([1,2,3,4,5] = MyList.flatten([[1,2,3,4,5]]))
IO.puts('2. ----------------')
IO.inspect([1,2,3,4,5] = MyList.flatten([1,[2,3,4],5]))
IO.puts('3. ----------------')
IO.inspect([1,2,3,4,5] = MyList.flatten([1,[2,[3],4],5]))
IO.puts('4. ----------------')
IO.inspect([1,2,3,4,5,6] = MyList.flatten([ 1, [ 2, 3, [4] ], 5, [[[6]]]]))


