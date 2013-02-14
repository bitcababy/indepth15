class MajorTag
  include Mongoid::Document

  field :n, as: :name, type: String, default: ""
  field :s, as: :subtags, type: Array, default: []
  field :_id, type: String, default: ->{ name }
  
  validate :n, uniqueness: :name, size: { minimum: 3 }
  
  has_and_belongs_to_many :assignments
  has_and_belongs_to_many :courses
  
  def add_subtags(*tags)
    self.subtags = (self.subtags + tags).uniq
    self.save!
  end
  
  def to_s
    self.name
  end
  

end
