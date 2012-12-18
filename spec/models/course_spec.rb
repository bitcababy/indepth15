require 'spec_helper'

describe Course do
	it { should have_many(:sections) }
	it { should validate_uniqueness_of(:number)}
	it { should belong_to :information }
	it { should belong_to :resources }
	it { should belong_to :policies }
	it { should belong_to :news }
	
	context "Fabricator" do
		it "creates courses with unique numbers" do
			course1 = Fabricate.build(:course)
			course2 = Fabricate.build(:course)
			course1.number.should_not == course2.number
		end
	end
		
	
	context "changes" do
		before :each do
			@course = Fabricate(:course)
		end

		it "should have one more section when it adds a section" do
			expect {
				@course.sections << Fabricate(:section, course: @course)
			}.to change {@course.sections.count}.by(1)
		end

	end

	# context '#teachers' do
	# 	it "should return a list of the teachers teaching the course" do 
	# 		course = Fabricate(:course)
	# 		t1 = Fabricate(:teacher)
	# 		t2 = Fabricate(:teacher)
	# 		3.times {Fabricate :section, course: course, teacher: t1}
	# 		2.times {Fabricate :section, course: course, teacher: t2}
	# 		course.teachers.count.should == 2
	# 	end
	# end
		
end
