require 'spec_helper'

describe SectionAssignment do
	it { should belong_to :section }
	it { should belong_to :assignment }
  # it { should accept_nested_attributes_for :section }
  it { should respond_to :block }
	
	context "scoping and delegation" do
		before :each do
			@section = Fabricate :section, block: "B"
			3.times {|i| Fabricate :future_section_assignment, section: @section }
			4.times {|i| Fabricate :past_section_assignment, section: @section }
		end
    
    it "should be able to get its block from its section" do
      sa = Fabricate :section_assignment, section: @section
      sa.block.should == "B"
    end
		
		it "has a for_section scope" do
			SectionAssignment.for_section(@section).to_a.count.should == 7
		end
		
		it "has a future scope" do
			SectionAssignment.for_section(@section).future.to_a.count.should == 3
		end
		
		it "has a past scope" do
			SectionAssignment.past.to_a.count.should == 4
		end
		
		it "has a next_assignment scope" do
			SectionAssignment.next_assignment.to_a.count.should == 1
		end

		it "has an upcoming scope" do
			SectionAssignment.upcoming.to_a.count.should == 2
		end
		
	end
	
  describe "test updating" do
    before :each do
      @sa = Fabricate :section_assignment
    end
    
    it "should update itself" do
      @sa.update_attributes({name: "foo"}).should be_true
    end
  end

end
