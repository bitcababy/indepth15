Fabricator :document do
  pod       0
end

Fabricator :text_document, from: :document, class_name: :text_document do
  content   ""
  locked_at nil
  
end

Fabricator :locked_doc, from: :text_document do
  locked_at   { Time.now.localtime }
  state       :locked
end

## Assignments

Fabricator :assignment, from: :text_document, class_name: :assignment  do
	content							""
	section_assignments	[]
	assgt_id						{ sequence(1)}
end

Fabricator :course_document, from: :text_document

Fabricator :department_document, from: :text_document do
  title     ""
end  