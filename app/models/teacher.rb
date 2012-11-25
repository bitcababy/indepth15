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

	#
	# importing
	# 
	def self.import_from_hash(hash)
		hash[:email] = hash[:login] + "@mail.weston.org"
		hash[:password] = (hash[:phrase].split(' ').map &:first).join('') if (hash[:phrase])
		hash[:current] = hash[:old_current] == 1
		coder = HTMLEntities.new
		hash[:generic_msg] = coder.decode(hash[:generic_msg])
		# puts "#{hash[:generic_msg]}"
		hash[:upcoming_msg] = coder.decode(hash[:upcoming_msg])
		[:phrase, :old_current, :teacher_id, :orig_id].each {|k| hash.delete(k)}
		teacher = self.create! hash
		return teacher
	end

end
