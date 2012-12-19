class SectionAssignment
	include Mongoid::Document
  include Mongoid::Timestamps if Rails.env == 'production'
	include Utils

	field :dd, as: :due_date, type: Date
	field :na, as: :name, type: String, default: ""
	field :use, type: Boolean
  
  if Settings.bridged
  	field :oi, as: :old_id, type: Integer
  end

	index({due_date: -1, use: 1})
	
	belongs_to :section
  accepts_nested_attributes_for :section
  delegate :block, :block=, :course, to: :section
	belongs_to :assignment

	scope :due_after,	->(date) { gt(due_date: date) }
  scope :due_on, ->(date) { where(due_date: date) }
	scope :past, -> { lt(due_date: future_due_date) }
	scope :future, -> { gte(due_date: future_due_date) }
	scope :next_assignment, -> { gte(due_date: future_due_date).asc(:due_date).published.limit(1) }
	scope :for_section, ->(s) { where(section: s) }
	scope :published, -> { where(use: true) }

	def to_s
		return "#{self.section}/#{self.assignment.assgt_id}"
	end
  
	def self.upcoming
		na = self.next_assignment.first
		if na
			return self.due_after(na.due_date)
		else
			return self.future
		end
	end
	


end

