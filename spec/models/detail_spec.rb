require 'spec_helper'

describe Detail do
	describe "add" do
		it "adds arbitrary fields" do
			detail = Detail.new
			detail.add name: "Foo"
			detail[:name].should == "Foo"
		end
	end
end
