require 'spec_helper'

class TestDocument < Document
  field :content, type: String, default: ""
  track_history on: :content, track_create: true
end

describe Document do
  describe 'lock checking' do
    it "starts out with a version of 1" do
      doc = TestDocument.create
      doc.version.should == 1
    end
    
    it "bumps the version when it's updated" do
      doc = TestDocument.create
      doc.update_attributes content: "Foo"
      doc.version.should == 2
    end
    
    it "raises an StaleDocument exception if someone else has updated it" do
      doc = TestDocument.create
      d1 = TestDocument.first
      d1.update_attributes content: "Foo"
      expect {doc.update_attributes(content: "Bar")}.to raise_error(StaleDocument)
    end
  end    
end
