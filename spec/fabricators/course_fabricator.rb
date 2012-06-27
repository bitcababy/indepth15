Fabricator(:course) do
	number				{ sequence(:course_number) }
	duration			{ [:full_year, :first_semester, :second_semester].sample }
	credits				{ [ 5.0, 2.5].sample }
	full_name			{ "Course #{Fabricate.sequence}"}
	in_catalog		true
	academic_year	2012
	description		"This is a description"
	information		"This is the course information"
	news					"This is the course news"
	resources			"These are some resources"
	policies			"These are the policies"
end

Fabricate.sequence(:course_number) {|i| i}

Fabrication::Transform.define(:course, 
	lambda { |full_name| Fabricate :course, full_name: full_name }
	)
