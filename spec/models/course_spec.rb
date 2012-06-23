require 'spec_helper'

describe Course do
	it { should have_many(:sections) }
	it { should validate_uniqueness_of(:number).scoped_to(:academic_year) }
	
	context "changes" do
		subject {Fabricate(:course)}
		it "should have one more section when it adds a section" do
			expect {
				subject.sections << Fabricate(:section, course: subject)
			}.to change {subject.sections.count}.by(1)
		end
	end

end
