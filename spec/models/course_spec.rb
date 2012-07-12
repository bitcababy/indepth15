require 'spec_helper'

describe Course do
	it { should have_many(:sections) }
	it { should validate_uniqueness_of(:number).scoped_to(:academic_year) }
	it { should have_and_belong_to_many(:course_tags) }
	it { should have_and_belong_to_many(:major_tags) }
	it { should belong_to(:branch) }
	
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
	
	context "Validation" do
		it "should have a unique number for a given year" do
			course1 = Fabricate(:course)
			course2 = Course.new course1.attributes
			course2.academic_year += 1
			course2.should be_valid
		end
		
	end
		
	describe "#clone_for_year" do
		it "copies all attributes and sets the year" do
			course1 = Fabricate(:course, academic_year: Course::NO_YEAR)
			Course.where(academic_year: 2012).exists?.should be_false
			course2 = course1.clone_for_year(2012)
			course2.should_not be_nil
			course2.academic_year.should == 2012
		end
	end
	
		
end
