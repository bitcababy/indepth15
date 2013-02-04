class DepartmentDocument < TitledDocument
  include Mongoid::Ordered
  include Mongoid::History::Trackable

  ordered_on :pos
  belongs_to :department

  track_history version_field: :version

end
