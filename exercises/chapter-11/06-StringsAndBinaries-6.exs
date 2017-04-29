capitalize_sentences = fn
  s -> String.split(s, ". ") |> Enum.map_join(". ", &String.capitalize/1)
end

IO.inspect("Oh. A dog. Woof. " = capitalize_sentences.("oh. a DOG. woof. "))
