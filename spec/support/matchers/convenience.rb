RSpec::Matchers.define :contain do |expected|
	match do |actual|
		actual.contains? expected
	end

	description do
		"expected #{expected} to contain #{actual}"
	end

	failure_message_for_should do |elem|
		"Expected #{expected} to contain #{actual}"
	end
	
	failure_message_for_should_not do |elem|
		"Expected #{expected} to not contain #{elem}"
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
	

