require 'spec_helper'

describe AssignmentsController do
  describe "GET 'new'" do
    before :each do
      teacher = Fabricate :teacher, login: "xyzzy"
      course = Fabricate :course
      @cs = (0..2).collect {|i| 
        Fabricate :section, teacher: teacher, course: course, academic_year: Settings.academic_year, block: ('A'..'H').to_a[i]
      }
      @os = (0..1).collect {|i| 
        Fabricate :section, teacher: teacher, course: course, academic_year: Settings.academic_year-1, block: ('A'..'H').to_a[i]
      }
      
      get :new, teacher_id: teacher.to_param, course_id: course.to_param
      response.should be_success
    end
    it "should create a new assignment" do
      assigns[:assignment].should be_kind_of Assignment
    end
    
    it "should build section assignments for each section and the new assignment" do
      assigns[:sas].should be_kind_of Array
      assigns[:sas].count.should == @cs.size
      assigns[:sas].each do |sa|
         @cs.should include sa.section
      end
    end
    
    it "should render the 'new' template" do
      response.should render_template :new
    end
      
  end
  
  # {"utf8"=>"✓",
  #  "authenticity_token"=>"Dg2hSqMqJnqxMxJm8wAwc74Yqk57LYHviLUR8/5ea/s=",
  #  "assignment"=>{"section_assignments_attributes"=>{"0"=>{"due_date"=>"2013-02-12",
  #  "use"=>"1"},
  #  "1"=>{"due_date"=>"2013-02-12",
  #  "use"=>"1"}},
  #  "content"=>""}}
  
  describe "PUT create" do
    it "saves the assignment" do
      put :create, assignment: {"section_assignments_attributes"=>{"0"=>{"due_date"=>"2013-02-12",
             "use"=>"1"},
             "1"=>{"due_date"=>"2013-02-12",
             "use"=>"1"}},
             "content"=>"Some content"}
    end
    it "saves the section assignments"
  end
      
end
