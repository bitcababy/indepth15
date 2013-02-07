require 'spec_helper'

describe DepartmentDocument do
  subject { Fabricate :department_document }
  it { should be_embedded_in :department }
  it { should validate_presence_of :title }
  it { should validate_presence_of :content }
  
  describe "update_from_params" do
    before :each do
      @dept = Fabricate :department_with_docs
    end

    it "updates its atributes and saves its department" do
      doc = @dept.homepage_docs.first
      hash = {title: "New title", content: "Some new content" }
      doc.department.expects :save
      doc.update_from_params(hash)
      doc = @dept.homepage_docs.first
      doc.title.should eq hash[:title]
      doc.content.should eq hash[:content]
    end
  end
      
end
