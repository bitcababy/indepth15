require 'spec_helper'

describe DepartmentDocument do
  subject { Fabricate :department_document }
  it { should be_embedded_in :department }
  it { should validate_presence_of :title }
  
  describe "update_from_params" do
    before :each do
      @dept = Fabricate :department_with_docs
    end

    it "updates its atributes and saves its department" do
      doc = @dept.homepage_docs.first
      hash = {title: "New title", content: "Some new content" }
      doc.department.should_receive :save
      doc.update_from_params(hash)
      doc = @dept.homepage_docs.first
      expect(doc.title).to eq hash[:title]
      expect(doc.content).to eq hash[:content]
    end
  end
      
end
