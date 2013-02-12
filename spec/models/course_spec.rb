require 'spec_helper'

describe Course do
	it { should have_many(:sections) }
	it { should validate_presence_of(:number)}
	it { should validate_uniqueness_of(:number)}
	it { should embed_many :documents }
	
  # expect {
  #   sections << Fabricate(:section, course: @course)
  # }.to change { subject.sections.count }.by(1)

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
