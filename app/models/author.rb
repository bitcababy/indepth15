class Author < User
	has_one :author_tag, class_name: 'Tag::Author'
end
