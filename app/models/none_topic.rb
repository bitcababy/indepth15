class NoneTopic < MajorTopic

  def add_subtopics(*tags)
    tags = tags[0] if tags[0].kind_of? Array
    self.subtopics = self.subtopics.merge tags
    self.save!
  end

end
