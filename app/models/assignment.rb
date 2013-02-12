class Assignment < Document
  include Mongoid::History::Trackable
  include Mongoid::TaggableWithContext
  include Mongoid::TaggableWithContext::AggregationStrategy::RealTime
  
  if ::Settings.bridged
  	field :assgt_id, type: Integer
  	validates :assgt_id, uniqueness: true
  	field :oid, type: Integer
  	validates :oid, uniqueness: true
  	index( {oid: 1}, {unique: true})
  	scope :with_oid, ->(i) {where(oid: i)}
  end
  
  field :co, as: :content, type: String, default: ""
  
  # A section_assignment is meaningless if the assignment is deleted
  has_many :section_assignments, dependent: :delete, autosave: true
  accepts_nested_attributes_for :section_assignments

  taggable :major_tags
  taggable :minor_tags
     
  track_history except: [:oid], track_create: true

end
