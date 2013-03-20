require 'spec_helper'

feature "To create an assignment" do
  include Warden::Test::Helpers
  
  background do
    dept = Fabricate :department
    course = Fabricate :course, department: dept
    teacher = Fabricate :teacher, login: 'davidsonl', courses: [course]
    s1 = Fabricate :section, course: course, teacher: teacher, block: "B"
    s2 = Fabricate :section, course: course, teacher: teacher, block: "D"
    login_as teacher
    visit new_assignment_path(course, teacher)
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
   
end
