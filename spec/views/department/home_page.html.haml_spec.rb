require 'spec_helper'

describe "department/home_page.html.haml" do
  before :each do
    @panes = []
    @panes <<  mock('doc') do
      stubs(:title).returns "How to Use the New Westonmath App"
      stubs(:content).returns "how document"
      stubs(:div_id).returns 'how'
    end
    @panes <<  mock('doc') do
      stubs(:title).returns "Why not teacherweb?"
      stubs(:content).returns "Why document"
      stubs(:div_id).returns 'why'
    end
    assign(:panes, @panes)
    render
  end
      
  it "has a div named 'home-page'" do
    rendered.should have_selector('#home-page')
  end
  it "renders a number of panes within #home-page" do
    rendered.should have_selector('#home-page') do |div|
      for pane in @panes do
        div.should have_selector('h3', name: pane.div_id) do |div1|
          div1.should have_selector('a', content: pane.title)
        end
        div.should have_selector("##{pane.div_id}", class: 'pane-content', content: pane.content)
      end
    end
  end

end
