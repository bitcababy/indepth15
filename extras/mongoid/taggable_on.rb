module Mongoid::TaggableOn
  extend ActiveSupport::Concern
  
  included do
    extend Mongoid::TaggableOn::SingletonMethods
    def self.taggable?
      false
    end
  end

  module ClassMethods
    def taggable_on(preserve_tag_order, *tag_types)
      # self.tag_types = tag_types.to_a.flatten.compact.map(&:to_sym)
      # class_eval do
      #   def self.taggable?
      #     true
      #   end
      # end
      # self.tag_types = (self.tag_types + tag_types).uniq
      if taggable?
        self.tag_types = (self.tag_types + tag_types).uniq
        self.preserve_tag_order = preserve_tag_order
      else
        class_attribute :tag_types
        self.tag_types = tag_types
        class_attribute :preserve_tag_order
        self.preserve_tag_order = preserve_tag_order
            
        class_eval do
          has_many :taggings, :dependent => :destroy, :class_name => "Mongoid::Tagging" do
            def base_tags
              @target.taggings.uniq {|t| t.tag}
            end
          end
        
          def self.taggable?
            true
          end
        end
      end
    end
  end
  
  def taggable?
    self.class.is_taggable?
  end
  
  module SingletonMethods
    def is_taggable?
      true
    end
  end
  
end