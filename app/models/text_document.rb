class TextDocument < Document
	field :content, type: String, default: ""
	
	has_and_belongs_to_many :tags, inverse_of: nil
	
end