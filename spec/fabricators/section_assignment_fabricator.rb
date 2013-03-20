Fabricator(:section_assignment) do
  transient         :teacher
  transient         :year
  transient         :course
  transient         :block
	due_date			    { Date.today }
  assigned          false
  section
	assignment
  year              { Settings.academic_year }
  after_build do |sa, t|
    section.year = t[:year] if t[:year  ]
    section.teacher = t[:teacher] if t[:teacher]
    section.course = t[:course] if t[:course]
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

