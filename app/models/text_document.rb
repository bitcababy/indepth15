class TextDocument < Document
	field :c, as: :contents, type: String
	
	validates_presence_of :contents
	
end