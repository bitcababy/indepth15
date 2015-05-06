FactoryGirl.define do

  trait :current_year do
    year      { Settings.academic_year }
  end

  sequence :block do |h|
    Settings.blocks.sample
  end

  factory :section do
    block    { generate :block }
    semester { [1,2,0].sample }
    year     { Array(2012..2015).sample }
    days     { Array(1..8).sample(5) }
    room     ""

    course
    teacher

    # after [:build] do |section, evaluator|
    #   unless section.course
    #     section.course = evaluator.course || build(:course)
    #   end
    # end

    factory :current_section, traits: [:current_year]
  end

end
