require 'spec_helper'

class Foo
  include Mongoid::Document
  include Mongoid::TaggableOn
  
  taggable_on(true, :minor)
end

class Bar
  include Mongoid::Document
  include Mongoid::TaggableOn
  
  taggable_on(true, :minor)
  taggable_on(true, :major)
end

describe 'Taggable class' do
  it "should define .taggable?" do
    Foo.should respond_to(:taggable?)
  end
  
  it "should be taggable if 'taggable_on' is used" do
    Foo.taggable?.should be_true
  end
  
  it "should have a :minor tag_type" do
    Foo.tag_types.should == [:minor]
  end
  
  it "should be able to add another tag_type" do
    Foo.taggable_on(true, :major)
    Bar.tag_types.should == [:minor, :major]
  end
end


describe 'Taggable instance' do
  before :each do
    @taggable = Foo.new(:name => "Bob Jones")
  end
  
  it "should have many taggings" do
    @taggable.should have_many(:taggings)
  end
  
  it "should be taggable" do
    @taggable.taggable?.should be_true
  end
  
end

