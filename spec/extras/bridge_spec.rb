require 'spec_helper'

describe Bridge do

	describe 'Bridge.create_assignment' do
		it "creates an assignment from a hash and returns true" do
			Bridge.create_assignment('assgt_id' => 123, 'content' => "Foo bar").should be_true
		end
		
		it "returns false if the creation fails" do
			Bridge.create_assignment('assgt_id' => 123, 'content' => "Foo bar")
			Bridge.create_assignment('assgt_id' => 123, 'content' => "Foo bar").should be_false
		end		
	end
	
	describe "Bridge.update_assignment" do
		it "returns false if the assignment doesn't exist" do
			Bridge.update_assignment('assgt_id' => 123, 'content' => "Foo bar").should be_false
		end
		
		it "returns true if the assignment is updated" do
			Bridge.create_assignment('assgt_id' => 123, 'content' => "Foo bar")
			Bridge.update_assignment('assgt_id' => 123, 'content' => "quux").should be_true
		end
	end
			
	describe "Bridge.create_sa"
		
	
end

