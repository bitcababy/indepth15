# encoding: UTF-8

require 'spec_helper'

describe SectionsHelper do
	helper ApplicationHelper

	describe '#page_header' do
		it "shows the teacher's name, the academic year, and the block" do
			teacher = Fabricate :teacher, honorific: "Mr.", last_name: "Smith"
			section = Fabricate :section, teacher: teacher, block: "B"
			page_header(section).should == "Mr. Smith's 2011—2012 Assignments for Block B"
		end
	end
end
