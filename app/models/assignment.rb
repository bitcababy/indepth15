class Assignment < TextDocument
	field :name, type: String
	field :assgt_id, type: Integer

	def self.import_from_hash(hash)
		coder = HTMLEntities.new
		hash[:content] = coder.decode(hash[:content])
		author = Teacher.find_by(login: hash[:teacher_id])
		raise "Couldn't find teacher #{hash[:teacher_id]}" unless author
		[:teacher_id].each { |k| hash.delete(k) }
		return Assignment.create! hash.merge(owner: author)
	end
	
	scope :dupes, ->(a) { where(:assgt_id.gt => a.assgt_id, :content => a.content) }

	def self.cleanup
		dupes = {}
		skip = []
		Assignment.asc(:assgt_id).each do |asst|
			next if skip.include?(asst.assgt_id)
			next if Assignment.dupes(asst).count == 0
			ids = []
			Assignment.dupes(asst).each {|a| ids << a.assgt_id}
			print "."
			skip += ids
			dupes[asst.assgt_id ] = ids
		end
		puts dupes
	end
			
end
