require 'spec_helper'

class Foo
	include Mongoid::Document
  field :label, type: String

	def menu_label
		self.label
	end
end

describe MenuItem do
	it { should embed_many(:child_menu_items) }
	it { should be_embedded_in(:parent_menu_item) }
	it { should belong_to :object }
	it { should respond_to :url_for }
end

describe MenuItem, "with a label" do
	subject {Fabricate :menu_item, label: "Foo"}
	specify { subject.label.should_not be_nil }

	describe "menu_label" do
		it "returns its label" do
			subject.menu_label.should == "Foo"
		end
	end

end

describe MenuItem, "with an object and no label" do
	describe "menu_label" do
		it "asks its object for a label" do
			item = Fabricate :menu_item, label: nil
			obj = Foo.create! label: "Foobar"
			obj.menu_label.should == "Foobar"
			item.object = obj
			item.menu_label.should == "Foobar"
		end
	end

end

# describe MenuItem, "with a link" do
# 	describe "menu_link" do
# 		it "should return the link" do
# 			item = Fabricate :menu_item, link: "http://api.rubyonrails.org/"
# 			item.menu_link.should == "http://api.rubyonrails.org/"
# 		end
# 	end
# end
# 
# describe MenuItem, "with an object" do
# 	describe "menu_link" do
# 		item = Fabricate :menu_item, object: (Fabricate :course)
# 		puts item.object.attributes
# 		pending "Unfinished test"
# 		puts item.menu_link
# 		pending "Unfinished test"
# 		item.menu_link.should == "course"
# 	end
# end
# 		
		
