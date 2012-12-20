require 'spec_helper'

describe 'shared/_pane' do
  before :each do
    @doc = mock('src') do
      stubs(:title).returns "This is a title"
      stubs(:div_id).returns 'demo'
      stubs(:content).returns "This is some content"
      stubs(:to_param).returns "1"
    end
  end

  it "displays a title" do
    render partial: 'shared/pane', locals: {doc: @doc}
    rendered.should have_selector('h3') do |hdr|
      hdr.should have_selector('a', href: '#', content: @doc.title)
    end
  end

  it "should contain a div with the right name which displays the content of the doc" do
    render partial: 'shared/pane', locals: {doc: @doc}
    rendered.should have_content(@doc.content)
  end
  
  it "should have an edit button if the pane is editable" do
    assign(:editable, true)
    render partial: 'shared/pane', locals: {doc: @doc}
    rendered.should have_selector('button a', href: edit_text_document_path(@doc))
  end
   
end
