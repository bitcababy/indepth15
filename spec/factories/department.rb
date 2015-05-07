FactoryGirl.define do

  sequence :dept_name do |n|
    "Department " + n.to_s
  end

  factory :department do
    name    { generate :dept_name }
    homepage_docs []
  end

end
