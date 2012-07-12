class Tag::Document < Tag
	has_and_belongs_to_many :documents
end