Fabricator :document do
  last_version      0
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

Fabricator :department_document, from: :titled_document, class_name: :department_document do
  title     "foo"
  content   "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
end  