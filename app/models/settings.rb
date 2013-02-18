class Settings
  include Mongoid::AppSettings
  
  
#  # 
#  #  field :name, kind: String
#  #  field :settings, kind: Hash, default: {}
#  #  field :_id, type: String, default: -> { name }
#  #  
#  #  validates :name, uniqueness: true, size: { minimum: 1 }
#  #    
#  #  ROOT_NAMESPACE = "__ROOT__"
#  #    
#  #  scope for_namespace  ->(n) { where(nameplace: n) }
#  # 
#  #  class << self
#  #    attr_accessor :current_doc
#  #    
#  #    alias []= set
#  #    def set(k, v)
#  #     return self.current_doc.settings[k.to_s] = v
#  #    end
#  #  
#  #    alias [] get
#  #    def get(k)
#  #      return self.current_doc.settings[k.to_s]
#  #    end
#  # 
#  #    def in_namespace_set(ns, hash = {})
#  #      sdoc = self.find_or_create_by name: ns
#  #      sdoc.settings.merge! hash
#  #      sdoc.save!
#  #    end
#  # 
#  #  end
#  # 
#  #  protected
#  #  
#  #  def current_doc
#  #    @current_doc ||= Settings.create name: ROOT_NAMESPACE
#  #  end
#  #  
#     
# end
  if true
    include Mongoid::AppSettings
    
    SETTINGS = {
      academic_year: 2013,
      school: "Weston High School",
      department: "Math Department",
      cutoff: {hour: 19, minute: 30},
      last_block: "H",
      max_occurrences:  5,
      blocks:  ('A'..'H').to_a,
      # These are temporary
      bridged: true,
      start_year: 2011,
    }
    
    SETTINGS.each_pair do |k,v| 
      setting k
      Settings[k] = v
    end

  else
    source "#{Rails.root}/config/application.yml"
    namespace Rails.env
  end
end