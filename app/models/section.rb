# encoding: UTF-8

class Section
	include Mongoid::Document
	field :n, as: :number, type: Integer
	field :b, as: :block, type: String
	field :d, as: :days, type: Array
	field :r, as: :room, type: String
	field :as, as: :assignments, type: Array, default: []
	
	belongs_to :course
	belongs_to :teacher
end