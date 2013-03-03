require 'spec_helper'

describe SectionAssignment do
  %i(section assignment course teacher).each {|rel|
    it { should belong_to rel}
  }
  it { should respond_to :block }
  
  context "Fabrication" do
    it "should have associated records" do
      sa = Fabricate :section_assignment
      sa.section.should_not be_nil
      sa.section.course.should_not be_nil
      sa.assignment.should_not be_nil
      sa.assignment.name.should_not be_nil
    end
  end
	
	context "scoping and delegation" do
		before :each do
			@section = Fabricate :section, block: "B"
			3.times {|i| Fabricate :future_section_assignment, section: @section }
			4.times {|i| Fabricate :past_section_assignment, section: @section }
		end
    
    it "has a 'due_on_or_after', scope" do
      @section.section_assignments.due_on_or_after(Date.today).to_a.count.should eq 3
    end
      
    it "has a 'due_after' scope" do
      @section.section_assignments.due_after(Date.today).to_a.count.should eq 3
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
		
    it "has a for_year scope" do
      s = Fabricate :section, academic_year: 2012
      2.times { Fabricate :section_assignment, section: s }
      SectionAssignment.for_year(2012).to_a.count.should eq 2
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

  # describe "assigned validation" do
  #   it "can't have assigned set if the assignment's name or contents are empty" do
  #     asst = Fabricate :assignment, name: "", content: ""
  #     sa = Fabricate.build :section_assignment, assignment: asst, assigned: true
  #     sa.should_not be_valid
  #   end
  # end

end
