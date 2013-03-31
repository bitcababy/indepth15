require 'spec_helper'

describe '/users/sessions/new' do
	it "renders a sign-in form" do
    include Warden::Test::Helpers
    
    render
    pending "unfinished test"
    expect(page).to have_form('sign-in', action: '/users/create')
    form = page.find('form#sign-in')
    expect(form).to have_selector('input', name: 'user[login]')
    expect(form).to have_selector('input', name: 'user[password]')
    expect(form).to have_selector('input', name: 'user[remember_me]')
    expect(form).to have_selector('div.form-actions')
    fa = form.find('div.form-actions')
    expect(fa).to have_selector('input', name: 'commit', type: 'submit')
	end
			
end
