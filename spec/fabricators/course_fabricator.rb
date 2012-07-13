Fabricator(:course) do
	number					{ sequence(:course_number) }
	duration				{ [:full_year, :first_semester, :second_semester].sample }
	credits					{ [ 5.0, 2.5].sample }
	full_name				{ "Course #{Fabricate.sequence}"}
	in_catalog			true
	academic_year		{ Settings.academic_year}
	information_doc(fabricator: :text_document)
	resources_doc(fabricator: :text_document)
	policies_doc(fabricator: :text_document)
	news_doc(fabricator: :text_document)
	description_doc(fabricator: :text_document)
end

Fabricate.sequence(:course_number) {|i| i}

Fabrication::Transform.define(:course, lambda { |full_name|
			if Course.where(full_name: full_name).exists? then
				Course.find_by(full_name: full_name)
			else
			 Fabricate :course, full_name: full_name 
			end
		})
