Fabricator :document do
	tags			[]
end

Fabricator('Document::Owned') do
end

Fabricator('Document::Versioned') do
	major_version		1
	minor_version		0
end

Fabricator :text_document, class_name: 'Document::Text' do
	content		""
end

Fabricator :course_page, class_name: 'Document::CoursePage' do
	content		""
	kind			:unknown
end

Fabricator :teacher_page, class_name: 'Document::TeacherPage do
	content		""
	kind			:unknown
end
