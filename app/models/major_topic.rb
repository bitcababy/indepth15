class MajorTopic
  include Mongoid::Document
  field :n, as: :name, type: String, default: ""
  validate :name, uniqueness: true, size: { minimum: 3 }
  field :s, as: :subtopics, type: SortedSet, default: SortedSet.new
  field :_id, type: String, default: ->{ name }
 
  # has_and_belongs_to_many :assignments
  # has_and_belongs_to_many :courses
  
  cattr_reader :none_topic
  
  ##
  # class methods
  ##
  def self.none_topic
    return @none_topic || NoneTopic.find_or_create_by(name: "None")
  end

  def self.names_for_topics(*tags)
    tags = tags[0] if tags[0].kind_of? Array
    return tags.collect {|t| t.to_s}
  end
  
  def self.subtopics_for(*tags)
    tags = tags[0] if tags[0].kind_of? Array
    return tags if tags.empty?
    subtopics = tags.collect {|t| subtopics}
    return subtopics.flatten
  end

  def to_s
    self.name
  end
  
  def none_topic
    self.class.none_topic
  end

  def add_subtopics(*tags)
    tags = tags[0] if tags[0].kind_of? Array
    self.subtopics = self.subtopics.merge tags
    self.save!
    self.none_topic.add_subtopics(tags)
  end

end
