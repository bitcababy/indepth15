class CourseDocument < Document
  include Mongoid::History::Trackable

  field :co, as: :content, type: String, default: ""
  field :kind, type: Symbol
  embedded_in :course
  
  track_history track_create: true

  def update_from_params(params)
    self.content = params[:content]
    self.course.save
  end
end
