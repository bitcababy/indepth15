require 'spec_helper'

describe Occurrence do
	describe 'self.import_from_hash' do
		it "creates a new occurrence from a hash" do
			o = Occurrence.import_from_hash({block: "B", number: 1, day: 2, period: 3})
			o.should be_kind_of Occurrence
		end
	end
	
end
