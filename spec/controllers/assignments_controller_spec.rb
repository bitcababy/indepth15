require 'spec_helper'

describe AssignmentsController do
  include DeviseHelpers
  login_user
  
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
  #  "authenticity_token"=>"DhPaLUa1M8OtPHUYOS3IZ4J0KgXw/WTB+SfDZAxqyus=",
  #  "assignment"=>{
  #    "teacher_id"=>"davidsonl",
  #    "section_assignments_attributes"=>{
  #      "0"=>{"due_date"=>"2013-02-14", "use"=>"1", "section"=>"2013/321/davidsonl/B"},
  #      "1"=>{"due_date"=>"2013-02-14", "use"=>"1", "section"=>"2013/321/davidsonl/D"}},
  #      "major_tags"=>["", "Similarity", "Measurement"],
  #      "name"=>"",
  #      "content"=>""
  #   }
  # }   
   describe "PUT create" do
    before :each do
      teacher = Fabricate :teacher
      s1 = Fabricate :section
      s2 = Fabricate :section
      @parms = {
        assignment: {
          "teacher_id" => teacher.to_param,
          "section_assignments_attributes"=>{
          "0"=>{"due_date"=>"2013-02-12", "use"=>"1", "block"=>"B", "section"=>s1.to_param},
          "1"=>{"due_date"=>"2013-02-12", "use"=>"1", "block"=>"D", "section"=>s2.to_param}
          },
          "major_tags"=>["", "Similarity", "Measurement"],
          "content"=>"Some content",
          "name" => "foo",
         }
       }
       session[:form] = {}
       session[:form][:redirect_url] = "/"
    end

    it "creates the assignment" do
      expect { put :create, @parms
      }.to change{ Assignment.count }.by(1)
    end
    it "creates the section_assignments" do
      expect { put :create, @parms
      }.to change{ SectionAssignment.count }.by(2)
    end
  end
      
end
