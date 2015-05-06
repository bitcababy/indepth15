FactoryGirl.define do

  ## Sequences ##

  sequence :email do |n|
    "person#{n}@example.com"
  end

  sequence :last_name_seq do |n|
    %W(Smith Jones Lee).sample + n.to_s
  end

  ## Traits ##
  trait :email_and_password do
    email   { generate :email}
    password "foobar"
    password_confirmation "foobar"
  end

  trait :with_name do
    honorific "Mr."
    first_name "Sam"
    last_name "Spade"
  end

  ##
  ## Factories
  ##

  factory :user, traits: [:email_and_password] do
  end

  factory :teacher, traits: [:email_and_password, :with_name] do
    current   true
    sections  []
  end


end
