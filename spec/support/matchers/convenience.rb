RSpec::Matchers.define :contain do |a|
	match do |arr|
		arr.contains? a
	end

	failure_message_for_should do |a|
		"Expected #{arr} to contain #{a}"
	end
	
	failure_message_for_should_not do |a|
		"Expected #{arr} to not contain #{a}"
	end
	
	description do
		"expected an object that's in #{arr}"
	end
end
	

