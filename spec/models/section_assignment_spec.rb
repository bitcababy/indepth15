require 'spec_helper'

describe SectionAssignment do
	it { should be_embedded_in :section }
	it { should belong_to :assignment }
	
	it "should have future and past scopes" do
		section = Fabricate(:section)
		2.times { section.add_assignment Date.today + rand(1..5), Fabricate(:assignment) }
		3.times { section.add_assignment Date.today - rand(1..5), Fabricate(:assignment) }
		section.sas.future.count.should == 2
		section.sas.past.count.should == 3
	end

end
