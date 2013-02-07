module Mongoid::OptimisticLocking
  extend ActiveSupport::Concern
  
  included do
  end
  
  module ClassMethods
    def lock_on(field_name, shortname=nil)
      if shortname
        field shortname, as: field_name, type: Integer, default: 0
      else
        field field_name, type: Integer, default: 0
      end
      
      define_method :check_lock_version {
        self[field_name] += 1
        return true if self[field_name] == 1
        prev = self.class.find self.to_param
        
      }
        
    end
  end
        
end

