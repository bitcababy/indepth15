class SectionObserver < Mongoid::Observer

  def after_create(s)
    unless s.teacher.courses.include? s.course
      s.teacher.courses << s.course
      s.save
    end
  end
 
end
