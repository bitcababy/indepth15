class Assignment < TextDocument
	field :name, type: String

	def self.import_from_hash(hash)
		coder = HTMLEntities.new
		hash[:content] = coder.decode(hash[:description])
		hash[:type] = :assignment
		author = Teacher.find_by(login: hash[:teacher_id])
		raise "Couldn't find teacher #{hash[:teacher_id]}" unless author
		[:description, :locked, :number, :teacher_id, :year].each { |k| hash.delete(k) }
		return Assignment.create! hash.merge(owner: author)
	end

end
