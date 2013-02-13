class Document
	include Mongoid::Document
	include Mongoid::Paranoia unless Rails.env.test?
  include Mongoid::Timestamps if Rails.env.production?
  include Mongoid::History::Trackable 
    
  before_update :check_lock_version

  # This is for optimistic locking
  def check_lock_version
    prev = self.history_tracks.last
    if prev.version > self.version
      # Someone's saved it while I was editing it
      raise StaleDocument
    end
  end

end

class StaleDocument < Exception
end
