class SectionAssignmentObserver < Mongoid::Observer
  def after_create(sa)
    BrowserRecord.create_from_sa(sa)
  end
  
end
