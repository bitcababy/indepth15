class Assignment < Document
  include Mongoid::Timestamps::Short
  
  field :n, as: :name
  field :co, as: :content, type: String, default: ""
  field :mit, as: :minor_topics, type: SortedSet, default: SortedSet.new
  
  # A section_assignment is broken if the assignment is deleted
  has_many :section_assignments, dependent: :delete, autosave: true
  belongs_to :teacher
  belongs_to :course
  has_and_belongs_to_many :major_topics

  accepts_nested_attributes_for :section_assignments

  track_history except: [:oid], track_create: true
  
  index({name: -1})
  
  after_create :set_course_and_teacher
  
  def add_major_topics(tags=[])
    for tag in tags do
      self.major_topics.find_or_create_by name: tag
    end
    self.save!
  end
  
  def set_course_and_teacher
    return if self.section_assignments.empty?
    self.course = self.section_assignments.first.course
    self.teacher = self.section_assignments.first.teacher
    self.save
  end

end
