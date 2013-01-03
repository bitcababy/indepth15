class Assignment < TextDocument
  include Mongoid::History::Trackable
  
  if ::Settings.bridged
  	field :assgt_id, type: Integer
  	validates :assgt_id, uniqueness: true
  end

  # A section_assignment is meaningless if the assignment is deleted
  has_many :section_assignments, dependent: :delete, autosave: true
  accepts_nested_attributes_for :section_assignments

  track_history on: [:content],
                 modifier_field: :modifier, 
                 version_field: :version, 
                 track_create: true, 
                 track_update: true, 
                 track_destroy: true
                 
   taggable :major
   taggable :minor
  
end
