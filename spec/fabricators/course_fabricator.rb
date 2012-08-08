Fabricator(:course) do
	number					{ sequence(:course_number, 321) {|i| i}}
	duration				{ [:full_year, :first_semester, :second_semester].sample }
	credits					{ [ 5.0, 2.5].sample }
	full_name				{ |attrs| "Course #{attrs[:number]}"}
	in_catalog			true
	description			{ |attrs| "This is the description of course #{attrs[:number]}" }
	information			{|attrs| "Information for course #{attrs[:number]}"}
	resources       {|attrs| "Resources for course #{attrs[:number]}"}
	policies				{|attrs| "Policies for course #{attrs[:number]}"}
	news						{|attrs| "News for course #{attrs[:number]}"}
end

Fabricate.sequence(:course_number, 321)

Fabrication::Transform.define(:course, lambda { |number|
			if Course.where(number: number).exists? then
				Course.find_by(number: number)
			else
			 Fabricate :course, number: number 
			end
		})
