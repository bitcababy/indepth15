require 'spec_helper'

describe Occurrence do
	
	describe 'self.import_from_hash' do
		it "creates a new occurrence from a hash" do
			o = Occurrence.import_from_hash({block_name: "B", occurrence: 1, day_number: 2, period: 3})
			o.should be_kind_of Occurrence
		end
	end
end
