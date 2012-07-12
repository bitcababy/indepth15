require 'spec_helper'

describe MenubarCell do
	include CourseHelper

  context "cell rendering" do 
	
		# context "rendering display_home" do
		#       subject { render_cell(:menubar, :display_home) }
		# 	it { should have_selector('li', text: 'Home') }
		# 	it { should have_selector('ul li', text: 'Sign in') }
		# 	it { should have_selector('ul li', text: 'About') }
		# end

    context "rendering display_courses" do
			before :each do
				setup_courses(courses: 3, max_sections: 5, teachers: 3)
			end

      subject { render_cell(:menubar, :display_courses) }
 			it { should have_selector('li#courses', text: 'Courses') }

			it "should display each course" do
				res = render_cell :menubar, :display_courses
				res.find('li#courses') do |menubar|
					for course in Course.in_catalog do
						teachers = course.teachers
						menubar.should have_selector('li', text: course.full_name) do |li|
							li.should have_selector('ul.sections') do |ul|
								for teacher in teachers do
									ul.should have_selector('li', text: teacher.full_Name)
								end
							end
						end
					end
				end
			end
    end
    
    context "rendering display_faculty" do
			before :each do
				4.times { Fabricate(:teacher) }
			end

      subject { render_cell(:menubar, :display_faculty) }
 			it { should have_selector('li', text: 'Faculty') }

			it "should list each teacher, sorted by last name" do
				teachers = Teacher.current.order_by_name
	    	res = render_cell(:menubar, :display_faculty)

				menu = res.find('ul#faculty')
				menu.should_not be_nil
				for teacher in teachers do
					menu.should have_selector('li', text: teacher.formal_name)
				end
			end
    end

    context "rendering display_admin" do
      subject { render_cell(:menubar, :display_admin) }
  
    end

    context "rendering display" do
      subject { render_cell(:menubar, :display) }
  		it { should have_selector('ul#menubar') }
  		it { should have_selector('li', text: 'Home') }
  		it { should have_selector('li', text: 'Courses') }
  		it { should have_selector('li', text: 'Faculty') }
    end
    
  end


  context "cell instance" do 
    subject { cell(:menubar) } 

		it { should respond_to :current_user }

		it { should respond_to :user_signed_in? }
    
    it { should respond_to(:display) }
    
    it { should respond_to(:display_home) }
    
    it { should respond_to(:display_courses) }
    
    it { should respond_to(:display_faculty) }
    
    it { should respond_to(:display_admin) }
    
  end
end
