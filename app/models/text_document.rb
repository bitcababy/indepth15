class TextDocument < Document
  include Mongoid::Document
  field :co, as: :content, type: String, default: ""

  has_many :images, class_name: 'Ckeditor::Picture'
  has_many :attachments, class_name: 'Ckeditor::AttachmentFile'
  accepts_nested_attributes_for :images
  accepts_nested_attributes_for :attachments
end
