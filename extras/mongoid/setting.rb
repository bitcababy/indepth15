class Setting
  include Mongoid::Document
  
  field :n, as: :name, type: String
  field :v, as: :value
  field :d, as: :destroyable, type: Boolean, default: false
  field :r, as: :restricted, type: Boolean, default: false
  
  validates :name, presence: true
  
end
