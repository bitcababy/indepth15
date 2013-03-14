# encoding: UTF-8

require 'spec_helper'

describe Section do
	include Utils

	it { should belong_to :teacher }
	it { should belong_to :course }
	it { should have(0).section_assignments }
  
  context "Fabrication" do
    it "should create a valid section" do
      s = Fabricate.build :section
      expect(s).to be_valid
    end

    it "should have a course and teacher" do
      s = Fabricate :section
      expect(s.course).to_not be_nil
      expect(s.teacher).to_not be_nil
    end
    
    it "can create section_assignments" do
      s = Fabricate :section, sas_count: 3
      expect(s.section_assignments.count).to eq 3
    end
  end

  subject { Fabricate :section }
	
	context "scopes" do
    before do
			2.times { Fabricate :section, duration: Course::FULL_YEAR }
			3.times { Fabricate :section, duration: Course::FIRST_SEMESTER }
			4.times { Fabricate :section, duration: Course::SECOND_SEMESTER }
    end

    it "should have a 'current' scope" do
      expect(Section.current.count).to eq 9
    end
    
    it "should have a 'for_first_semester' scope" do
      expect(Section.for_first_semester.count).to eq 5
    end
    
    it "should have a 'for_second_semester' scope" do
      expect(Section.for_second_semester.count).to eq 6
    end
      
    it "should have a 'for_semester' scope" do
      expect(Section.for_semester(Course::FIRST_SEMESTER).count).to eq 5
      expect(Section.for_semester(Course::SECOND_SEMESTER).count).to eq 6
    end
			
	end # Scopes
		
	context "validation" do
		it { should validate_presence_of :block }
		it { should validate_presence_of :duration }
	end
	
	context "past and future assignment handling" do
		before do
			@section = Fabricate :section
			3.times {|i| @section.section_assignments << Fabricate(:section_assignment_future) }
			2.times {|i| @section.section_assignments << Fabricate(:section_assignment_past) }
			expect(@section.section_assignments.to_a.count).to eq 5
		end
	
		it "should be able to return all future or past assignments" do
			expect(@section.future_assignments.to_a.count).to eq 3
			expect(@section.past_assignments.to_a.count).to eq 2
			expect(@section.current_assignments.to_a.count).to eq 1
			expect(@section.upcoming_assignments.to_a.count).to eq 2
		end
	end
	
			
end
