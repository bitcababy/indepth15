Fabricator :document do
	tags						[]
	owner						nil
end

Fabricator :text_document do
  title     nil
	content		""
end

## Assignments

Fabricator :assignment, from: :text_document, class_name: :assignment  do
	content							""
	section_assignments	[]
	assgt_id						{ sequence(1)}
end
