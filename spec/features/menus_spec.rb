require 'spec_helper'

feature "User clicks on" do
  before do
    @dept = World.create_world
    visit home_path
  end

  scenario "Courses menu", :js do
    within '#menubar' do
      expect(page).to have_link 'Courses'
      click_link 'Courses'
      Course.each do |course|
        expect(page).to have_link course.menu_label
        clink = page.find_link course.menu_label
        course.sections.each do |section|
          expect(clink).to have_link section.menu_label
        end
      end
    end
  end

end

