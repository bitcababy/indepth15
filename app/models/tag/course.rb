class Tag::Course < Tag
	has_and_belongs_to_many :courses
end