class Teacher < Author

	# @@next_id = (Teacher.count > 0 ? Teacher.last.id : 0)
	field :unique_name, type: String
	field :current, type: Boolean
	field :default_room, type: String
	field :home_page, type: String

	has_many :sections
	belongs_to :generic_msg_doc, class_name: 'TeacherPage', inverse_of: :teacher
	belongs_to :upcoming_msg_doc, class_name: 'TeacherPage', inverse_of: :teacher

	scope :current, where(current: true)
	scope :order_by_name, order_by(:last_name.asc, :first_name.asc)
	
	def formal_name
		"#{self.honorific} #{self.last_name}"
	end
	
	#
	# importing
	# 
	def self.convert_record(hash)
		hash['email'] = hash['login'] + "@mail.weston.org"
		hash['password'] = (hash['phrase'].split(' ').map &:first).join('') if (hash['phrase'])
		hash['current'] = hash['old_current'] == 1
		# gm = TextDocument.create! content: hash['generic_msg']
		# um = TextDocument.create! content: hash['upcoming_msg']
		gm = hash['generic_msg']
		um = hash['upcoming_msg']
		
		%W(phrase old_current generic_msg upcoming_msg teacher_id orig_id).each {|k| hash.delete(k)}
		teacher = self.create! hash
		teacher.create_generic_msg_doc content: gm
		teacher.create_upcoming_msg_doc content: um
		Tag::Author.create!(author: teacher)
		teacher
	end

end
