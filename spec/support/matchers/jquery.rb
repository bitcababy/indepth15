RSpec::Matchers.define :have_class do |cl|
  match do |el|
    el[:class].split(' ').contains? cl
  end

  failure_message_for_should do |elem|
    "Expected #{elem} to have class #{cl}"
  end
  
  failure_message_for_should_not do |elem|
    "Expected #{elem} to not contain #{cl}"
  end
  
  description do
    "expected an element with class #{cl}"
  end
end
