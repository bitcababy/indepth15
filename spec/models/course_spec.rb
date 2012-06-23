require 'spec_helper'

describe Course do
	context "validation" do
		it { should validate_uniqueness_of :number }
	end
	
	
	context "associations" do
		it { should have(0).sections }
	end	

end
