require 'spec_helper'

describe 'shared/_pane' do
  before :each do
    @src = mock('src') do
      stubs(:title).returns "This is a title"
      stubs(:div_id).returns 'demo'
      stubs(:content).returns "This is some content"
    end
    render partial: 'shared/pane', locals: {src_obj: @src}
  end

  it "displays a title" do
    rendered.should have_selector('h3') do |hdr|
      hdr.should have_selector('a', href: '#', content: @src.title)
    end
  end

  it "should contain a div with the right name which displays the content of the doc" do
    rendered.should have_selector("##{@src.div_id}") do |div|
      div.should have_content(@src.content)
    end
  end
  
end
