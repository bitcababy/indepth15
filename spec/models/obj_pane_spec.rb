require 'spec_helper'

class Obj
  attr_accessor :content
end

describe ObjPane do
  it "uses an object to get its content" do
    obj = Obj.new
    obj.content = "Foo"
    op = ObjPane.new(obj)
    op.content.should == obj.content
   end
   it "uses an object to set its content" do
     obj = Obj.new
     obj.content = "Foo"
     op = ObjPane.new(obj)
     op.content = "Bar"
     obj.content.should == "Bar"
  end
 
end
