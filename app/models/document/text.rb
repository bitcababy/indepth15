class Document::Text < Document::Versioned
	field :content, type: String, default: ""
	
end