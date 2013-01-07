class Document
	include Mongoid::Document
	include Mongoid::Paranoia
  include Mongoid::Timestamps
  include Mongoid::TaggableWithContext
  include Mongoid::History::Trackable
  include Comparable
  
  field :pos, as: :position, type: Integer, default: 0
    
  def <=>(b)
    self.position <=> b.position
  end      
    
end
