require 'spec_helper'

describe SectionAssignment do
  %i(section assignment course teacher).each {|rel|
    it { should belong_to rel}
  }
  it { should respond_to :block }
  
  context "Fabrication" do
    it "should be valid" do
      expect(Fabricate.build :section_assignment).to be_valid
    end
    it "should have associated records" do
      sa = Fabricate :section_assignment
      expect(sa.section).to_not be_nil
      expect(sa.section.course).to_not be_nil
      expect(sa.assignment).to_not be_nil
      expect(sa.assignment.name).to_not be_nil
    end
    
    it "should be able to create past sas" do
      expect(Fabricate(:section_assignment_past).due_date).to be < Date.today
    end
  end
  
  subject { Fabricate :section_assignment }
	
	context "scoping and delegation" do
		before :each do
			@section = Fabricate :section, block: "B"
			3.times {|i| Fabricate :section_assignment_future, section: @section }
			4.times {|i| Fabricate :section_assignment_past, section: @section }
		end
    
    it "has a 'for_section' scope" do
      expect(SectionAssignment.for_section(@section).count).to eq 7
    end
    
    # it "has a 'for_year' scope" do
    #   sa = Fabricate :section_assignment, section: Fabricate(:section, year: (Settings.academic_year - 2))
    #   expect(SectionAssignment.for_year(Settings.academic_year).count).to eq 7
    # end
    # 
    it "has a due_after scope" do
      expect(@section.section_assignments.due_after(Date.today).to_a.count).to eq 3
    end
    
    it "has a 'due_on_or_after' scope" do
      expect(@section.section_assignments.due_on_or_after(Date.today).to_a.count).to eq 3
    end
      
    it "has a 'due_after' scope" do
      expect(@section.section_assignments.due_after(Date.today).to_a.count).to eq 3
    end

    it "should be able to get its block from its section" do
      sa = Fabricate :section_assignment, section: @section
      expect(sa.block).to eq "B"
    end
		
		it "has a future scope" do
			expect(SectionAssignment.for_section(@section).future.to_a.count).to eq 3
		end
		
		it "has a past scope" do
			expect(SectionAssignment.past.to_a.count).to eq 4
		end
		
		it "has a next_assignment scope" do
			expect(SectionAssignment.next_assignment.to_a.count).to eq 1
		end

		it "has an upcoming scope" do
			expect(SectionAssignment.upcoming.to_a.count).to eq 2
		end
		
	end
	
  describe "test updating" do
    before :each do
      @sa = Fabricate :section_assignment
    end
    
    it "should update itself"
  end

  # describe "assigned validation" do
  #   it "can't have assigned set if the assignment's name or contents are empty" do
  #     asst = Fabricate :assignment, name: "", content: ""
  #     sa = Fabricate.build :section_assignment, assignment: asst, assigned: true
  #     expect(sa).to_not be_valid
  #   end
  # end

end
