require 'spec_helper'

describe Occurrence do
	it { should validate_presence_of :block }
	it { should validate_presence_of :number }

	describe 'to_s' do
		it "returns the block followed by the number" do
			o = Fabricate :occurrence, block: "B", number: 1
			expect(o.to_s).to eql("B1")
		end
	end
	
end
