require 'spec_helper'

describe MajorTag do
  describe '#subtags' do
    it "adds one or more tags" do
      mt = Fabricate :major_tag, subtags: []
      expect {
        mt.add_subtags('foo')
      }.to change { mt.subtags.count}.by(1)
    end
  end
end
