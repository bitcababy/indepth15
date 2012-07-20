require 'spec_helper'

describe TextDocument do
	subject { Fabricate :text_document, content: "foo"  }
	specify { subject.content.should == "foo" }
	
		
end
