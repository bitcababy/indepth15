module AssignmentHelpers
  include Utils

  def assignment_with_sas(p=4, f=3)
    asst = Fabricate :assignment
    section = Fabricate :section

		p.times do |i|
			name = "p#{i}"
			Fabricate :section_assignment, due_date:  future_due_date - i - 1, name: name, section: section, assignment: asst
		end
		f.times do |i|
			name = "f#{i}"
			Fabricate :section_assignment, due_date:  future_due_date + i + 1, name: name, section: section, assignment: asst
		end
    
    return asst
  end
    
end

