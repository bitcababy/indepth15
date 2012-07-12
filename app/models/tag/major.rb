class Tag::Major < Tag
	has_and_belongs_to_many :branches
	has_and_belongs_to_many :courses

end
