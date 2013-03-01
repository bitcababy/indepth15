# This stores the highest value of the assignment numbers of a given course for a teacher
class AsstNumber
  include Mongoid::Document

  field :n, as: :number, type: Integer, default: 0
  belongs_to :course, inverse_of: nil
  embedded_in :teacher
  
  def to_s
    "#{self.course.number}/#{number}"
  end

end
