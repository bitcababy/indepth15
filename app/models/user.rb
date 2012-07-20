class User
	include Mongoid::Document
  include Mongoid::Timestamps

	field :ho, as: :honorific, type:String, default: "Mr."
	field :fn, as: :first_name, type: String, default: ""
	field :mn, as: :middle_name, type: String, default: ""
	field :ln, as: :last_name, type: String, default: ""

	def formal_name
		"#{self.honorific} #{self.last_name}"
	end
	
	def full_name
		"#{self.first_name} #{self.last_name}"
	end

	def to_s
		"#{self.first_name} #{self.last_name}"
	end

 # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :token_authenticatable,
         :recoverable, :rememberable#, :trackable,
 				 :timeoutable

  ## Database authenticatable
  field :email,              :type => String
	field :login, 						  type: String
  field :encrypted_password, :type => String, :default => ""

  validates_presence_of :email
  # validates_presence_of :encrypted_password # SMELL: breaks testing

  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  ## Confirmable
  # field :confirmation_token,   :type => String
  # field :confirmed_at,         :type => Time
  # field :confirmation_sent_at, :type => Time
  # field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time

  ## Token authenticatable
  field :authentication_token, :type => String
end
