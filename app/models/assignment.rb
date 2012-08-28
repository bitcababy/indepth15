class Assignment < TextDocument
	field :assgt_id, type: Integer
	
	def self.fix_content(txt)
		coder = HTMLEntities.new
		coder.decode(txt)
	end

	def self.import_from_hash(hash)
		hash[:content] = self.fix_content(hash[:content])
		author = Teacher.find_by(login: hash[:teacher_id])
		raise "Couldn't find teacher #{hash[:teacher_id]}" unless author
		[:teacher_id].each { |k| hash.delete(k) }
		return Assignment.create! hash.merge(owner: author)
	end
	
	def self.handle_incoming(hash)
		hash[:content] = self.fix_content(hash[:content])
		assgt_id = hash[:assgt_id]
		if self.where(assgt_id: assgt_id).exists?
			asst = self.find_by(assgt_id: assgt_id)
			asst.content = hash[:content]
			asst.save!
		else
			hash[:owner] = Teacher.find_by(login: hash.delete(:teacher_id))
			Assignment.create! hash
		end
	end
			
	scope :dupes, ->(a) { where(:assgt_id.gt => a.assgt_id, :content => a.content) }
	
	index( {assgt_id: 1} )

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
