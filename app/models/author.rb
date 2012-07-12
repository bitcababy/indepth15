class Author < User
	has_one :author_tag, class_name: 'Tag::Author'
	has_and_belongs_to_many :documents, inverse_of: nil

	after_create :make_tag
	
	def make_tag
		Tag::Author.create!(author: self) unless Tag::Author.where(author: self).exists?
	end
end
