# class TaggableModel
#   include Mongoid::Document
#   include Mongoid::Taggable
# 
#   field :name, type: String
#    # acts_as_taggable_on :languages
#   # acts_as_taggable_on :skills
#   # acts_as_taggable_on :needs, :offerings
#   # has_many :untaggable_models
# end

# class CachedModel
#   include Mongoid::Document
#   # acts_as_taggable
# end
# 
# class OtherCachedModel
#   include Mongoid::Document
#   # acts_as_taggable_on :languages, :statuses, :glasses
# end
# 
# class OtherTaggableModel
#   include Mongoid::Document
#   # acts_as_taggable_on :tags, :languages
#   #  acts_as_taggable_on :needs, :offerings
#  end
# 
# class InheritingTaggableModel < TaggableModel
# end
# 
# class AlteredInheritingTaggableModel < TaggableModel
#   # acts_as_taggable_on :parts
# end
# 
class TaggableUser
  include Mongoid::Document
  field :name, type: String
  # acts_as_tagger
end
# 
# class InheritingTaggableUser < TaggableUser
# end
# 
# class UntaggableModel
#   include Mongoid::Document
#   belongs_to :taggable_model
# end
# 
# class NonStandardIdTaggableModel
#   # include Mongoid::Document
#   #  primary_key = "an_id"
#   #  acts_as_taggable
#   #  acts_as_taggable_on :languages
#   #  acts_as_taggable_on :skills
#   #  acts_as_taggable_on :needs, :offerings
#   #  has_many :untaggable_models
#  end
# 
# class OrderedTaggableModel 
#   # include Mongoid::Document
#   #  acts_as_ordered_taggable
#   #  acts_as_ordered_taggable_on :colours
#  end
