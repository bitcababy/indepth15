require 'spec_helper'

describe Teacher do
	it { should have_many(:sections) }
	
	context "scopes" do
		it "should return current teachers" do
			3.times {Fabricate(:teacher, current: true)}
			2.times {Fabricate(:teacher, current: false)}
			Teacher.count.should == 5
			Teacher.current.count.should == 3
		end
	end
		
end
