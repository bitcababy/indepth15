Fabricator(:section_assignment) do
	due_date			{ Date.today }
  use           true
	section
	assignment
end

Fabricator(:past_section_assignment, from: :section_assignment) do
	due_date			{ Date.today - sequence(2) }
end

Fabricator(:future_section_assignment, from: :section_assignment) do
	due_date			{ Date.today + sequence(2)  }
end
	