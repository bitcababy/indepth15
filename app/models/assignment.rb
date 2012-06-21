class Assignment
	include Mongoid::Document
	include Mongoid::Versioning
	include Mongoid::Paranoia
	include Mongoid::Taggable

	field :name
	field :contents
	
	# has_and_belongs_to_many :sections
	
	validates_presence_of :name, :contents
	
end
