require 'spec_helper'

describe Document do
	it { should belong_to(:owner) }
end
