require 'spec_helper'

describe Section do
	it { should belong_to :teacher }
	it { should validate_uniqueness_of(:number).scoped_to(:course) }
	
	describe '#add_assignment(due_date, asst)' do
		it "adds the assignment and due_date to the assignments hash" do
			expect {
				subject.add_assignment(Date.today, Fabricate(:assignment))
			}.to change {subject.assignments.count}.by(1)
		end
	end
	
	describe '#future_assignments'
		

end
