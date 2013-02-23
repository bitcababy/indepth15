require 'spec_helper'

describe BrowserRecord do
  before :each do
    course = Fabricate :course
    teacher = Fabricate :teacher
    @section = Fabricate :section, course: course
    @asst = Fabricate :assignment
  end
  
  [:course, :teacher, :section, :section_assignment, :assignment].each do |r|
    it { should belong_to r }
  end
  [:academic_year, :course_name, :last_name, :first_name, :block, :due_date].each do |f|
    it { should validate_presence_of f }
  end
  
  describe '::create_from_sa' do
    it "should be triggered by creating a new section assignment" do
      sa = Fabricate.build :section_assignment, section: @section, assignment: @asst
      sa.save
      sa.browser_record.should be_kind_of BrowserRecord
    end
  end
  
  describe 'updating' do
    before :each do
      sa = Fabricate :section_assignment, section: @section, assignment: @asst
      @br = sa.browser_record
    end
    it "should update its due_date if its section_assignment changes its due_date" do
      sa = @br.section_assignment
      d = Date.today - 365
      sa.due_date = d
      sa.save
      @br.due_date.should eq d
    end
  end
  
end
