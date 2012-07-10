class Tag
  include Mongoid::Document
	field :content, type: String
	field :tagged, type: Array, default: []
	
	has_many :tagged, inverse_of: tags

	class << self
		def add(txt)
			t = Tag.find_or_create_by(content: txt)
			return t
		end
		
		def tag_obj(txt, obj)
			txt = txt.to_s
			t = add(txt)
			obj.tags << t
			obj.save!
			t.tagged << obj
			return t
		end
	end
		
	def to_s
		self.content
	end	
end
