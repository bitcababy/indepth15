class User
	include Mongoid::Document
  include Mongoid::Timestamps::Short

	HONORIFICS = %W(Mr. Mrs. Ms Dr. Ms.)

	field :ho, as: :honorific, type:String, default: "Mr."
	validates :honorific, presence: true#, inclusion: { in: HONORIFICS }

	field :fn, as: :first_name, type: String, default: ""
	validates :first_name, presence: true#, length: { minimum: 1 }#, format: {with: /[A-Z][a-z\-]+}/}

	field :mn, as: :middle_name, type: String, default: ""
	field :ln, as: :last_name, type: String, default: ""

	validates :last_name, presence: true#, length: { minimum: 2 }

 # Include default devise modules. Others available are:
  # ::confirmable
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :timeoutable, :trackable, :lockable

  ## Database authenticatable
  field :em, as: :email, :type => String
	validates :email, presence: true

	field :lo, as: :login, type: String
	validates :login, presence: true, length: { minimum: 3}#, case_sensitive: false

  validates_uniqueness_of :email, :login, case_sensitive: false

	field :_id, type: String, default: ->{ login }


  # def ==(u)
  #   return false unless u.class == self.class
  #   return self.login == u.login
  # end

  def <=>(u)
    return self.login.downcase <=> u.login.downcase
  end

	def formal_name
		return "#{self.honorific} #{self.last_name}"
	end

	def full_name
		return "#{self.first_name} #{self.last_name}"
	end

	def to_s
		return "#{self.first_name} #{self.last_name}"
	end

	def menu_label
		return self.full_name
	end

	#
	# Devise stuff
	#
  field :ep, as: :encrypted_password, :type => String, :default => ""

  validates_presence_of :encrypted_password

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
  # field :ct, as: :confirmation_token,   :type => String
  #  field :ca, as: :confirmed_at,         :type => Time
  #  field :co, as: :confirmation_sent_at, :type => Time
  #  field :um, as: :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  field :fa, as: :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  field :ut, as: :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  field :la, as: :locked_at,       :type => Time

  # attr_accessible :login, :password, :password_confirmation, :remember_me

end

class LoginValidator < ActiveModel::EachValidator
  def validate_each(record, attr_name, value)
    foo
    unless User.exists? login: record.login
      record.errors.add("Invalid user", :login)
    end
  end
end
