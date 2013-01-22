class Author < User
	has_many :text_documents, inverse_of: :owner
	
end
