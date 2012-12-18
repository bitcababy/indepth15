# encoding: UTF-8

require 'spec_helper'

describe Assignment do
	context "Fabricator" do
		subject { Fabricate(:assignment) }
		specify { subject.content.should_not be_nil }
	end

end
