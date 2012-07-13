class Tag::Text < Tag
	field :co, as: :content, type: String, default: ""
	
	class << self
		def add(txt)
			self.find_or_create_by(content: txt)
		end
	end

end
