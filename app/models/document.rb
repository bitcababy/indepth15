class Document
	include Mongoid::Document
	include Mongoid::Paranoia
  include Mongoid::Timestamps
  
  field :lv, as: :lock_version, type: Integer, default: 0
  
  # before_update :check_lock_version
  
  # This is a basic, no associated documents version
  def check_lock_version
    self.lock_version += 1
    prev = self.class.find self.to_param
    return true unless prev
    if prev.lock_version >= self.lock_version
      self.lock_version -= 1
      # Someone's saved it while I was editing it
      raise StaleDocument
     end
  end

end

class StaleDocument < Exception
end
