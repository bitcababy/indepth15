require 'spec_helper'

describe 'sections/_assignment_row' do
  before do
		@asst = stub_model Assignment
		@asst.stub(:content).and_return "This is the content"
		@asst.stub(:name).and_return '21'
		@sa = stub_model SectionAssignment
		@sa.stub(:due_date).and_return Date.new(2012, 7, 20)
		@sa.stub(:assignment).and_return @asst
  end
  
  shared_examples_for 'any assignment row' do
    it "display the name, due date, and content of an assignment" do
      as_guest do
    		render partial: 'sections/assignment_row', locals: {sa: @sa}
        expect(page).to have_selector('tr')
        row = page.find('tr')
  			expect(row).to have_selector('td', text: @sa.name) 
  			expect(row).to have_selector('td', text: assignment_date_string(@sa.due_date))
  			expect(row).to have_selector('td', text: @asst.content)
      end
    end
  end
    
  context 'guest mode' do
    it_behaves_like 'any assignment row'
  end
  
  context 'user mode' do
    it_behaves_like 'any assignment row'
    
    it "adds stuff for editing" do
      view.stub(:editable?).and_return true
      render partial: 'sections/assignment_row', locals: {sa: @sa}
      row = page.find('tr')
      expect(row).to have_link 'Edit'
    end
  end
      
      
      
end

