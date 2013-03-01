class SectionAssignment
	include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::History::Trackable
  
	field :dd, as: :due_date, type: Date
	field :published, type: Boolean, default: false
  
  if Settings.bridged
  	field :oi, as: :old_id, type: Integer
  end

	index({due_date: -1, published: 1})
	
	belongs_to :section
	belongs_to :assignment
  
  has_one :browser_record, autosave: true
 
  delegate :name, :content, :content=, to: :assignment
  delegate :course, :teacher, :block, :major_topics, to: :section

  scope :due_after,  ->(date) { gt(due_date: date) }
  scope :due_on_or_after,  ->(date) { gte(due_date: date) }
  scope :due_on, ->(date) { where(due_date: date) }
  scope :due_before, ->(date) { lt(due_date: date) }
  scope :published, -> { where(published: true) }
  scope :for_section, ->(s) { where(section: s) }
    
  scope :past, -> { due_before(future_due_date).published }
  scope :future, -> { due_on_or_after(future_due_date ).published }
  scope :next_assignment, -> { due_on_or_after(future_due_date).published.asc(:due_date).limit(1) }
      
  validate do |sa|
    errors.add(:base, 'SectionAssignment must have course') unless sa.course
    errors.add(:base, 'SectionAssignment must have assignment') unless sa.assignment
  end
  
  after_create do |sa|
    BrowserRecord.create_from_sa(sa)
  end
  
  # validate do |sa|
  #   errors.add(:base, 'Assignment must have name and content to be used') unless sa.assignment.name.size > 0 && sa.assignment.content.size > 0
  # end

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

