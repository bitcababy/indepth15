# encoding: UTF-8

require 'spec_helper'

describe ApplicationHelper do
	include CourseExampleHelpers

	describe '#academic_year_string' do
		it "returns a string for the full academic year" do
			academic_year_string(2012).should == "2011—2012"
		end
	end
	
	describe '#assignment_date_string' do
		it "returns the dotw, followed by the month and day" do
			assignment_date_string(Date.new(2012, 7, 12)).should == "Thu, Jul 12"
		end
	end

end

	