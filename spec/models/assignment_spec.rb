# encoding: UTF-8

require 'spec_helper'

describe Assignment do
	it { should validate_uniqueness_of :assgt_id }

	context "Fabricator" do
		subject { Fabricate(:assignment) }
		specify { subject.content.should_not be_nil }
	end

	context "converting" do
		describe 'Assignment.import_from_hash' do
			before :each do
				@teacher = Fabricate(:teacher, login: 'abramsj')
				@hash = {content: "This is some content", teacher_id: 'abramsj'}
			end
			
			it "returns an assignment" do
				Assignment.import_from_hash(@hash).should be_kind_of Assignment
			end
	
			it "has an author" do
				asst = Assignment.import_from_hash(@hash)
				asst.owner.should == @teacher
			end
			it "creates a new assignment if the assgt_id is new" do
				expect {
					Assignment.import_from_hash @hash
				}.to change(Assignment, :count).by(1)
			end
			it "updates an assignment if the assgt_id is old" do
				Assignment.import_from_hash @hash
				expect {
					Assignment.import_from_hash @hash
				}.to change(Assignment, :count).by(0)
			end

		end
	end

end
