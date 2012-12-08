require 'spec_helper'

describe 'shared/_accordion_pane' do
  before :each do
    doc = mock('doc') do
      stubs(:content).returns "This is a short document"
    end
    @pane = mock('pane') do
      stubs(:div_id).returns 'demo'
      stubs(:title).returns "This is a title"
      stubs(:text_document).returns doc
      stubs(:content).returns doc.content
    end
    render partial: 'shared/accordion_pane', as: :ap, locals: {ap: @pane}
  end

  it "displays a title" do
    rendered.should have_selector('h3') do |hdr|
      hdr.should have_selector('a', href: '#', content: @pane.title)
    end
  end
  
  it "should contain a div with the right name which displays the content of the doc" do
    rendered.should have_selector("##{@pane.div_id}") do |div|
      div.should have_content(@pane.content)
    end
  end
  
end
