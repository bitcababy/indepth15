class Assignment < TextDocument
	include Mongoid::Document
	include Mongoid::Versioning

	field :name, 				type: String
	
	has_and_belongs_to_many :sections
	
	validates_presence_of :name
	
end
