class TextDocument < Document
  include Mongoid::Document
  field :co, as: :content, type: String, default: ""
end
