require 'spec_helper'

feature "Creating an assignment" do
  include Warden::Test::Helpers

  before :each do
    @dept = Fabricate :department
    course = Fabricate :course
    teacher = Fabricate :teacher, login: 'davidsonl'
    s1 = Fabricate :section, course: course, teacher: teacher, block: "B", academic_year: 2013
    s2 = Fabricate :section, course: course, teacher: teacher, block: "D", academic_year: 2013
    login_as teacher
    visit new_assignment_path(course, teacher)
   end
   
   context "the initial state" do
     context " of the section assignemnts" do
       scenario "initial state", :js do
         div = page.find('#sas')
      
         use_fields = div.all('td.assigned div label input')
         use_fields.count.should eq 2
         use_fields.each do |uf|
           uf.value.should == "1"
         end
         
         due_dates = div.all('.due_date-alt')
         due_dates.count.should eq 2
         initial_date = Utils.next_school_day
         due_dates.each {|dd| Date.parse(dd.value).should == initial_date}
       end
     end
   end
end
