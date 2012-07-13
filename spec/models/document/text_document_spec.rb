require 'spec_helper'

describe Document::Text do
	subject { Fabricate :text_document, content: "foo"  }
	specify { subject.content.should == "foo" }
end
