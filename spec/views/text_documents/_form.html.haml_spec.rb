require 'spec_helper'
require 'cancel_input'

describe 'text_documents/_form' do
	it "renders a form to edit a document" do
		@document = Fabricate :text_document, content: "This is some text"
		render partial: 'text_documents/form', locals: {document: @document}
		rendered.should have_selector('form') do |form|
			form.should have_selector('div.form-inputs') do |inputs|
				inputs.should have_selector('textarea')
			end
			form.should have_selector('div.form-actions') do |inputs|
				inputs.should have_selector('input.btn', type: 'submit')
				inputs.should have_selector('input.btn', type: 'reset')
				pending "Unfinished test"
			end
		end
			
	end
end