class CourseDocument < TextDocument
  include Mongoid::History::Trackable
  track_history version_field: :version, track_create: true

end
