FactoryGirl.define do

  factory :course do
    sequence(:number, 300)
    _id      { number }
    name     { "Course #{number}" }
    credits  5.0
    sections  []
  end

end
