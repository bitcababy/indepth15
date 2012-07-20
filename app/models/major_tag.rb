class MajorTag < Tag	
	embeds_many :minor_tags

	has_and_belongs_to_many :branches
end
