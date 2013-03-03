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
  
  has_many :assignments

	scope :current, where(current: true)
	scope :order_by_name, order_by(:last_name.asc, :first_name.asc)
  
  has_many :sections
  embeds_many :asst_numbers

  def courses
    return self.sections.map(&:course).uniq
  end
  
  def course_names
    return self.courses.map(&:full_name).sort
  end
  
  def current_sections
    return self.sections.current
  end
  
  def update_number_for_course(c, n)
    rec = self.asst_numbers.find_or_initialize_by(course: c)
    rec.number = [rec.number, n.to_i].max
    self.save
  end

end
