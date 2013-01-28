require 'spec_helper'

describe Branch do
	it {should validate_presence_of :name}
	it {should validate_length_of :name}

end
