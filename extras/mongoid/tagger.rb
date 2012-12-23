module Mongoid::Tagger
  extend ActiveSupport::Concern
  
  include do
    has_many :taggings, :class_name => "Mongoid::Tagging" do
      def tags
        @target.taggings.uniq {|t| t.tag}
      end
    end
  end
  # 
  #  
  # module ClassMethods
  #   #   include ActsAsTaggableOn::Tagger::InstanceMethods
  #   #   extend ActsAsTaggableOn::Tagger::SingletonMethods
  #   # end
  #   # def is_tagger?
  #   #   false
  #   # end
  # end
  # 
  # module InstanceMethods
  #   # ##
  #   #  # Tag a taggable model with tags that are owned by the tagger.
  #   #  #
  #   #  # @param taggable The object that will be tagged
  #   #  # @param [Hash] options An hash with options. Available options are:
  #   #  #               * <tt>:with</tt> - The tags that you want to
  #   #  #               * <tt>:on</tt>   - The context on which you want to tag
  #   #  #
  #   #  # Example:
  #   #  #   @user.tag(@photo, :with => "paris, normandy", :on => :locations)
  #   #  def tag(taggable, opts={})
  #   #    opts.reverse_merge!(:force => true)
  #   #    skip_save = opts.delete(:skip_save)
  #   #    return false unless taggable.respond_to?(:is_taggable?) && taggable.is_taggable?
  #   #    raise "You need to specify a tag context using :on"                unless opts.has_key?(:on)
  #   #    raise "You need to specify some tags using :with"                  unless opts.has_key?(:with)
  #   #    raise "No context :#{opts[:on]} defined in #{taggable.class.to_s}" unless (opts[:force] || taggable.tag_types.include?(opts[:on]))
  #   #    taggable.set_owner_tag_list_on(self, opts[:on].to_s, opts[:with])
  #   #    taggable.save unless skip_save
  #   #  end
  #   #   
  #   #  def is_tagger?
  #   #    self.class.is_tagger?
  #   #  end
  #  end
  # 
  # # module SingletonMethods
  # #   def is_tagger?
  # #     true
  # #   end
  # # end      
end