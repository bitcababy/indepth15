Fabricator(:course) do
	number					{ sequence(:course_number, 321) {|i| i}}
	duration				{ [:full_year, :first_semester, :second_semester].sample }
	credits					{ [ 5.0, 2.5].sample }
	full_name				{ |attrs| "Course #{attrs[:number]}"}
	in_catalog			true
	description			nil
	information			nil
	resources 			nil
	policies				nil
	news						nil
	after_build { |obj|
		obj.description ||= Fabricate :text_document, contents: "Description"
		obj.information ||= Fabricate :text_document, contents: "information"
		obj.resources ||= Fabricate :text_document, contents: "resources"
		obj.information ||= Fabricate :text_document, contents: "policies"
		obj.news ||= Fabricate :text_document, contents: "news"
	}
end

Fabricate.sequence(:course_number, 321)

Fabrication::Transform.define(:course, lambda { |number|
			if Course.where(number: number).exists? then
				Course.find_by(number: number)
			else
			 Fabricate :course, number: number 
			end
		})
