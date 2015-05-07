FactoryGirl.define do

  ## Sequences ##
  sequence :doc_title do |n|
    "Title #{n}"
  end

  sequence :doc_contents do |n|
    "Blah blah blah #{n}"
  end

  sequence :assignment_number do |n|
    n
  end

  ## Traits ##
  trait :document_traits do
    content { generate :doc_contents }
  end

  ## Factories
  factory :department_document, traits: [:document_traits] do
    title       { generate :doc_title }
    department
  end

  factory :course_document, traits: [:document_traits] do
    kind        { CourseDocument::KINDS.sample }
    course
  end

  factory :assignment, traits: [:document_traits] do
    number     { generate :assignment_number }
    name      { number.to_s }
  end

end
