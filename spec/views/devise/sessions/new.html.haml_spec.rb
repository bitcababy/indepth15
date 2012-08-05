require 'spec_helper'

describe 'devise/sessions/new' do
	it "renders a form for logging in" do
		user = User.new
		render 'devise/sessions/new', locals: {resource: user, resource_name: 'user'}
		pending "Unfinished test"
	end
end
