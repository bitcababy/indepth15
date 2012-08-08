require 'spec_helper'

describe Occurrence do
	it { should validate_presence_of :block }
	it { should validate_presence_of :number }

	describe 'self.import_from_hash' do
		it "creates a new occurrence from a hash" do
			o = Occurrence.import_from_hash({block: "B", number: 1, day: 2, period: 3})
			o.should be_kind_of Occurrence
		end
	end
	
	describe 'to_s' do
		it "returns the block followed by the number" do
			o = Fabricate :occurrence, block: "B", number: 1
			o.to_s.should eql("B1")
		end
	end
	
end
