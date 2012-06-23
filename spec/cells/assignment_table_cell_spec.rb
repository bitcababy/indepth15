require 'spec_helper'

describe AssignmentTableCell do
  context "cell rendering" do 
    
    context "rendering display" do
      subject { render_cell(:assignment_table, :display) }
  
      it { should have_selector("h1", :content => "AssignmentTable#display") }
      it { should have_selector("p", :content => "Find me in app/cells/assignment_table/display.html") }
    end
    
  end


  context "cell instance" do 
    subject { cell(:assignment_table) } 
    
    it { should respond_to(:display) }
    
  end
end
