Fabricator :document do
	tags						[]
	owner						nil
end

Fabricator :text_document do
	content		""
end

## Assignments

Fabricator :assignment, from: :text_document  do
	name								{ sequence(:assignment_name) }
	content							""
	section_assignments	{}
end

Fabricator :upload, from: :document

Fabricate.sequence(:assignment_name) {|i| i.to_s }

Fabricator(:future_assignment, from: :assignment) do
	after_build	{ |asst| Fabricate.build(:future_section_assignment, assignment: asst) }
end

Fabricator(:past_assignment, from: :assignment) do
	after_build	{ |asst| Fabricate.build(:past_section_assignment, assignment: asst) }
end
