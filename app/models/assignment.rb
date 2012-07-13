class Assignment < Document::Text
	field :name, type: String
	field :number, type: Integer

	has_many :section_assignments			# Joins sections and assignments, with a due date
	has_many :tags
	belongs_to :course_tag, class_name: 'Tag::Course'

	def self.import_from_hash(hash)
		a = Assignment.create! hash
		teacher.find_by(login: hash[:teacher_id])
		self.tags << Tag::Author.find_or_create_by(object: teacher)
		return a
	end

end
