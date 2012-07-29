# encoding: UTF-8

require 'spec_helper'

describe "courses/sections_pane" do
	before :each do
		@course = Fabricate(:course, full_name: "Fractals", number: 321, duration: :full_year, credits: 5.0)
		@course.description = "<p>This is some info</p>"
		4.times { Fabricate(:section, course: @course) }
		assign(:course, @course)
		render
	end
	
	it "lists some basic info" do
		rendered.should have_selector('div#sections_pane') do |div|
			div.should have_selector('div#info', content: 'Course 321 — Full Year — 5.0 Credits')
		end
	end
	
	it "display the description" do
		rendered.should have_selector('div#description') do |div|
			div.should have_selector('p', content: 'This is some info')
		end
	end
	
	it "displays a leadin to the section table" do
		rendered.should have_selector('div#leadin', content: "In the 2011—2012 academic year there are 4 sections of Fractals.")
	end
end
