require 'spec_helper'

describe AssignmentsController do
  include DeviseHelpers
  login_user
  
  describe "GET 'new'" do
    before :each do
      teacher = Fabricate :teacher, login: "xyzzy"
      @course = Fabricate :course
      @course.major_topics = [
        Fabricate(:none_topic),
        Fabricate(:major_topic, name: "Quadratics"), 
        Fabricate(:major_topic, name: "Functions"), 
        Fabricate(:major_topic, name: 'Exponents/Logs'),
        Fabricate(:major_topic, name: 'Systems of Equations'), 
      ]
      @cs = (0..2).collect {|i| 
        Fabricate :section, teacher: teacher, course: @course, academic_year: Settings.academic_year, block: ('A'..'H').to_a[i]
      }
      @os = (0..1).collect {|i| 
        Fabricate :section, teacher: teacher, course: @course, academic_year: Settings.academic_year-1, block: ('A'..'H').to_a[i]
      3.times {
        @course.sections << Fabricate(:section, teacher: teacher, year: Settings.year)
      }
      
      get :new, teacher_id: teacher.to_param, course_id: @course.to_param
      response.should be_success
    end

    it "should build an assignment and section assignments for each current section" do
      assigns[:assignment].should be_kind_of Assignment
      pending "unfinished test"
    end
    
    it "should not create section assignments for old sections"
    
    # it "should assign all of topic names to @major_topics" do
    #   assigns[:major_topics].should be_kind_of Array
    #   names = MajorTopic.names_for_topics(assigns[:major_topics])
    #   assigns[:major_topics].should == names
    # end
    
    it "should render the 'new' template" do
      response.should render_template :new
    end
      
  end
  
  # {"utf8"=>"✓",
  #  "authenticity_token"=>"DhPaLUa1M8OtPHUYOS3IZ4J0KgXw/WTB+SfDZAxqyus=",
  #  "assignment"=>{
  #    "teacher_id"=>"davidsonl",
  #    "section_assignments_attributes"=>{
  #      "0"=>{"due_date"=>"2013-02-14", "assigned"=>"1", "section"=>"2013/321/davidsonl/B"},
  #      "1"=>{"due_date"=>"2013-02-14", "assigned"=>"1", "section"=>"2013/321/davidsonl/D"}},
  #      "major_topics"=>["", "Similarity", "Measurement"],
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
          "0"=>{"due_date"=>"2013-02-12", "assigned"=>"1", "block"=>"B", "section"=>s1.to_param},
          "1"=>{"due_date"=>"2013-02-12", "assigned"=>"1", "block"=>"D", "section"=>s2.to_param}
          },
          "content"=>"Some content",
          "name" => "foo",
         }
       }
    end

    it "creates the assignment" do
      expect { put :create, @parms }
      .to change{ Assignment.count }.by(1)
    end
    it "creates the section_assignments" do
      expect { put :create, @parms }
      .to change{ SectionAssignment.count }.by(2)
    end
  end

  describe "PUT create, xhr" do
    before :each do
      teacher = Fabricate :teacher
      s1 = Fabricate :section
      s2 = Fabricate :section
      @parms = {
        assignment: {
          "teacher_id" => teacher.to_param,
          "section_assignments_attributes"=>{
          "0"=>{"due_date"=>"2013-02-12", "assigned"=>"1", "block"=>"B", "section"=>s1.to_param},
          "1"=>{"due_date"=>"2013-02-12", "assigned"=>"1", "block"=>"D", "section"=>s2.to_param}
          },
          "content"=>"Some content",
          "name" => "foo",
         }
       }
       session[:form] = {}
       session[:form][:redirect_url] = "/"
    end

    it "creates the assignment" do
      expect { xhr :put, :create, @parms }
      .to change{ Assignment.count }.by(1)
    end
    it "creates the section_assignments" do
      expect { xhr :put, :create, @parms }
      .to change{ SectionAssignment.count }.by(2)
    end
  end
      
end
