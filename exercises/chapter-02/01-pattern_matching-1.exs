a=[1,2,3]
IO.puts(inspect a)
a=4
IO.puts(inspect a)
4=a
# NO MATCH [a,b]=[1,2,3]
a=[[1,2,3]]
IO.puts(inspect a)
# NO MATCH [[a]]=[[1,2,3]]
