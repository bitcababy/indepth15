require 'spec_helper'

describe Assignment do
	
	context "Fabricator" do
		subject { Fabricate(:assignment) }
		specify { subject.content.should_not be_nil }
	end

	context "converting" do
		describe 'Assignment.import_from_hash' do
			before :each do
				Fabricate(:teacher, login: 'abramsj')
				@assignment = Assignment.import_from_hash({
					name: "3", content: "This is some content", teacher_id: 'abramsj',
					})
				@assignment.should be_kind_of Assignment
			end
			
			it "has an author" do
				@assignment.owner.should_not be_nil
			end
		end
	end

end
