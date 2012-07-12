class Author < User
	field :honorific, type:String, default: "Mr."
	field :first_name, type: String, default: ""
	field :middle_name, type: String, default: ""
	field :last_name, type: String, default: ""
	
	def formal_name
		"#{self.honorific} #{self.last_name}"
	end

	def to_s
		"#{self.first_name} #{self.last_name}"
	end

	has_one :author_tag, class_name: 'Tag::Author'
	has_and_belongs_to_many :documents, inverse_of: nil

	after_create :make_tag
	
	def make_tag
		Tag::Author.create!(author: self) unless Tag::Author.where(author: self).exists?
	end
end
