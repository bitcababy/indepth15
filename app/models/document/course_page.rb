class Document::CoursePage < Document::Page
	field :kind, type: Symbol

	belongs_to :course
	
	scope :of_kind, ->(kind){where(kind: kind)}
	scope :for_course, ->(course){where(course: course)}
end