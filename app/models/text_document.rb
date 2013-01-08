class TextDocument < Document
  include Mongoid::History::Trackable

  include Mongoid::Locker
  field :ti, as: :title, type: String, default: ''
	field :co, as: :content, type: String, default: ''

  track_history on: [:title, :content],
                modifier_field: :modifier, 
                version_field: :version, 
                track_create: true, 
                track_update: true, 
                track_destroy: true

  
end
