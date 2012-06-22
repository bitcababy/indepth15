class Teacher < User
	
	field :un, as: :unique_name, type: String
	
	has_many :sections
end
