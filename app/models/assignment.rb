class Assignment < Document
  include Mongoid::History::Trackable
  
  if ::Settings.bridged
  	field :oid, type: Integer
  	validates :oid, uniqueness: true
  	index( {oid: 1}, {unique: true})
  	scope :with_oid, ->(i) {where(oid: i)}
  end
  
  field :n, as: :name, type: String, default: ""
  field :co, as: :content, type: String, default: ""
  field :mit, as: :minor_topics, type: SortedSet, default: SortedSet.new
  
  # A section_assignment is broken if the assignment is deleted
  has_many :section_assignments, dependent: :delete
  has_many :browser_records
  belongs_to :teacher
  
  has_and_belongs_to_many :major_topics

  accepts_nested_attributes_for :section_assignments

  track_history except: [:oid], track_create: true
  
  index({name: -1})
  
  def add_major_topics(tags=[])
    for tag in tags do
      self.major_topics.find_or_create_by name: tag
    end
    self.save!
  end

end
