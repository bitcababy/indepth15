# encoding: UTF-8

class Section
	include Mongoid::Document
	
	field :b, as: :block, type: String
	field :d, as: :days, type: Array
	field :n, as: :number, type: Integer
	field :r, as: :room, type: String
	
	belongs_to 	:course
	belongs_to 		:teacher
	has_and_belongs_to_many :assignments
end