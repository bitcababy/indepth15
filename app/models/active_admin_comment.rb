class ActiveAdminComment
  include Mongoid::Document
  field :namespace, type: String
  field :body, type: String
  belongs_to :resource, polymorphic: true
  
end
