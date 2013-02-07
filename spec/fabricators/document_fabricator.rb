Fabricator :document do
end

Fabricator :assignment, from: :document, class_name: :assignment  do
	content							""
	section_assignments	[]
	assgt_id						{ sequence(1) }
end

Fabricator :department_document, from: :document, class_name: :department_document do
  title     { sequence :title }
  content   "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
	pos				{ sequence(1) }
  department
end

Fabricator :course_document, from: :document, class_name: :course_document do
  content   "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
  course
end

Fabricate.sequence(:title) {|i| "Title #{i}"}