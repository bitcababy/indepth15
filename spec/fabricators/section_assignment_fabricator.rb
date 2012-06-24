Fabricator(:section_assignment) do
	due_date			{ Date.today }
	assignment
end

Fabricator(:past_section_assignment, from: :section_assignment) do
	due_date			{ Date.today - rand(1..5) }
end

Fabricator(:future_section_assignment, from: :section_assignment) do
	due_date			{ Date.today + rand(1..5) }
end
	