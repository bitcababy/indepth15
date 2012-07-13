class Tag::Object < Tag
	belongs_to :object, polymorphic: true
end
