class BrowserRecord
  include Mongoid::Document
  
  field :ay, as: :academic_year, type: Integer
  field :cn, as: :course_name, type: String
  field :fn, as: :first_name, type: String
  field :ln, as: :last_name, type: String
  field :bl, as: :block, type: String
  field :dd, as: :due_date, type: Date
  
  index({academic_year: -1, course_name: 1, last_name: 1, first_name: 1, block: 1, due_date: 1}, name: 'aclfbd')
  
  validates :academic_year, presence: true
  validates :course_name, presence: true
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :block, presence: true
  validates :due_date, presence: true
 
  belongs_to :course
  belongs_to :section
  belongs_to :section_assignment
  belongs_to :assignment
  belongs_to :teacher
  
  before_validation :update_fields
  
  scope :for_course, ->(c) { where(course: c) }
  scope :for_teacher, ->(t) { where(teacher: t) }

  def self.create_from_sa(sa)
    br = BrowserRecord.new
    br.section_assignment = sa
    br.section = br.section_assignment.section
    br.course = br.section.course
    br.teacher = br.section.teacher
    br.academic_year = br.section.academic_year
    br.assignment = br.section_assignment.assignment
    br.save!
    return br
  end
    
  def update_fields
    self.course_name = self.course.full_name
    self.first_name = self.teacher.first_name
    self.last_name = self.teacher.last_name
    self.block = self.section.block
    self.due_date = self.section_assignment.due_date
  end
    
end
