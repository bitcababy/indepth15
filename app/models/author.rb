class Author < User
	has_many :assignments, inverse_of: :owner
	
end
