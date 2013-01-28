class DepartmentDocument < TextDocument
  include Mongoid::Ordered
  # include Mongoid::Locker
  # enable_locking_with :locked_at

  field :title, type: String, default: ""
  
  validates :title, presence: true, length: {minimum: 3 }
  
  ordered_on :pos
  belongs_to :department

end
