class Mongoid::Tagging
  include Mongoid::Document
 
  field :c, as: :context, type: Symbol
  validates_presence_of :context

  belongs_to :taggable, polymorphic: true
  belongs_to :tag, class_name: 'Mongoid::Tag'
  belongs_to :tagger,   :polymorphic => true

  validates_uniqueness_of :tag, scope: [ :taggable, :context, :tagger ]
  validate :must_have_valid_tag
  
  delegate :name, to: :tag

  private
  
  def must_have_valid_tag
    errors.add(:tag, "can't be blank") unless self.tag.valid?
  end

end
