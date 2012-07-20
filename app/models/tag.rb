class Tag
  include Mongoid::Document

	field :co, as: :content, type: String

	# recursively_embeds_many
	has_and_belongs_to_many :documents

end
