class Assignment < TextDocument
	field :name, 				type: String
	
	validates_presence_of :name
	has_many :section_assignments

end
