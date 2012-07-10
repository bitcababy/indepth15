require 'spec_helper'

describe Document do
	it { should have_and_belong_to_many :tags}
end
