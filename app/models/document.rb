class Document
	include Mongoid::Document
	include Mongoid::Paranoia
  include Mongoid::Timestamps
  include Mongoid::Locker
  include Mongoid::TaggableWithContext
  include Comparable
  
  field :pos, as: :position, type: Integer, default: 0

  attr_accessor :locked_by
  
  def <=>(b)
    self.position <=> b.position
  end      
    
end
