defmodule WordFinder do
  @search_word "include"

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
    Enum.reduce(words, 0, fn(word, acc) -> acc + word_matches?(word) end)
  end

  defp word_matches?(word) do
    case word do
      @search_word -> 1
      _ -> 0
    end
  end
end

defmodule Scheduler do
  def run(num_processes, module, func, queue) do
    (1..num_processes)
    |> Enum.map(fn(_) -> spawn(module, func, [self()]) end)
    |> schedule_processes(queue, [])
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

duper = fn(orig_list, number_of_times_to_duplicate) ->
  Enum.concat(for _ <- 1..number_of_times_to_duplicate do Enum.flat_map(orig_list, &([&1, &1])) end)
end

files_and_dirs = Path.wildcard("/usr/local/include/**/*")

unique_files = Enum.reject(files_and_dirs, &(File.dir?(&1)))
# duplicate list to make performance gains of multiple
# processes more apparent
number_of_times_to_dup_list = 1
# NOTE: Increasing this number eliminates gains from multiple processes - something
#       about how SSD file IO contention works?
files = duper.(unique_files, number_of_times_to_dup_list)

num_processes = Enum.count(files)
#num_processes = 1  # With unique files, going to 1 processes approximately doubles the runtime
{time, results} = :timer.tc(
  Scheduler, :run,
  [num_processes, WordFinder, :find, files]
)

count_display_threshold = 10

Enum.each(results, fn result ->
  {count, file} = result

  if count > count_display_threshold do
    IO.inspect({count, file})
  end
end)

IO.inspect("Run time: #{time / 1000 / 1000}")