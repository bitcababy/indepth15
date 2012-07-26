require 'spec_helper'

describe Course do
	it { should have_many(:sections) }
	it { should validate_uniqueness_of(:number)}
	it { should have_and_belong_to_many(:major_tags) }

	[:information_doc, :resources_doc, :policies_doc, :news_doc, :description_doc].each do |doc|
		it { should have_one(doc) }
	end
	
	context "Fabricator" do
		subject { Fabricate(:course) }
		it { should have(0).sections }
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
				prog_of_studies_descr: "This is the description",
				info: "This is the info",
				policies: "These is the policies",
				resources: "This is the resources",
				has_assignments:true
			}
			course = Course.import_from_hash hash
			course.should be_kind_of Course
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
		
end
