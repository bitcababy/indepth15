require 'spec_helper'

describe "menus/courses.html.haml" do
  before do
    @dept = World.create_world
  end
  it "renders a courses menu", :js do
    get "/"
    expect(page).to have_link 'Courses'
    Course.each do |course|
      expect(page).to have_link course.menu_label
      clink = page.find_link course.menu_label
      course.sections.each do |section|
        expect(clink).to have_link section.menu_label
      end
    end
  end
end

