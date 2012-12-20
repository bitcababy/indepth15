class TextDocument < Document
  include Mongoid::History::Trackable

  field :title, type: String, default: ''
	field :content, type: String, default: ""

  track_history on: [:title, :content],
                modifier_field: :modifier, 
                version_field: :version, 
                track_create: true, 
                track_update: true, 
                track_destroy: true

end
