require 'spec_helper'

describe Course do
	it { should validate_uniqueness_of :number }
	it { should have(0).sections }
end
