class Document
	include Mongoid::Document
	include Mongoid::Paranoia unless Rails.env == 'test'
  include Mongoid::Timestamps
  
  field :lv, as: :lock_version, type: Integer, default: 0
  belongs_to :updated_by, class_name: 'User'
  
  before_update :check_lock_version
  
  # This is for optimistic locking
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
