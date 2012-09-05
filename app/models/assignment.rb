class Assignment < TextDocument
	field :assgt_id, type: Integer
	
	scope :dupes, ->(a) { where(:assgt_id.gt => a.assgt_id, :content => a.content) }

	index( {assgt_id: 1} )
	scope :with_assgt_id, ->(i) {where(assgt_it: i)}

	class << self
		def fix_content(txt)
			coder = HTMLEntities.new
			coder.decode(txt)
		end

		def import_from_hash(hash)
			assgt_id = hash[:assgt_id]
			hash[:content] = fix_content(hash[:content])
			crit = self.with_assgt_id(assgt_id)
			if crit.exists?
				asst = crit.first
				asst.content = hash[:content]
				return asst.save!
			else
				author = Teacher.find_by(login: hash[:teacher_id])
				raise "Couldn't find teacher #{hash[:teacher_id]}" unless author
				hash.delete(:teacher_id)
				return Assignment.create! hash.merge(owner: author)
			end
		end
			
		# def cleanup
		# 	dupes = {}
		# 	skip = []
		# 	Assignment.asc(:assgt_id).each do |asst|
		# 		next if skip.include?(asst.assgt_id)
		# 		next if Assignment.dupes(asst).count == 0
		# 		ids = []
		# 		Assignment.dupes(asst).each {|a| ids << a.assgt_id}
		# 		print "."
		# 		skip += ids
		# 		dupes[asst.assgt_id ] = ids
		# 	end
		# 	puts dupes
		# end
		
	end
			
end
