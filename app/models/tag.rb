class Tag
  include Mongoid::Document
	field :content, type: String, default: ""
	
	def self.add(txt)
		t = Tag.find_or_create_by(content: txt)
		return t
	end
		
	def to_s
		self.content
	end
	
end
