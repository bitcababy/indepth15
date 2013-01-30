class TitledDocument < TextDocument
  field :title, type: String, default: ""
  
  validates :title, presence: true
end
