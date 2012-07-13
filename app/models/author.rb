class Author < User
	field :ho, as: :honorific, type:String, default: "Mr."
	field :fn, as: :first_name, type: String, default: ""
	field :mn, as: :middle_name, type: String, default: ""
	field :ln, as: :last_name, type: String, default: ""
	
	
	def formal_name
		"#{self.honorific} #{self.last_name}"
	end

	def to_s
		"#{self.first_name} #{self.last_name}"
	end

	has_one :author_tag, class_name: 'Tag::Author'

	after_create :make_tag
	
	def make_tag
		Tag::Author.create!(author: self) unless Tag::Author.where(author: self).exists?
	end

end
