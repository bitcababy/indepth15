require 'spec_helper'

describe "sections/edit.html.haml" do
	before :each do
		pending "Unfinished test"
		@course = Fabricate(:section)
		@section = Fabricate.build(:section, section: @section)
		render
	end

	it "displays a number picker" do
		pending "Unfinished test"
		# puts rendered
		# pending "Unfinished test"
		page.should have_field("section[number]")
		pending "Unfinished test"
	end
		
	it "displays a semester picker"
	it "display a block picker"
	it "display an occurrences editor"
	it "displays a room"
end
