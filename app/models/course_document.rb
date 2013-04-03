class CourseDocument < TextDocument
  include Mongoid::History::Trackable

  field :kind, type: Symbol
  embedded_in :course
  
  track_history track_create: false

  def update_from_params(params)
    self.content = params[:content]
    self.course.save
  end
end
