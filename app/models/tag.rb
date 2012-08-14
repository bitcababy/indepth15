class Tag
  include Mongoid::Document
  include Mongoid::Timestamps if Rails.env == 'production'

	field :name, type: String

	# recursively_embeds_many
	has_and_belongs_to_many :documents

end
