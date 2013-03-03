Fabricator(:section_assignment) do
	due_date			      { Date.today }
  assigned           false
	section
	assignment
end

Fabricator :past_section_assignment, from: :section_assignment do
	due_date			{ Date.today - sequence(:past, 2) }
  assigned     true
end

Fabricator :future_section_assignment, from: :section_assignment do
	due_date			{ Date.today + sequence(:future, 2)  }
  assigned     true
end
	