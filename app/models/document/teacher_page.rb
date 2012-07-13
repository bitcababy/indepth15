class Document::TeacherPage < Document::Page
	belongs_to :teacher
	field :kind, type: Symbol

	belongs_to :course
	
	scope :of_kind, ->(kind){where(kind: kind)}
	scope :for_teacher, ->(teacher){where(teacher: teacher)}
end

