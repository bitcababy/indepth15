require 'spec_helper'

describe TextDocument do
	specify { subject.contents.should_not be_nil }
end
