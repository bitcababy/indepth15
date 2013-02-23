Fabricator(:section_assignment) do
	due_date			      { Date.today }
  published           false
	section
	assignment
end

Fabricator :past_section_assignment, from: :section_assignment do
	due_date			{ Date.today - sequence(:past, 2) }
  published     true
end

Fabricator :future_section_assignment, from: :section_assignment do
	due_date			{ Date.today + sequence(:future, 2)  }
  published     true
end
	