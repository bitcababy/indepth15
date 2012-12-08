class AccordionPane
  include Mongoid::Document
  include Mongoid::Timestamps if Rails.env == 'production'

	field :title, type: String
  field :div_id, type: String

  belongs_to :text_document, inverse_of: nil
  delegate :content, :content=, to: :text_document
end
