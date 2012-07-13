class Document::Assignment < Document::Text
	field :name, type: String

	has_many :section_assignments			# Joins sections and assignments, with a due date
	
	def self.import_from_hash(hash)
		a = Assignment.create! hash
		a.tags << Tag::Author.find_or_create_by(author: hash[:teacher_id])

		a.save!
	end
	
end
