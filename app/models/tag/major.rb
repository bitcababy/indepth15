class Tag::Major < Tag::Text
	has_and_belongs_to_many :branch_tags, class_name: 'Tag::Branch'
	has_and_belongs_to_many :course_tags, class_name: 'Tag::Course'

end
