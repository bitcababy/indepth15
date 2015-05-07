FactoryGirl.define do

  ## Sequences ##

  sequence :email do |n|
    "person#{n}@example.com"
  end

  sequence :last_name_seq do |n|
    %W(Smith Jones Lee).sample + n.to_s
  end

  sequence :login_seq do |n|
    n.to_s
  end

  ## Traits ##
  trait :user_traits do
    email   { generate :email}
    password "foobar"
    password_confirmation "foobar"
    honorific "Mr."
    first_name "Sam"
    last_name "Spade"
    login       { last_name.downcase + first_name.downcase[0] + generate(:login_seq) }
  end

  ##
  ## Factories
  ##

  factory :user, traits: [:user_traits] do
  end

  factory :teacher, traits: [:user_traits] do
    current   true
    sections  []
  end


end
