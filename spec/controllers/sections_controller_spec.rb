require 'spec_helper'

def setup_section
	@the_teacher = Fabricate(:teacher)
	@the_course = Fabricate(:course)
	@the_section = Fabricate :section, course: @the_course, teacher: @the_teacher

  3.times { @the_section.add_assignment(Utils.future_due_date + rand(1..5), Fabricate(:assignment)) }
  2.times { @the_section.add_assignment(Utils.future_due_date - rand(1..5), Fabricate(:assignment)) }
end

describe SectionsController do

  describe "GET 'assignments'" do
		before do
			pending "Unfinished test"
			setup_section
      get :assignments, :id => @the_section.id
			@the_section.section_assignments.future.asc(:due_date).count.should == 3
		end

    it "returns http success" do
      response.should be_success
    end

		it "assigns @current_assignment" do
			assigns(:current_assignment).should_not be_nil
		end

		it "assigns @upcoming_assignments" do
			assigns(:upcoming_assignments).should_not be_nil
		end

		it "assigns @past_assignments" do
			assigns(:past_assignments).should_not be_nil
		end

  end

end
