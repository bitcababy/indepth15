require 'spec_helper'

describe BridgeController do
	describe "fix_hash" do
		it "changes all the keys to symbols" do
			subject.fix_hash({"a" => 1, "b" => 3, "c" => 2}).should == {a: 1, b: 3, c: 2}
		end
	end
end

