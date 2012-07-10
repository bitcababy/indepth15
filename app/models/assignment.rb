class Assignment < TextDocument
	field :orig_id, type: Integer
	field :name, type: String

	has_many :section_assignments			# Joins sections and assignments, with a due date
		
	class << self
		def convert_record(hash)
			teacher_id = hash['teacher_id']
			hash[:content] = hash['description']
			%W(teacher_id kind description year name).each {|k| hash.delete(k)}
			
			assignment = Assignment.create!(hash)
				
			Tag.tag_obj(teacher_id, assignment)
			Tag.tag_obj(:assignment, assignment)
			return assignment
		end

	end
	
end
