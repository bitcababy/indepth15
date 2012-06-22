require 'spec_helper'

describe TextDocument do
	it { should validate_presence_of(:contents) }
end
