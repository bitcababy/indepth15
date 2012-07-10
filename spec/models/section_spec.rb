# encoding: UTF-8

require 'spec_helper'

describe Section do
	it { should belong_to :teacher }
	it { should validate_uniqueness_of(:number).scoped_to(:course) }
	it { should have(0).section_assignments }
	
	describe '#add_assignment(due_date, asst)' do
		it "adds the assignment and due_date to the assignments hash" do
			subject = Fabricate :section
			asst = Fabricate :assignment
			expect {
				subject.add_assignment(Date.today, asst)
			}.to change {subject.section_assignments.count}.by(1)
		end
	end
	
	context "past and future assignment handling" do
		before do
			@section = Fabricate :section
			3.times { @section.add_assignment Utils.future_due_date +  rand(1..5), Fabricate(:assignment) }
			2.times { @section.add_assignment Utils.future_due_date - rand(1..5), Fabricate(:assignment) }
		end
	
		it "should be able to return all future or past assignments" do
			@section.section_assignments.future.count.should == 3
			@section.future_assignments.count.should == 3
			@section.section_assignments.past.count.should == 2
			@section.past_assignments.count.should == 2
		end
	end
	
	context "importing" do
		describe '::convert_record' do
			before :each do
				Import::Teacher.load_from_data
				Import::Course.load_from_data
				@hash = {
					"orig_id"=>629, "dept_id"=>1, "course_num"=>342, "number"=>1, 
					"semesters"=>12, "block"=>"A", "year"=>2012, "which_occurrences"=>"all", 
					"room"=>8, "teacher_id"=>"griswoldn", "sched_color"=>"AliceBlue", 
					"style_id"=>3
				}
				@section = Section.convert_record(@hash)
			end
			
			it "fixes up the semester" do
				@section.semester.should == :first
			end
			
			it "fixes up occurrences" do
				@section.occurrences.should == (1..5).to_a
			end
			
			it "links to its course" do
				@section.course.should_not be_nil
			end
			it "links to its teacher" do
				@section.teacher.should_not be_nil
			end

		end
	end			

end
