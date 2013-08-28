class CourseDocument < TextDocument
  field :kind, type: Symbol
  embedded_in :course
  
  def update_from_params(params)
    self.content = params[:content]
    self.course.save
  end
end
