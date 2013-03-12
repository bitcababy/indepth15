# encoding: UTF-8

require 'spec_helper'

describe SectionsHelper do
	helper ApplicationHelper

	describe '#page_header' do
		it "shows the teacher's name, the academic year, and the block" do
			teacher = Fabricate :teacher, honorific: "Mr.", last_name: "Smith"
			section = Fabricate :section, teacher: teacher, block: "B"
			expect(page_header(section)).to eq "Mr. Smith's #{Settings.academic_year-1}–#{Settings.academic_year} Assignments for Block B"
		end
	end
end
