class CourseDocument < TextDocument
  include Mongoid::Locker
  enable_locking_with :locked_at
  
end
