FactoryGirl.define do

  factory :course do
    sequence(:number, 300)
    _id      { number }
    full_name     { "Course #{number}" }
    credits  5.0
    sections  []
  end

end
