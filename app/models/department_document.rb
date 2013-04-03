class DepartmentDocument < TextDocument
  include Mongoid::Ordered
  include Mongoid::History::Trackable

  field :ti, as: :title, type: String, default: ""
  validates :title, presence: true

  ordered_on :pos
  embedded_in :department

  track_history track_create: false
  
  def to_s
    return "Doc titled #{title}"
  end

  def update_from_params(params)
    self.title = params[:title]
    self.content = params[:content]
    self.department.save
  end

end
