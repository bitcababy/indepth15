require 'spec_helper'

feature "To create an assignment" do
  include Warden::Test::Helpers
  
  background do
    dept = Fabricate :department
    course = Fabricate :course
    teacher = Fabricate :teacher, login: 'davidsonl'
    s1 = Fabricate :section, course: course, teacher: teacher, block: "B"
    s2 = Fabricate :section, course: course, teacher: teacher, block: "D"
    login_as teacher
    visit new_course_teacher_assignment_path(course, teacher)
   end
   
   scenario "fill in the form and click Create" do
     expect(Assignment.count).to eq 0
     expect(SectionAssignment.count).to eq 0
     page.fill_in 'Name', with: "21"
     expect(page).to have_selector('#save')
     btn = page.find('#save')
     btn.click
     expect(SectionAssignment.count).to eq 2
     expect(Assignment.count).to eq 1
   end
   
  #  
  #  context "the initial state" do
  #    context " of the section assignemnts" do
  #      scenario "initial state", :js do
  #        div = page.find('#sas')
  #     
  #        use_fields = div.all('td.assigned div label input')
  #        expect(use_fields.count).to eq 2
  #        use_fields.each do |uf|
  #          expect(uf.value).to eq "1"
  #        end
  #        
  #        due_dates = div.all('.due_date-alt')
  #        expect(due_dates.count).to eq 2
  #        initial_date = Utils.next_school_day
  #        due_dates.each {|dd| expect(Date.parse(dd.value)).to eq initial_date}
  #      end
  #    end
  #  end
end
