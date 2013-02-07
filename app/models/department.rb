# encoding: UTF-8

class Department
  include Mongoid::Document
  include Mongoid::Timestamps if Rails.env == 'production'
  
	field :n, as: :name, type: String
  validates :name, presence: true, length: { minimum: 3 }
  field :_id, type: String, default: -> { n }

  embeds_many :homepage_docs, class_name: 'DepartmentDocument'
  
 end
