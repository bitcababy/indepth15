class Assignment < TextDocument
	field :name, type: String

	has_many :section_assignments			# Joins sections and assignments, with a due date

	# def self.convert_record(hash)
	# 	teacher_id = hash['teacher_id']
	# 	hash[:content] = hash['description']
	# 	%W(teacher_id kind description year name).each {|k| hash.delete(k)}
	# 	
	# 	assignment = Assignment.create!(hash)
	# 	assignment.tags << Tag::Author.find_or_create_by(author: Teacher.find_by(login: teacher_id))
	# 	assignment.tags << Tag::ContentType.find_or_create_by(label: 'assignment')
	# 	assignment.save!
	# 	return assignment
	# end
	
end
