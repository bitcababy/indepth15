class SectionAssignment
	include Mongoid::Document

	field :d, as: :due_date, type: Date
	field :s, as: :show, type: Boolean
	
	embedded_in :section
	belongs_to :assignment
	
	scope :future, lambda { gte(due_date: Utils.future_due_date) }
	scope :past, lambda { lt(due_date: Utils.future_due_date) }
end

