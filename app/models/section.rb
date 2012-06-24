# encoding: UTF-8

class Section
	include Utils
	include Mongoid::Document
	field :n, as: :number, type: Integer
	field :b, as: :block, type: String
	field :d, as: :days, type: Array
	field :r, as: :room, type: String
	
	belongs_to :course
	belongs_to :teacher
	embeds_many :section_assignments
	accepts_nested_attributes_for :section_assignments

	validates_uniqueness_of :number, scope: :course
		
	def to_s
		"Section #{self.number}, block: #{self.block}"
	end
	
	def add_assignment(due_date, asst, show=true)
		self.section_assignments.create! due_date: due_date, assignment: asst
	end			
	

end