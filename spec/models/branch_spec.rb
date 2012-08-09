require 'spec_helper'

describe Branch do
	it {should validate_presence_of :name}
	it {should validate_length_of :name}
	
	describe '#create_major_tags' do
		it "creates a major tag for each tag in the MAJOR_TAGS hash" do
			branch_name = Branch::MAJOR_TAGS.keys.first
			tags = Branch::MAJOR_TAGS[branch_name]
			branch = Branch.new name: branch_name
			branch.create_major_tags
			for tag in tags do
				MajorTag.where(name: tag).should exist
			end
		end
	end

end
