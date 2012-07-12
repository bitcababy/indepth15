Fabricator(:assignment) do
	name								{ sequence(:assignment_name) }
	content							""
	section_assignments	{}
end

Fabricate.sequence(:assignment_name) {|i| i.to_s }

Fabricator(:future_assignment, from: :assignment) do
	after_build	{ |asst| Fabricate.build(:future_section_assignment, assignment: asst) }
end

Fabricator(:past_assignment, from: :assignment) do
	after_build	{ |asst| Fabricate.build(:past_section_assignment, assignment: asst) }
end

# Fabrication::Transform.define(:due_date, lambda{ |due_date|  })
