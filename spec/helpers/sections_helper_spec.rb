# encoding: UTF-8

require 'spec_helper'

describe SectionsHelper do
	
	describe '#occurrence_options' do
		it "should return all occurrences paired with true" do
			occurrence_options.should == [[true, '1'], [true, '2'], [true, '3'], [true, '4'], [true, '5']]
		end
	end

# 	describe '#assignments_header' do
# 		it "shows the teacher's name, the academic year, and the block" do
# 			teacher = Fabricate :teacher, honorific: "Mr.", last_name: "Smith"
# 			section = Fabricate :section, teacher: teacher, block: "B"
# 			assignments_header(section).should == "Mr. Smith's 2011–2012 Assignments for Block B"
# 		end
# 	end
end
