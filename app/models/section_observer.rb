class SectionObserver < Mongoid::Observer

  def after_create(s)
    s.teacher.courses << s.course
    s.save
  end
 
end
