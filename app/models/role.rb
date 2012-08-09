class Role
  include Mongoid::Document

	TEACHER = :teacher
	ADMIN = :admin
	REGISTERED =  :registered
	GUEST = :guest
	ROLES = %W(TEACHER ADMIN REGISTERED GUEST)

	validates :name, presence: true, inclusion: {in: ROLES}
	field :n, as: :name, type: Symbol
	
	has_and_belongs_to_many :users

end
