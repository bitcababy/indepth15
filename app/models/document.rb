class Document
	include Mongoid::Document
	include Mongoid::Versioning
	
	has_and_belongs_to_many :tags, inverse_of: nil

end