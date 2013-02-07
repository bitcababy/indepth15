class Teacher < User
  include Mongoid::History::Trackable

	field :cu, as: :current, type: Boolean
	field :dr, as: :default_room, type: String
	field :hp, as: :home_page, type: String
	field :gm, as: :generic_msg, type: String
	field :cm, as: :current_msg, type: String
	field :um, as: :upcoming_msg, type: String

  track_history on: [:current, :default_room, :home_page, :generic_msg, :current_msg, :upcoming_msg], version_field: :version

	has_many :sections
	
	index({current: -1})

	scope :current, where(current: true)
	scope :order_by_name, order_by(:last_name.asc, :first_name.asc)

	def courses
		return self.sections.map(&:course).uniq
	end
		
	def course_names
		return self.courses.map(&:full_name).sort
	end


end
