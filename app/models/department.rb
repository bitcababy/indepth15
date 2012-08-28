# encoding: UTF-8

class Department
  include Mongoid::Document
  include Mongoid::Timestamps if Rails.env == 'production'

	field :n, as: :name, type: String

	belongs_to :why_doc, class_name: 'TextDocument'
	belongs_to :how_doc, class_name: 'TextDocument'
	belongs_to :info_doc, class_name: 'TextDocument'
	belongs_to :news_doc, class_name: 'TextDocument'
	belongs_to :resources_doc, class_name: 'TextDocument'
	belongs_to :puzzle_doc, class_name: 'TextDocument'
	
end
