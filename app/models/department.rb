# encoding: UTF-8

class Department
  include Mongoid::Document
  include Mongoid::Timestamps if Rails.env == 'production'

	field :n, as: :name, type: String

	belongs_to :why_doc, class_name: 'TextDocument', polymorphic: true
	belongs_to :how_doc, class_name: 'TextDocument', polymorphic: true
	belongs_to :news_doc, class_name: 'TextDocument', polymorphic: true
	belongs_to :resources_doc, class_name: 'TextDocument', polymorphic: true
	belongs_to :puzzle_doc, class_name: 'TextDocument', polymorphic: true
	
	def self.import_from_hash(hash)
		dept = Department.new
		dept.name = hash[:name]
		dept.create_why_doc content: hash[:why]
		dept.create_how_doc content: hash[:how_to_use]
		dept.create_news_doc content: hash[:news]
		dept.create_resources_doc content: hash[:resources]
		dept.create_puzzle_doc content: hash[:puzzle]
		dept.save!
	end
		
	
end
