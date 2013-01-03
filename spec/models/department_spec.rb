require 'spec_helper'

describe Department do
  subject { Fabricate :department }
  it { should have_and_belong_to_many :homepage_docs }
  specify { subject.name.should_not be_nil }
  specify { subject.name.should_not be_empty }
end
