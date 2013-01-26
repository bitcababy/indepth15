class TextDocument < Document
  include Mongoid::History::Trackable
  
  before_save do
    if @locked_by && (self.title_change || self.content_change)
      self.last_editor = @locked_by
      self.locked_by = nil
    end
    return true
  end
    
	field :co, as: :content, type: String, default: ''
  field :la, as: :locked_at, type: Time, default: nil
  
  belongs_to :owner, polymorphic: true
  
  attr_accessor :locked_by

  track_history on: [:title, :content, :last_editor],
                modifier_field: :modifier, 
                version_field: :version,
                track_create: true, 
                track_update: true, 
                track_destroy: true
  
  @@timeout = 5*60

  def lock(lb=nil)
    self.locked_at = Time.now
    self.locked_by = lb
    self.save
   end
  
  def can_lock?(lb)
    return self.locked_at.nil? || self.timed_out? || (lb && self.locked_by == lb)
  end

  def unlock
    self.locked_at = nil
    self.save
  end
  
  def locked?
    return !!self.locked_at
  end

  def timed_out?
    return (Time.now - self.locked_at > @@timeout) 
  end
end
