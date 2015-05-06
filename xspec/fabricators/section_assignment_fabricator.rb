Fabricator(:section_assignment) do
	due_date			    { Date.today }
  assigned          false
  section
	assignment
  after_build do |sa, t|
    section.section_assignments << sa
  end
end

Fabricator :section_assignment_past, from: :section_assignment do
	due_date			{ sequence(:future_date, 1) {|i| Date.today - i } }
  assigned     true
end

Fabricator :section_assignment_future, from: :section_assignment do
	due_date			{ sequence(:future_date, 1) {|i| Date.today + i } }
  assigned     true
end

