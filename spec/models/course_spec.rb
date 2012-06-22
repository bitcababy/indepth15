require 'spec_helper'

describe Course do
	context "validation" do
		it { should validate_uniqueness_of :number }
	end
	
	it { should have(0).sections }
	
	context "associations" do
		specify { subject.information.should_not be_nil }
		specify { subject.description.should_not be_nil }
		specify { subject.resources.should_not be_nil }
		specify { subject.policies.should_not be_nil }
		specify { subject.news.should_not be_nil }
	end
	
	

end
