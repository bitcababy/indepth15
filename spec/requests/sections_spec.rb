require 'spec_helper'

describe 'Sections' do
	it "shows an assignments page" do
		section = Fabricate(:section)
		get assignments_page_path(section)
		response.should render_template(:assignments)
	end
end
