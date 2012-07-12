Fabricator(:document)

Fabricator(:text_document) 

Fabricator(:course_page) do
	course		nil
end

Fabricator(:teacher_page) do
	teacher		nil
end
