require 'spec_helper'

describe Section do
	it { should belong_to :teacher }
	it { should validate_uniqueness_of(:number).scoped_to(:course) }
	
end
