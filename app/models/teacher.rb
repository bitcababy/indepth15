class Teacher < Author

	# @@next_id = (Teacher.count > 0 ? Teacher.last.id : 0)
	field :unique_name, type: String
	field :current, type: Boolean
	field :default_room, type: String
	field :home_page, type: String
	field :generic_msg, type: String
	field :upcoming_msg, type:String

	has_many :sections
	# has_many :teacher_pages

	scope :current, where(current: true)
	scope :order_by_name, order_by(:last_name.asc, :first_name.asc)
	
	#
	# importing
	# 
	def self.import_from_hash(hash)
		hash[:email] = hash[:login] + "@mail.weston.org"
		hash[:password] = (hash[:phrase].split(' ').map &:first).join('') if (hash[:phrase])
		hash[:current] = hash[:old_current] == 1
		gm = hash[:generic_msg]
		um = hash[:upcoming_msg]
		
		%W(phrase old_current generic_msg upcoming_msg teacher_id orig_id).each {|k| hash.delete(k)}
		teacher = self.create! hash
		teacher
	end

end
