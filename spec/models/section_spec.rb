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
	
			
			

end
