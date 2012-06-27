require 'spec_helper'

describe Course do
	it { should have_many(:sections) }
	it { should validate_uniqueness_of(:number).scoped_to(:academic_year) }
	
	context "A new course" do
		subject {Fabricate(:course)}
		it { should have(0).sections }
	end
	
	context "changes" do
		subject {Fabricate(:course)}
		it "should have one more section when it adds a section" do
			expect {
				subject.sections << Fabricate(:section, course: subject)
			}.to change {subject.sections.count}.by(1)
		end
	end

	context '#teachers' do
		it "should return a list of the teachers teaching the course" do 
			course = Fabricate(:course)
			t1 = Fabricate(:teacher)
			t2 = Fabricate(:teacher)
			3.times {Fabricate :section, course: course, teacher: t1}
			2.times {Fabricate :section, course: course, teacher: t2}
			course.teachers.count.should == 2
		end
	end
end
