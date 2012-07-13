class Document::Owned < Document::Versioned
	belongs_to :owner, polymorphic: true

end
