class Teacher < RegisteredUser
	field :un, as: :unique_name, type: String
	field :c, as: :current, type: Boolean

	has_many :sections
	
	scope :current, where(current: true)
	scope :order_by_name, order_by(:last_name.asc, :first_name.asc)
	
	def formal_name
		"#{self.honorific} #{self.last_name}"
	end
	
end
