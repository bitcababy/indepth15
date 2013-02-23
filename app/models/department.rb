# encoding: UTF-8

class Department
  include Mongoid::Document
  include Mongoid::Timestamps if Rails.env.production?
  
	field :n, as: :name, type: String
  field :_id, type: String, default: -> { n }

  validates :name, presence: true, length: { minimum: 3 }, uniqueness: true
 
  embeds_many :homepage_docs, class_name: 'DepartmentDocument'
  
  has_many :courses 
  
 end
