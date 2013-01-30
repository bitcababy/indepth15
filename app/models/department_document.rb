class DepartmentDocument < TitledDocument
  include Mongoid::Ordered

  ordered_on :pos
  belongs_to :department

end
