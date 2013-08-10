require 'spec_helper'

describe 'sections/new' do
  include CapybaraExtras
  FORM_SEL = '#section_editor form'
  before do
    @section = Fabricate.build :section
    @courses = ["321 Geometry Honors", "666 Mark of the Devil"]
    @teachers = []
    3.times {@teachers << Fabricate( :teacher)}
    assign(:section, @section)
    assign(:courses, @courses)
    view.stub(:section_path).and_return ""
    render
     expect(rendered).to have_selector(FORM_SEL)
    @form = page.find(FORM_SEL)
end

  it "shows a popup for courses" do
    expect(@form).to have_select('Course')
  end

  it "shows a popup for blocks" do
    expect(@form).to have_select('Block')
  end

  it "shows a popup for semester"do
    expect(@form).to have_select('Semester')
  end

  it "shows a text field for room"

  it "shows a popup for teachers" do
    expect(@form).to have_select('Teacher')
  end

  it "has a save button" do
    expect(@form).to have_button('Save')
  end

  it "has a cancel button" do
    expect(@form).to have_button('Cancel')
  end

end
