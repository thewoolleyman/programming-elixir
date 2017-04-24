prefix = fn a ->
  fn b ->
    a <> " " <> b
  end
end
mrs = prefix.("Mrs")
"Mrs Smith" = mrs.("Smith")
"Elixir Rocks" = prefix.("Elixir").("Rocks")

