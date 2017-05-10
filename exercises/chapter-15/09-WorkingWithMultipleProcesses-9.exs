defmodule CatFinder do
  def find(scheduler) do
    send scheduler, { :ready, self() }
    receive do
      { :find, file, client } ->
        send client, { :answer, file, _find(file), self() }
        find(scheduler)
      { :shutdown } ->
        exit(:normal)
    end
  end

  defp _find(file) do
    words = File.read!(file) |> String.split()
    Enum.reduce(words, 0, fn(word, acc) -> acc + cat_word(word) end)
  end

  defp cat_word(word) do
    case word do
      "include" -> 1
#      "cat" -> 1
      _ -> 0
    end
  end
end

defmodule Scheduler do
  def run(num_processes, module, func, to_calculate) do
    (1..num_processes)
    |> Enum.map(fn(_) -> spawn(module, func, [self()]) end)
    |> schedule_processes(to_calculate, [])
  end

  defp schedule_processes(processes, queue, results) do
    receive do 
      {:ready, pid} when length(queue) > 0 ->
        [ next | tail ] = queue
        send pid, {:find, next, self()}
        schedule_processes(processes, tail, results)

      {:ready, pid} ->
        send pid, {:shutdown}
        if length(processes) > 1 do
          schedule_processes(List.delete(processes, pid), queue, results)
        else
          Enum.sort(results, fn {n1,_}, {n2,_}  -> n1 <= n2 end)
        end

      {:answer, file, count, _pid} ->
        schedule_processes(processes, queue, [ {count, file} | results ])
    end
  end
end

files_and_dirs = Path.wildcard("/usr/local/include/**/*")
files = Enum.reject(files_and_dirs, &(File.dir?(&1)))

Enum.each files, fn file ->
  {_time, result} = :timer.tc(
    Scheduler, :run,
    [1, CatFinder, :find, [file]]
  )

  {count, _} = Enum.at(result,0)

  if count > 1 do
    IO.inspect({count, file})
  end
end
