defmodule C do
  def center(words) do
    longest_word = Enum.max_by(words, &(String.length(&1)))
    longest_length = String.length(longest_word)
    Enum.map(words, &_pad(&1, longest_length))
  end

  defp _pad(word, longest_length) do
    word_length = String.length word
    padding_needed = longest_length - word_length
    leading_pad = div(padding_needed, 2)
    trailing_pad = leading_pad + rem(padding_needed, 2)
    word
    |> String.pad_leading(leading_pad + word_length)
    |> String.pad_trailing(leading_pad + trailing_pad + word_length)
  end
end

(["  cat   "," zebra  ","elephant"] = C.center(["cat","zebra","elephant"]))
|> Enum.map(&IO.puts(&1))