class CourseDocument < TextDocument
  KINDS =  [:resources, :news, :policies, :information, :description]

  field :kind, type: Symbol
  embedded_in :course

  def update_from_params(params)
    self.content = params[:content]
    self.course.save
  end
end
