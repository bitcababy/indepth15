# encoding: UTF-8

require 'spec_helper'

describe Section do
	include Utils

	def valid_attributes
		{
			room: 501,
			academic_year: Settings.academic_year,
			semester: Course::FIRST_SEMESTER,
			block: "B"
		}
	end
	
	it { should belong_to :teacher }
	it { should have(0).section_assignments }
	
	context "validation" do
		it { should validate_presence_of :block }
		it { should validate_presence_of :academic_year }
		it { should validate_presence_of :semester }
	end
	
	describe 'fabricator' do
		it "creates a valid section" do
			section = Fabricate :section
			section.should be_valid
			end
	end

	describe 'find_or_create_occurrence' do
		it "adds an occurrence" do
			pending "Unfinished test"
			section = Section.create! valid_attributes
			res = section.find_or_create_occurrence number: 1, day: 1
			res.should be_kind_of Occurrence
		end
	end
	
	describe '#days_for_section' do
		it "returns an array of days for its occurrences" do
			section = Section.create! valid_attributes
			(1..5).each do |i|
				Occurrence.create! number: i, block: section.block, day: i
			end
			section.days_for_section.should eql([1,2,3,4,5])
		end
	end
	
	describe '#add_assignment(asst, due_date)' do
		it "adds the assignment and due_date to the assignments hash" do
			subject = Section.create! valid_attributes
			asst = Fabricate :assignment
			expect {
				subject.add_assignment(asst, Date.today)
			}.to change {subject.section_assignments.count}.by(1)
		end
	end
	
	context "past and future assignment handling" do
		before do
			@section = Section.create! valid_attributes
			3.times { @section.add_assignment Fabricate(:assignment), Utils.future_due_date + rand(1..5) }
			2.times { @section.add_assignment Fabricate(:assignment), Utils.future_due_date - rand(1..5) }
		end
	
		it "should be able to return all future or past assignments" do
			@section.section_assignments.future.count.should == 3
			@section.future_assignments.count.should == 3
			@section.section_assignments.past.count.should == 2
			@section.past_assignments.count.should == 2
		end
	end
	
		
end
