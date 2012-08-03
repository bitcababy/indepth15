require 'spec_helper'

describe 'courses/_sections_table' do
	it "creates a table of a courses sections" do
		course = Fabricate(:course)
		4.times { Fabricate(:section, course: course) }
		assign(:course, course)
		render partial: 'courses/sections_table'
		rendered.should have_selector('table#sections_table thead tr') do |row|
			%W(block days teacher room).each do |hdr|
				row.should have_selector('th', class: hdr)
			end
		end
	end
		
end


	