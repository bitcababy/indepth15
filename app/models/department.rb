# encoding: UTF-8

class Department
  include Mongoid::Document
  include Mongoid::Timestamps::Short
  
	field :n, as: :name, type: String
  field :fn, as: :full_name, type: String, default: -> { name }
  field :_id, type: String, default: -> { name }

  validates :name, presence: true, length: { minimum: 3 }, uniqueness: true
 
  embeds_many :homepage_docs, class_name: 'DepartmentDocument'
  
  has_many :courses 
  
 end
