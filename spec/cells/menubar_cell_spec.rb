require 'spec_helper'

describe MenubarCell do
  context "cell rendering" do 

    context "rendering display_courses" do
	    pending "Unfinished test"
      subject { render_cell(:menubar, :display_courses) }
  
      # it { should have_selector("h1", :content => "Menubar#display_courses") }
      # it { should have_selector("p", :content => "Find me in app/cells/menubar/display_courses.html") }
    end
    
    context "rendering display_faculty" do
	    pending "Unfinished test"
      subject { render_cell(:menubar, :display_faculty) }
  
      # it { should have_selector("h1", :content => "Menubar#display_faculty") }
      # it { should have_selector("p", :content => "Find me in app/cells/menubar/display_faculty.html") }
    end
    
    context "rendering display_admin" do
 	    pending "Unfinished test"
     subject { render_cell(:menubar, :display_admin) }
  
      # it { should have_selector("h1", :content => "Menubar#display_admin") }
      # it { should have_selector("p", :content => "Find me in app/cells/menubar/display_admin.html") }
    end
    
  end


  context "cell instance" do 
    subject { cell(:menubar) } 
    
    it { should respond_to(:display_courses) }
    
    it { should respond_to(:display_faculty) }
    
    it { should respond_to(:display_admin) }
    
  end
end
