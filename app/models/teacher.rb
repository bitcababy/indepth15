class Teacher < User
  field :cu, as: :current, type: Boolean
  field :dr, as: :default_room, type: String
  field :hp, as: :home_page, type: String
  field :gm, as: :generic_msg, type: String
  field :cm, as: :current_msg, type: String
  field :um, as: :upcoming_msg, type: String

  index({current: -1})

  has_and_belongs_to_many :departments, autosave: true

  scope :order_by_name, order_by(:last_name.asc, :first_name.asc)
  scope :current, where(current: true)

  has_many :sections, autosave: true do
    def for_course(c)
      where(course: c)
    end
    def for_year(y)
      where(year: y)
    end
  end

  has_many :assignments

  def courses(all: false)
    if all
      return (self.sections.only(:course).map {|s| s.course}).uniq
    else
      return (self.sections.current.only(:course).map {|s| s.course}).uniq
    end
  end

  def all_course_names
    return self.sections.map(:full_name).sort.uniq
  end

  def course_names
    return self.courses.map(&:full_name).sort
  end

  def collect_assignments
    self.sections.each {|s| self.assignments += s.assignments}
    self.save
  end

  def last_asst_number(c)
    sas = SectionAssignment.for_course(c).for_year(Settings.academic_year).for_teacher(self).includes(:assignment).select do |sa|
      sa.assignment.name.kind_of? Integer
    end
    ((sas.collect {|sa| sa.assignment.name})<<0).max
  end
end
