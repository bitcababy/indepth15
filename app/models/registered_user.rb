class RegisteredUser < User
	field :honorific, type:String
	field :first_name, type: String
	field :middle_name, type: String
	field :last_name, type: String
	field :email, type: String
	field :login, type: String
	field :password, type: String		# This will change once devise is added

	def formal_name
		"#{self.honorific} #{self.last_name}"
	end
	
	def to_s
		"#{self.first_name} #{self.last_name}"
	end

end
