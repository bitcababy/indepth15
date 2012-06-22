class Assignment < TextDocument
	include Mongoid::Document
	include Mongoid::Versioning

	
	# has_and_belongs_to_many :sections
	
	validates_presence_of :name, :contents
	
end
