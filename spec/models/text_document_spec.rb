require 'spec_helper'

describe TextDocument do
	describe "#initialize" do
		it "sets the content if any is provided" do
			t = TextDocument.new content: (txt = "I am some text")
			t.should_not be_nil
			t.content.should == txt
		end
		it "sets the content to an empty string if none is provided" do
			t = TextDocument.new
			t.content.should == ''
		end
	end
end
