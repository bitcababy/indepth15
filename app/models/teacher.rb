class Teacher < User
  include Mongoid::History::Trackable

	field :cu, as: :current, type: Boolean
	field :dr, as: :default_room, type: String
	field :hp, as: :home_page, type: String
	field :gm, as: :generic_msg, type: String
	field :cm, as: :current_msg, type: String
	field :um, as: :upcoming_msg, type: String
  
  track_history on: [:current, :default_room, :home_page, :generic_msg, :current_msg, :upcoming_msg], version_field: :version

	index({current: -1})
  
  has_many :assignments, autosave: true
  has_and_belongs_to_many :courses, autosave: true do
    def current
      @target.select {|c| c.current? }
    end
  end

  has_and_belongs_to_many :departments, autosave: true

	scope :current, where(current: true)
	scope :order_by_name, order_by(:last_name.asc, :first_name.asc)
  
  has_many :sections do
  has_many :sections, autosave: true do
    def for_course(c)
      where(course: c)
    end
    def current
      @target.select { |s| s.current? }
    end
  end
  
   def all_course_names
    return self.sections.map(:full_name).sort.uniq
  end

  def course_names
    return self.courses.current.map(&:full_name).sort
  end
   
  def next_asst_for_course(c)
    
  end

end
