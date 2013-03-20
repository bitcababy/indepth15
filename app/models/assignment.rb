class Assignment < TextDocument
  include Mongoid::Timestamps::Short
  
  field :n, as: :name
  field :mit, as: :minor_topics, type: SortedSet, default: SortedSet.new
  
  # A section_assignment is broken if the assignment is deleted
  has_many :section_assignments, dependent: :delete, autosave: true
  has_and_belongs_to_many :major_topics
  
  accepts_nested_attributes_for :section_assignments

  track_history track_create: true
  
  index({name: -1})
  
  def add_major_topics(tags=[])
    for tag in tags do
      self.major_topics.find_or_create_by name: tag
    end
    self.save!
  end
  
  def course
    self.section_assignments.first.course
  end
  
  def teacher
    self.section_assignments.first.teacher
  end
    
end
