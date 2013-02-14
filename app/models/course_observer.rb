class CourseObserver < Mongoid::Observer
  include Mongoid::History::Tracker

  def after_create(course)
    branches = Course::BRANCH_MAP[course.number].to_a
    tags = (branches.collect {|b| Course::MAJOR_TAG_MAP[b]}).flatten
    tags.uniq!
    mts = tags.collect { |tag| MajorTag.find_or_create_by name: tag }
    course.major_tags = mts
    course.save!
  end
  
end
