class Tag
  include Mongoid::Document

	field :n, as: :name, type: String
  field :k, as: :kind, type: Symbol

  # recursively_embeds_many
  # has_and_belongs_to_many :documents

end
