require 'active_support/concern'

module Mongoid
  module Ordered
    extend ::ActiveSupport::Concern

    included do
      include Comparable
    end

    module ClassMethods
      def ordered_on(name)
        field name, type: Integer, default: 0
          
        define_method :<=> do |b|
          return self[name] <=> b[name]
        end
        
        define_method :swap_with do |b|
          self[name], b[name] = b[name], self[name]
        end
         
      end # order_on
    end #ClassMethods
      
  end
end
