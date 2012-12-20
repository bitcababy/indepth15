require 'spec_helper'

describe 'text_documents/edit' do
  it "creates a form for editing text documents" do
    d = Fabricate :text_document, title: "A title", content: "Some content"
    assign(:text_document, d)
    render
    rendered.should have_selector('form') do |form|
      rendered.should have_selector('fieldset') do |fs|
        fs.should have_selector('label', content: 'Title')
        fs.should have_selector('input', type: 'text', name: 'text_document[title]')
        fs.should have_selector('textarea', name: 'text_document[content]', content: d.content)
      end
      rendered.should have_selector('.buttons') do |bs|
        bs.should have_selector('button') {|b| b.should have_selector('input', type: 'submit', value: 'Save')}
        bs.should have_selector('button#cancel', content: 'Cancel')
      end
    end
  end
end
