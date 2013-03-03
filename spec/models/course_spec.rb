require 'spec_helper'

describe Course do
  [:number, :duration, :credits, :full_name].each do |field|
	  it { should validate_presence_of(field)}
  end

	it { should validate_uniqueness_of(:number)}
  
	it { should embed_many :documents }
	it { should have_many(:sections) }
  it { should belong_to :department }
  it { should have_and_belong_to_many :major_topics }
  # it { should have_and_belong_to_many :teachers }
  # 
  
  describe '#branches' do
    it "returns the branches that a course belongs to" do
      course = Fabricate.build :course, number: Course::BRANCH_MAP.keys.sample
      course.branches.should be_kind_of Array
    end
  end

    
  describe '#add_major_topics' do
    it "adds the the major topics from the BRANCH_MAP" do
      course = Fabricate.build :course, number: 321
      course.add_major_topics
      pending "unfinished test"
    end
  end

  describe '#current_teachers' do
    it "should return the teachers of the current sections" do
      t1 = Fabricate :teacher
      t2 = Fabricate :teacher
      course = Fabricate :course
      Fabricate :section, teacher: t1, course: course
      Fabricate :section, teacher: t2, course: course
      course.current_teachers.should contain t1
      course.current_teachers.should contain t2
    end
  end
  
	
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
