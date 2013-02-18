# encoding: UTF-8

require 'spec_helper'

describe Assignment do
  it { should have_many :section_assignments }
  it { should belong_to :teacher }
  specify { subject.minor_topics.should be_kind_of SortedSet }

	context "Fabricator" do
		subject { Fabricate(:assignment) }
		specify { subject.content.should_not be_nil }
	end

end
