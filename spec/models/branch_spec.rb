require 'spec_helper'

describe Branch do
	
	describe '#create_major_tags' do
		it "creates a major tag for each tag in the MAJOR_TAGS hash" do
			branch_name = Branch::MAJOR_TAGS.keys.first
			tags = Branch::MAJOR_TAGS[branch_name]
			branch = Branch.create! name: branch_name
			branch.create_major_tags
			for tag in tags do
				MajorTag.where(content: tag).should exist
			end
		end
	end

  describe '::create_all' do
		it 'creates a branch for each key in the MAJOR_TAGS hash' do
			Branch.create_all
			Branch::MAJOR_TAGS.keys.each do |txt|
				Branch.where(name: txt).should exist
			end
		end
	end
end
