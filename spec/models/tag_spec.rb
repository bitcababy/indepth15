require 'spec_helper'

describe Tag do
	describe '::add' do
		it "creates a new tag if there isn't one" do
			Tag.delete_all
			t = Tag.add "test"
			t.should_not be_nil
		end
		
		it "find a tag if there's one with the same content" do
			t1 = Tag.add "test"
			t2 = Tag.add "test"
			t1.should === t2
		end
	end			

end
