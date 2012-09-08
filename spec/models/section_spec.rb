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
	
	context "scopes" do
		it "should have a 'for_year scope" do
			2.times { Fabricate :section, academic_year: 2013 }
			3.times { Fabricate :section, academic_year: 2010 }
			Section.for_year(2013).count.should == 2
		end

		# it "should have a 'for_course scope'" do
		# 	course = Fabricate :course
			
	end
		
	context "validation" do
		it { should validate_presence_of :block }
		it { should validate_presence_of :academic_year }
		it { should validate_presence_of :semester }
	end
	
	describe 'fabricator' do
		it "creates a valid section" do
			teacher = Fabricate :teacher
			teacher.should_not be_nil
			section = Fabricate.build :section, block: "E", teacher: teacher
			section.should be_valid
			section.teacher.should_not be_nil
			section.teacher.should == teacher
			section.course.should_not be_nil
		end
	end
	
	describe '#days_for_section' do
		it "returns an array of days for its occurrences" do
			section = Fabricate :section, valid_attributes
			(1..5).each do |i|
				section.occurrences.create! number: i, block: section.block, day: i
			end
			section.days_for_section.should eql([1,2,3,4,5])
		end
	end
	
	describe '#add_assignment(name, asst, due_date)' do
		it "adds the assignment and due_date to the assignments hash" do
			subject = Section.create! valid_attributes
			asst = Fabricate :assignment
			expect {
				subject.add_assignment("foo", asst, Date.today)
			}.to change {subject.section_assignments.count}.by(1)
		end
	end
	
	context "past and future assignment handling" do
		before do
			@section = Fabricate :section, valid_attributes
			3.times {|i| @section.add_assignment "future#{i}", Fabricate(:assignment), future_due_date + i }
			2.times {|i| @section.add_assignment "past#{i}", Fabricate(:assignment), future_due_date - i - 1 }
			@section.section_assignments.count.should == 5
		end
	
		it "should be able to return all future or past assignments" do
			@section.future_assignments.count.should == 3
			@section.past_assignments.count.should == 2
			@section.current_assignments.count.should == 1
			@section.upcoming_assignments.count.should == 2
		end
	end
	
	describe '::import_from_hash' do
		it "creates a section from a hash representing an old record" do
			Fabricate :course, number: 332
			Fabricate :teacher, login: 'davidsonl'
			hash = {:dept_id=>1, :course_num=>332, :number=>4, :semesters=>12, :block=>"G", :year=>2011, 
							:which_occurrences=>"all", :room=>200, :teacher_id=>"davidsonl"}
			section = Section.import_from_hash(hash)
			section.should be_kind_of Section
			pending "Unfinished test"
		end
	end
			
end
