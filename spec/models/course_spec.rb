require 'spec_helper'

describe Course do
	it { should have_many(:sections) }
	it { should validate_uniqueness_of(:number)}
	it { should have_and_belong_to_many(:major_tags) }
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
		
	describe '::import_from_hash' do
		it "imports from a hash" do
			hash = {
				number: 321,
				full_name: "Geometry Honors",
				short_name: "",
				schedule_name: "GeomH",
				semesters: 12,
				credits: 5.0,
				description: "This is the description",
				information: "This is the info",
				policies: "These is the policies",
				resources: "This is the resources",
				news: "This is the news",
				has_assignments:true
			}
			course = Course.import_from_hash hash
			course.should be_kind_of Course
			course.number.should == 321
			course.full_name.should == "Geometry Honors"
			course.short_name.should == ''
			course.schedule_name.should == "GeomH"
			course.duration.should == Course::FULL_YEAR
			course.credits.should == 5.0
			# course.branches.count.should > 0
			# course.major_tags.count.should > 0
			course.description.content.should == "This is the description"
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
