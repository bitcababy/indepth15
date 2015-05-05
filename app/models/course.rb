require 'durations'

class Course
  include Mongoid::Document
  include Mongoid::Timestamps::Short


  # FULL_YEAR = 12
  # FULL_YEAR_HALF_TIME = 3
  # FIRST_SEMESTER = 1
  # SECOND_SEMESTER = 2

  # DURATIONS = [ FULL_YEAR, FIRST_SEMESTER, SECOND_SEMESTER, FULL_YEAR_HALF_TIME ]
  # SEMESTERS = [ FIRST_SEMESTER, SECOND_SEMESTER ]
    ##
  ## Fields
  ##
  field :no, as: :number, type: Integer
  validates :number, presence: true, uniqueness: true, numericality: {only_integer: true}

  field :du, as: :duration, default: Durations::FULL_YEAR
  # validates :duration, presence: true, inclusion: {in: Durations::DURATIONS}

  field :cr, as: :credits, type: BigDecimal, default: 5.0
  validates :credits, presence: true, numericality: true, inclusion: Settings.credits

  field :fn, as: :full_name, type: String, default: ""
  validates :full_name, presence: true, length: { minimum: 3 }

  field :sn, as: :short_name, type: String, default: ->{ full_name }
  field :sc, as: :schedule_name, type: String, default: ->{ full_name }

  field :ha, as: :has_assignments, type: Boolean, default: true
  field :oc, as: :occurrences, type: Array

  field :ic, as: :in_catalog, type: Boolean, default: true

  field :_id, type: String, default: ->{ number }

  index( {number: -1} )

  scope :in_catalog, ->{where(in_catalog: true)}

  ##
  ## Associations
  ##
  has_many :sections, autosave: true do
    def for_teacher(t)
      where(teacher: t)
    end
    def current
      @target.select {|section| section.current? }
    end
  end

  belongs_to :department

  embeds_many :documents, class_name: 'CourseDocument'

  ##
  ## Scopes
  ##
  #

  def <=>(c)
    self.number <=> c.number
  end

  def to_s
    self.full_name
  end

  def teachers
    return (sections.map &:teacher).uniq
  end

  def current_teachers
    return teachers.select {|t| t.current}
  end

  def current?
    return self.sections.limit(1).where(year: Settings.academic_year).exists?
  end

  def doc_of_kind(k)
    return self.documents.where(kind: k).first
  end

  def sorted_sections
    return self.sections.current.sort
  end

  # def teachers
  #   (self.current_sections.map &:teacher).uniq
  # end

  def menu_label
    self.full_name
  end

  def create_docs
    self.course_documents.create kind: :resources
    self.course_documents.create kind: :news
    self.course_documents.create kind: :policies
    self.course_documents.create kind: :information
    self.course_documents.create kind: :description
    self.save!
  end

  def self.to_options
    Course.in_catalog.collect {|c| {"#{c.number} #{c.to_s}"=> c.number} }
  end


end
