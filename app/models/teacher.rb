class Teacher < Author

	field :cu, as: :current, type: Boolean
	field :dr, as: :default_room, type: String
	field :hp, as: :home_page, type: String
	field :gm, as: :generic_msg, type: String
	field :cm, as: :current_msg, type:String
	field :um, as: :upcoming_msg, type:String

	has_many :sections
	
	index({current: -1})

	scope :current, where(current: true)
	scope :order_by_name, order_by(:last_name.asc, :first_name.asc)

	def courses
		self.sections.map(&:course).uniq
	end
		
	def course_names
		self.courses.map(&:full_name).sort
	end


end
