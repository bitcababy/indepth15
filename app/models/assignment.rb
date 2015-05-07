class Assignment < TextDocument
  include Mongoid::Timestamps::Short

  field :n, as: :name
  field :no, as: :number, type: String

  # A section_assignment is broken if the assignment is deleted
  has_many :section_assignments, dependent: :destroy, autosave: true do
    def for_course(c)
      @target.select {|sa| sa.course == c}
    end
  end

  belongs_to :teacher

  scope :with_numeric_name, ->{with_type(name: MongodbTypes::INTEGER32)}

  accepts_nested_attributes_for :section_assignments

  index({name: -1})

  def course
    self.section_assignments.first.course
  end

  def teacher
    self.section_assignments.first.teacher
  end

end
