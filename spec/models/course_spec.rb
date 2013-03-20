require 'spec_helper'

describe Course do
  %i(number duration credits full_name).each do |field|
	  it { should validate_presence_of(field) }
  end

	it { should validate_uniqueness_of(:number) }
  
	it { should embed_many :documents }
	it { should have_many(:sections) }
  it { should belong_to :department }
  it { should have_and_belong_to_many :major_topics }
  
  describe "Fabricator" do
    it "creates a valid course" do
      expect(Fabricate.build :course).to be_valid
     end
    it "can create sections" do
      course = Fabricate :course, num_sections: 3
      expect(course.sections.count).to eq 3
    end
  end
  
  describe '#branches' do
    it "returns the branches that a course belongs to" do
      expect( 
        Fabricate(:course, number: Course::BRANCH_MAP.keys.sample).branches
      ).to be_kind_of Array
    end
  end
    
  describe '#add_major_topics' do
    it "adds the the major topics from the BRANCH_MAP" do
      course = Fabricate.build :course, number: 321
      course.add_major_topics
      pending "unfinished test"
    end
  end

  describe '#current?' do
    it "should return true iff it has sections" do
      course = Fabricate :course
      expect {
        course.sections << Fabricate(:section, course: course) 
      }.to change { course.current? }.from(false).to(true)
    end
  end

  context "extensions" do
    describe 'sections.for_teacher' do
      it "returns the section taught by a given teacher" do
        t1 = Fabricate :teacher
        t2 = Fabricate :teacher
        course = Fabricate :course, teacher: t1, num_sections: 3
        2.times { course.sections << Fabricate(:section, course: course, teacher: t2) }
        expect(course.sections.count).to eq 5
        expect(course.sections.for_teacher(t1).count).to eq 3
        expect(course.sections.for_teacher(t2).count).to eq 2
      end
    end
    
    describe 'sections.current' do
      it "returns the sections taught this year" do
        course = Fabricate :course, num_sections: 2
        3.times { course.sections << Fabricate(:section, course: course, year: Settings.academic_year - 1) }
        expect(course.sections.current.count).to eq 2
      end
    end
  end
  
  it "should return the teachers of a course" do
    t1 = Fabricate :teacher
    t2 = Fabricate :teacher
    course = Fabricate :course, num_sections: 1, teacher: t1
    Fabricate :section, teacher: t2, course: course
    expect(course.teachers).to include t1
    expect(course.teachers).to include t2
  end
    
  it "should return the teachers of the current sections" do
    t1 = Fabricate :teacher
    t2 = Fabricate :teacher
    course = Fabricate :course, num_sections: 1, teacher: t1
    Fabricate :section, teacher: t1, course: course
    Fabricate :section, teacher: t2, course: course
    expect(course.sections.count).to eq 3
    expect(course.current_teachers).to include t1
    expect(course.current_teachers).to include t2
  end
		
end
