require 'spec_helper'

describe Tag::Text do
	describe '.add' do
		it "creates a new tag if there isn't one" do
			t = Tag::Text.add "test"
			t.should_not be_nil
		end
		
		it "find a tag if there's one with the same content" do
			t1 = Tag::Text.add "test"
			t2 = Tag::Text.add "test"
			t1.should === t2
		end
	end

end
