require 'spec_helper'

describe AssignmentsController do
  describe "GET 'new'" do
    before :each do
      course = Fabricate :course, number: 322
      teacher = Fabricate :teacher, login: 'doej'
      Fabricate :section, course: course, teacher: teacher
      Fabricate :section, course: course, teacher: teacher
      puts teacher.sections
      teacher.sections.for_course(course).count.should == 2
      get 'new', course_id: course.to_param, teacher_id: teacher.to_param
    end
    it "should succeed" do
      response.should be_success
    end
    it "should create a new assignment" do
			assigns[:assignment].should_not be_nil
    end
    it "should create two new section assignments" do
      asst = assigns[:assignment]
      asst.should_not be_nil
      asst.section_assignments.should_not be_nil
      asst.section_assignments.count.should == 2
    end
    it "should render the right template" do
      response.should render_template('new')
    end
    
  end
  
end
