require 'spec_helper'

class Foo
	include Mongoid::Document
  
	has_and_belongs_to_many :tags, inverse_of: nil
end

describe Tag do
	describe '::add' do
		it "creates a new tag if there isn't one" do
			Tag.delete_all
			t = Tag.add "test"
			t.should_not be_nil
		end
		
		it "find a tag if there's one with the same content" do
			t1 = Tag.add "test"
			t2 = Tag.add "test"
			t1.should === t2
		end
	end
	
	describe '::tag_obj' do
		it "adds the object to its tagged list" do
			obj = Foo.create!
			tag = Tag.tag_obj("test", obj)
			tag.tagged.should contain(obj)
		end
		it "adds itself to the object's tags list" do
			obj = Foo.create!
			tag = Tag.tag_obj("test", obj)
			obj.tags.should contain(tag)
		end
			
	end
			

end
