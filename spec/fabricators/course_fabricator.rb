Fabricator(:course) do
	number					{ sequence(:course_number) }
	duration				{ [:full_year, :first_semester, :second_semester].sample }
	credits					{ [ 5.0, 2.5].sample }
	full_name				{ "Course #{Fabricate.sequence}"}
	in_catalog			true
	academic_year		{ Settings.academic_year}
	description			"This is a description"
	information			"This is the course information"
	news						"This is the course news"
	resources				"These are some resources"
	policies				"These are the policies"
	has_assignments	true
	description_doc	{|attrs| Fabricate.build(:course_page, content: attrs['description']) if attrs['description']}
	information_doc	{|attrs| Fabricate.build(:course_page, content: attrs['information']) if attrs['information']}
	resources_doc		{|attrs| Fabricate.build(:course_page, content: attrs['resources']) if attrs['resources']}
	policies_doc		{|attrs| Fabricate.build(:course_page, content: attrs['policies']) if attrs['policies']}
	news_doc				{|attrs| Fabricate.build(:course_page, content: attrs['news']) if attrs['news']}
end

Fabricate.sequence(:course_number) {|i| i}

Fabrication::Transform.define(:course, lambda { |full_name|
			if Course.where(full_name: full_name).exists? then
				Course.find_by(full_name: full_name)
			else
			 Fabricate :course, full_name: full_name 
			end
		})
