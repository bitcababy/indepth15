Fabricator :assignment, from: :document, class_name: :assignment  do
  name                "The name"
	content							"Some content"
	section_assignments []
	oid						      { sequence(:oid, 1) }
  major_topics        SortedSet.new
end
