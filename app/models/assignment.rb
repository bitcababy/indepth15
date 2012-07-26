class Assignment < TextDocument
	field :name, type: String
	field :number, type: Integer

	belongs_to :course
	belongs_to :author
	
	# has_and_belongs_to_many :section_assignments, inverse_of: nil # Not sure we need to go in this direction

	def self.import_from_hash(hash)
		return Assignment.create! hash.merge(owner: Teacher.find_by(login: hash[:teacher_id]))
	end

end
