class Assignment < TextDocument
	before_save :fix_content

	field :assgt_id, type: Integer
	validates :assgt_id, uniqueness: true
	
	scope :dupes, ->(a) { where(:assgt_id.gt => a.assgt_id, :content => a.content) }

	index( {assgt_id: 1}, {unique: true})
	scope :with_assgt_id, ->(i) {where(assgt_it: i)}
	
	def fix_content
		self.content = Assignment.massage_content(self.content)
	end

	class << self
		def massage_content(txt)
			txt.gsub!(/http:\/\/www\.westonmath\.org/, "")
			txt.gsub!(/http:\/\/westonmath\.org/, "")
			txt.gsub!(/\/teachers\//, "/files/")
			txt.gsub!(/href\s+=\s+'teachers\//, "href='/files/")
			txt.gsub!(/href\s+=\s+"teachers\//, "href=\"/files/")
			return txt
		end

		def import_from_hash(hash)
			assgt_id = hash[:assgt_id]
			hash[:content] ||= ""
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
	end

end
