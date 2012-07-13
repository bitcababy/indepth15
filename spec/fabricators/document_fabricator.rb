Fabricator :document do
	major_version		1
	minor_version		0
	tags						[]
	owner						nil
end

Fabricator :text_document, class_name: 'Document::Text' do
	content		""
end

Fabricator :course_page, class_name: 'Document::CoursePage' do
	content		""
	kind			:unknown
end

Fabricator :teacher_page, class_name: 'Document::TeacherPage' do
	content		""
end

## Assignments

Fabricator :assignment, from: :text_document, class_name: 'Assignment'  do
	name								{ sequence(:assignment_name) }
	content							""
	section_assignments	{}
end

Fabricate.sequence(:assignment_name) {|i| i.to_s }

Fabricator(:future_assignment, from: :assignment) do
	after_build	{ |asst| Fabricate.build(:future_section_assignment, assignment: asst) }
end

Fabricator(:past_assignment, from: :assignment) do
	after_build	{ |asst| Fabricate.build(:past_section_assignment, assignment: asst) }
end
