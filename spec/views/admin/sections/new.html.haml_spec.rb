require 'spec_helper'


describe "admin/sections/new" do
	before :each do
		@course = Fabricate(:course)
		@section = Fabricate.build(:section, course: @course)
		render
	end

	it "displays a number picker" do
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
