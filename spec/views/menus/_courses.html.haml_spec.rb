require 'spec_helper'

describe 'menus/_courses' do
  before do
    stub_template 'menus/_course' => "courses menu"
  end

  it "displays 'Courses'" do
    render partial: 'menus/courses', locals: {courses: []}
    expect(page).to have_selector 'li a', text: 'Courses'
  end
end