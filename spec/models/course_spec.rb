require 'spec_helper'

describe Course do
	it { should have_many(:sections) }
	it { should validate_uniqueness_of(:number).scoped_to(:academic_year) }
	it { should have_and_belong_to_many(:major_tags) }
	[:information_doc, :resources_doc, :policies_doc, :news_doc, :description_doc].each do |doc|
		it { should have_one(doc) }
	end
	
	context "Fabricator" do
		subject { Fabricate(:course) }
		it { should have(0).sections }
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
		it "should be able to change its information" do
			expect {
				@course.information = "Some info"
			}.to change{@course.information}.to("Some info")
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
