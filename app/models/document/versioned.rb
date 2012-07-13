class Document::Versioned < Document
  include Mongoid::Document

	field :major_version, type: Integer, default: 1
	field :minor_version, type: Integer, default: 0
	
	def bump_minor_version
		self.minor_version += 1
	end
	
	def bump_major_version
		self.major_version += 1
	end
	
end
