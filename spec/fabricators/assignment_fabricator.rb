Fabricator :assignment, from: :document, class_name: :assignment  do
	content							""
	section_assignments []
	oid						      { sequence(1) }
  major_topics        SortedSet.new
end
