require 'spec_helper'

describe 'shared/_menubar' do
	it "displays the menubar" do
		render partial: 'shared/menubar'
		view.content_for?(:menubar).should be_true
		res = view.content_for(:menubar)
		res.should have_selector('ul.accordian#menubar')
		res.should contain('Home')
		res.should contain('Courses')
		res.should contain('Teachers')
	end
end
