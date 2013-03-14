require 'spec_helper'

describe 'sections/_assignment_row' do
  before do
		@asst = mock('assignment') do
			stubs(:content).returns "This is the content"
		end
		@sa = mock('section_assignment') do
			stubs(:name).returns '21'
			stubs(:due_date).returns Date.new(2012, 7, 20)
			stubs(:assignment).returns @asst
		end
  end
  
  shared_examples_for 'any assignment row' do
    it "display the name, due date, and content of an assignment" do
      view.stubs(:editable?).returns false
  		render partial: 'sections/assignment_row', locals: {sa: @sa}
			expect(rendered).to have_selector('td', text: @sa.name) 
			expect(rendered).to have_selector('td', text: @sa.due_date)
			expect(rendered).to have_selector('td', text: @asst.txt)
    end
    
    context 'guest mode' do
      it_behave_like 'any assignment row'
    end
    
    context 'user mode' do
      it "also renders whether the assignment is assigned to the section and actions" do
        view.stubs(:editable?).returns true
        @asst.stubs(:assigned).return true
    		render partial: 'sections/assignment_row', locals: {sa: @sa}
        pending "unfinished test"
      end
    end
        
      
	end
end
