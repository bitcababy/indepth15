Fabricator(:major_tag) do
  name      { "Tag " + sequence(1).to_s }
  subtags   %W(foo bar)
end
