Fabricator(:course) do
	number					{ sequence(:course_number, 321) {|i| i}}
	duration				{ [:full_year, :first_semester, :second_semester].sample }
	credits					{ [ 5.0, 2.5].sample }
	full_name				{ |attrs| "Course #{attrs[:number]}"}
	in_catalog			true
	information_doc	{ Fabricate :text_document }
	resources_doc		{ Fabricate :text_document }
	policies_doc		{ Fabricate :text_document }
	news_doc				{ Fabricate :text_document }	
	description_doc	{ Fabricate :text_document }
end

Fabricate.sequence(:course_number, 321)

Fabrication::Transform.define(:course, lambda { |number|
			if Course.where(number: number).exists? then
				Course.find_by(number: number)
			else
			 Fabricate :course, number: number 
			end
		})
