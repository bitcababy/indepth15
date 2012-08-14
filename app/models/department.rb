class Department
  include Mongoid::Document
  include Mongoid::Timestamps if Rails.env == 'production'
end
