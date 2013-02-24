Fabricator(:course) do
	number					{ sequence(:number, 321) }
	duration				{ [:full_year, :first_semester, :second_semester].sample }
	credits					{ [ 5.0, 2.5].sample }
	full_name				{ |attrs| "Course #{attrs[:number]}"}
  occurrences     (1..5).to_a
end

Fabrication::Transform.define(:course, lambda { |number|
			if Course.where(number: number).exists? then
				Course.find_by(number: number)
			else
			 Fabricate :course, number: number 
			end
		})

