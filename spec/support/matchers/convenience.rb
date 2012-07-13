RSpec::Matchers.define :contain do |a|
	match do |arr|
		arr.contains? a
	end

	failure_message_for_should do |elem|
		"Expected #{arr} to contain #{elem}"
	end
	
	failure_message_for_should_not do |elem|
		"Expected #{arr} to not contain #{elem}"
	end
	
	description do
		"expected an object that's in #{arr}"
	end
end
	
RSpec::Matchers.define :exist do
	match do |cond|
		cond.exists?
	end

	failure_message_for_should do |cond|
		"Expected #{cond} to exist"
	end
	
	failure_message_for_should_not do |cond|
		"Expected #{cond} to not exist"
	end
	
	description do |cond|
		"Tests whethere an object exists"
	end
end
	

