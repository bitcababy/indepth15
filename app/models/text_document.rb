class TextDocument < Document
  include Mongoid::History::Trackable
  include Mongoid::Locker
  
  before_save do
    if @locked_by && (@title.dirty? || @content.dirty?)
      self.last_editor = @locked_by
    end
  end
    
  field :ti, as: :title, type: String, default: ''
	field :co, as: :content, type: String, default: ''
  belongs_to :owner, polymorphic: true
  
  attr_accessor :locked_by, :last_editor

  track_history on: [:title, :content, :last_editor],
                modifier_field: :modifier, 
                version_field: :version,
                track_create: true, 
                track_update: true, 
                track_destroy: true
  
end
