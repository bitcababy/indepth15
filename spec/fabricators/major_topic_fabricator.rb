Fabricator(:major_topic) do
  name      { "Tag " + sequence(1).to_s }
  subtopics   %W(foo bar)
end

Fabricator :none_topic do
  name       :none
end