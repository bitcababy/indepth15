class SectionAssignment
	include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::History::Trackable

	field :dd, as: :due_date, type: Date
	field :use, type: Boolean, default: true
  
  if Settings.bridged
  	field :oi, as: :old_id, type: Integer
  end

	index({due_date: -1, use: 1})
	
	belongs_to :section, index: true
	belongs_to :assignment, index: true
  
  has_one :browser_record, autosave: true
 
  delegate :content, :content=, to: :assignment
  delegate :name, to: :assignment
  delegate :block, to: :section
  delegate :major_topics, to: :section

	scope :due_after,	->(date) { gt(due_date: date) }
  scope :due_on, ->(date) { where(due_date: date) }
	scope :past, -> { lt(due_date: future_due_date) }
	scope :future, -> { gte(due_date: future_due_date) }
	scope :next_assignment, -> { gte(due_date: future_due_date).asc(:due_date).published.limit(1) }
	scope :for_section, ->(s) { where(section: s) }
	scope :published, -> { where(use: true) }
  default_scope where(use: true)

  track_history track_create: true

	def to_s
		return "#{self.section}/#{self.assignment.oid}"
	end
  
  def potential_major_topics
    self.course.major_topics
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

