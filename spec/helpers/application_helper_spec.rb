# encoding: UTF-8

require 'spec_helper'

describe ApplicationHelper do

	describe '#academic_year_string' do
		it "returns a string for the full academic year" do
			expect(academic_year_string(2012)).to eq "2011–2012"
		end
	end
  
  describe '#is_are_number_mangler' do
    it "returns no fools if 0 is passed in" do
      expect(is_are_number_mangler(0, "fool")).to eq "are no fools"
    end
    it "returns 1 fool if 1 is passed in" do
      expect(is_are_number_mangler(1, "fool")).to eq "is 1 fool"
    end
    it "returns 2 fools if 2 is passed in" do
      expect(is_are_number_mangler(2, "fool")).to eq "are 2 fools"
    end
  end
  
	describe '#assignment_date_string' do
		it "returns the dotw, followed by the month and day" do
			expect(assignment_date_string(Date.new(2012, 7, 12))).to eq "Thu, Jul 12"
		end
	end
	
	describe '#hidden_div_if' do
		it "adds 'display: none' if the condition is true" do
			attrs = {}
			hidden_div_if(true, attrs)
			expect(attrs['style']).to eq 'display: none'
		end
		it "doesn't add 'display: none' if the condition is false" do
			attrs = {}
			hidden_div_if(false, attrs)
			expect(attrs['style']).to_not == 'display: none'
			# puts content_tag('div', attrs)
		end
	end

  describe '#section_assignments' do
    it "returns the path for a section's assignments'" do
      teacher = mock('teacher') do
        stubs(:to_param).returns 'djoe'
      end
      course = mock('course') do
        stubs(:param).returns 'fractals'
      end
      section = mock('section') do
        stubs(:teacher).returns teacher
        stubs(:course).returns course
        stubs(:year).returns 2013
        stubs(:block).returns 'B'
      end
    end
  end

end

	