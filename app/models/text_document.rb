class TextDocument < Document
  include Mongoid::History::Trackable
  # include Mongoid::Locker

  before_save :update_for_save
    
	field :co, as: :content, type: String, default: ''
  field :le, as: :last_editor, type: String, default: nil
  
  # belongs_to :owner, polymorphic: true
  
  attr_accessor :locked_by

  track_history on: [:content, :last_editor],
                modifier_field: :modifier,
                version_field: :version,
                track_create: true, 
                track_update: true, 
                track_destroy: true
  
  @@timeout = 5*60
  
  def update_from_params(params)
    # Temporary
    return self.update_attributes(params)
  end
  
  def update_for_save
    # return unless super
    if @locked_by && self.content_change
      @last_editor = @locked_by
    end
    return true
  end
  
  def initialize(*args)
    super *args
  end

end
