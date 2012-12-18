class Document
	include Mongoid::Document
	include Mongoid::Paranoia
  include Mongoid::Timestamps
  
  # has_and_belongs_to_many :tags
	
	belongs_to :owner, polymorphic: true
	
  # 
  # def tagged_with(s)
  #   return self.tags.detect { |tag| tag.name == s }
  # end
  
  # def <=>(b)
  #   self.position < b.position
  # end
end