class User
	include Mongoid::Document
  # include Mongoid::Timestamps
	HONORIFICS = %W(Mr. Mrs. Ms Dr. Ms.)

	field :ho, as: :honorific, type:String, default: "Mr."
	field :fn, as: :first_name, type: String, default: ""
	field :mn, as: :middle_name, type: String, default: ""
	field :ln, as: :last_name, type: String, default: ""
	
 # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :token_authenticatable,
         :recoverable, :rememberable, :timeoutable#, :trackable,
 				 
  ## Database authenticatable
  field :em, as: :email, :type => String
	field :lo, as: :login, type: String
  field :ep, as: :encrypted_password, :type => String, :default => ""

  # validates_presence_of :encrypted_password # SMELL: breaks testing

  ## Recoverable
  field :rt, as: :reset_password_token,   :type => String
  field :rp, as: :reset_password_sent_at, :type => Time

  ## Rememberable
  field :rm, as: :remember_created_at, :type => Time

  ## Trackable
  field :sic, as: :sign_in_count,      :type => Integer, :default => 0
  field :csi, as: :current_sign_in_at, :type => Time
  field :lsi, as: :last_sign_in_at,    :type => Time
  field :csii, as: :current_sign_in_ip, :type => String
  field :lsii, as: :last_sign_in_ip,    :type => String

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

	validates :honorific, presence: true#, inclusion: { in: HONORIFICS }
	validates :first_name, presence: true#, length: { minimum: 1 }#, format: {with: /[A-Z][a-z\-]+}/}
	validates :last_name, presence: true#, length: { minimum: 2 }
	validates :email, presence: true#, uniqueness: true
	validates :login, presence: true#, uniqueness: true, length: { minimum: 5 }

	def formal_name
		return "#{self.honorific} #{self.last_name}"
	end
	
	def full_name
		return "#{self.first_name} #{self.last_name}"
	end

	def to_s
		return "#{self.first_name} #{self.last_name}"
	end

end
