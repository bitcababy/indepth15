FactoryGirl.define do

  ## Sequences ##
  sequence :doc_title do |n|
    "Title #{n}"
  end

  sequence :doc_contents do |n|
    "Blah blah blah #{n}"
  end

  sequence :assignment_title do |n|
    n.to_s
  end

  ## Traits ##
  trait :document_traits do
    title    { generate :doc_title }
    content { generate :doc_contents }
  end

  ## Factories
  factory :document, traits: [:document_traits] do
  end

  factory :department_document, traits: [:document_traits] do
    department
  end

  factory :assignment, traits: [:document_traits] do
    title     { generate :assignment_title }
    number     nil
  end

end
