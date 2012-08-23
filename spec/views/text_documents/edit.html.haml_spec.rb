require 'spec_helper'

describe 'text_documents/edit' do
	it "renders a form to edit a document" do
		@document = Fabricate :text_document, content: "This is some text"
		render
	end
end