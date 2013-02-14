class Assignment < Document
  include Mongoid::History::Trackable
  
  if ::Settings.bridged
  	field :oid, type: Integer
  	validates :oid, uniqueness: true
  	index( {oid: 1}, {unique: true})
  	scope :with_oid, ->(i) {where(oid: i)}
  end
  
  field :co, as: :content, type: String, default: ""
  field :name, type: String, default: ""
  
  # A section_assignment is broken if the assignment is deleted
  has_many :section_assignments, dependent: :delete
  belongs_to :teacher
  
  has_and_belongs_to_many :major_tags

  accepts_nested_attributes_for :section_assignments

  track_history except: [:oid], track_create: true

end
