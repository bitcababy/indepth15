class Mongoid::Settings
  # field :name, kind: String
  # field :settings, kind: Hash, default: {}
  # field :_id, type: String, -> { name }
  #   
  # ROOT_NAMESPACE = "__ROOT__"
  #   
  # scope for_namespace  ->(n) { where(nameplace: n) }
  # 
  #   
  # class << self do
  #   attr_accessor :current_doc
  #   
  #   def in_namespace_set(ns, hash = {})
  #     sdoc = self.find_or_create_by name: ns
  #     sdoc.settings.merge! hash
  #     sdoc.save!
  #   end
  # 
  #   alias []= set
  #   def set(k, v)
  #    return self.current_doc.settings[k] = v
  #   end
  # 
  #   alias [] get
  #   def get(k)
  #     return self.current_doc.settings[k]
  #   end
  # end
  #  
  # protected
  # 
  # def current_doc
  #   @current_doc ||= Mongoid::Settings.create name: ROOT_NAMESPACE
  # end
  # 
    
end