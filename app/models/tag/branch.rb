class Tag::Branch < Tag::Text
	has_and_belongs_to_many :major_tags, class_name: 'Tag::Major'
	has_many :courses

end
