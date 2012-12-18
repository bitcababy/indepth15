# encoding: UTF-8

class Department
  include Mongoid::Document
  include Mongoid::Timestamps if Rails.env == 'production'
  
	field :n, as: :name, type: String
  field :_id, type: String, default: :name

  has_many :homepage_docs, class_name: 'TextDocument', inverse_of: :owner, dependent: :delete
  	
end
