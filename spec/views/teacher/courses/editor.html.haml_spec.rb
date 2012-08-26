require 'spec_helper'

describe 'teacher/courses/_editor' do
	
		it "renders a form" do
			doc = Fabricate :text_document, content: "This is some content"
			assign(:document, doc)
			render partial: 'teacher/courses/editor'
			rendered.should have_selector('form') do |form|
				form.should have_selector('input', name: 'commit', type: 'submit')
				form.should have_selector('textarea', name: 'text_document[content]')
			end
		end
end

