require 'spec_helper'

describe AssignmentsController do
  include Warden::Test::Helpers  
  login_user
  
  describe "GET 'new'" do
    before :each do
      teacher = Fabricate :teacher
      @course = Fabricate :course
      # @course.major_topics = [
      #   Fabricate(:none_topic),
      #   Fabricate(:major_topic, name: "Quadratics"), 
      #   Fabricate(:major_topic, name: "Functions"), 
      #   Fabricate(:major_topic, name: 'Exponents/Logs'),
      #   Fabricate(:major_topic, name: 'Systems of Equations'),
      # ]
      3.times {
        @course.sections << Fabricate(:section, teacher: teacher, year: Settings.academic_year)
      }
      assigns(:assignment)
      get :new, teacher_id: teacher.to_param, course_id: @course.to_param
      expect(response).to be_success
    end

    it "should build an assignment and section assignments for each current section" do
      expect(asst = assigns[:assignment]).to be_kind_of Assignment
      expect(asst).to_not be_persisted
      expect(asst.section_assignments.to_a.count).to eq 3
    end
     
    it "should render the 'new' template" do
      expect(response).to render_template :new
    end
    
  end # "GET 'new'"
  
  #   "teacher_id"=>"davidsonl", 
  #   "course_id"=>"321", 
  #   "assignment"=>{
  #     "section_assignments_attributes"=>{
  #       "0"=>{
  #         "due_date"=>"2013-03-21", 
  #         "assigned"=>"0", 
  #         "section_id"=>"514361f9df0eda97e900013e"
  #         }, 
  #         "1"=>{
  #           "due_date"=>"2013-03-21", 
  #           "assigned"=>"0", 
  #           "section_id"=>"514361f9df0eda97e9000140"
  #           }
  #         }, 
  #       "name"=>"foo", 
  #       "content"=>"<p>bar</p>\r\n"
  #     }, 
  describe "PUT create" do
    before :each do
      @course = Fabricate :course
      @teacher = Fabricate :teacher
      s1 = Fabricate :section, course: @course, teacher: @teacher
      s2 = Fabricate :section, course: @course, teacher: @teacher
      @parms = {
        assignment: {
          "teacher_id" => @teacher.to_param,
          "course_id" => @course.to_param,
          "section_assignments_attributes"=>{
          "0"=>{"due_date"=>"2013-02-12", "assigned"=>"1", "section_id"=>s1.to_param},
          "1"=>{"due_date"=>"2013-02-12", "assigned"=>"1", "section_id"=>s2.to_param}
          },
          "content"=>"Some content",
          "name" => "foo",
         }
       }
    end
    
    it "creates the assignment" do
      expect { post :create, @parms }
      .to change{ Assignment.count }.by(1)
    end
    it "creates the section_assignments" do
      expect { post :create, @parms }
      .to change{ SectionAssignment.count }.by(2)
    end
  end

  # describe "PUT create, xhr" do
 #    before :each do
 #      @course = Fabricate :course
 #      @teacher = Fabricate :teacher, section_count: 2, courses: [course]
 #      @parms = {
 #        "teacher_id"=>@teacher.to_param, 
 #        "course_id"=>@course.to_param, 
 #        "assignment"=>
 #          { 
 #            "section_assignments_attributes"=>
 #            {"0"=>
 #              {"due_date"=>"2013-03-18", 
 #                "assigned"=>"0", 
 #                "section"=>teacher.sections[0].to_param
 #              }, 
 #              "1"=>{
 #                "due_date"=>"2013-03-18", 
 #                "assigned"=>"0", 
 #                "section"=>teacher.sections[1].to_param
 #                }
 #              }, 
 #            "name"=>"21", 
 #          "content"=>"\n"
 #        }
 #      }
 #      session[:form] = {}
 #      session[:form][:redirect_url] = "/"
 #    end
 #    
 #    it "finds the teacher" do
 #      
 #  
 #    it "creates the assignment" do
 #      expect { xhr :post, :create, @parms }
 #      .to change{ Assignment.count }.by(1)
 #    end
 #    it "creates the section_assignments" do
 #      expect { xhr :post, :create, @parms }
 #      .to change{ SectionAssignment.count }.by(2)
 #    end
 #  end
      
end
