require 'spec_helper'

describe DepartmentController do
  describe 'GET :home_page' do
    it "sets up a bunch of objects to be displayed" do
      docs = []
      5.times do 
        docs << mock('doc') do
          stubs(:content).returns "Some content"
        end
      end
      dept = mock('dept') do
        stubs(:how_doc).returns docs[0]
        stubs(:why_doc).returns docs[1]
        stubs(:resources_doc).returns docs[2]
        stubs(:news_doc).returns docs[3]
        stubs(:puzzle_doc).returns docs[4]
      end
      Department.stubs(:first).returns dept
      get :home_page
      assigns(:panes).should == docs
    end
  end  
	
end
