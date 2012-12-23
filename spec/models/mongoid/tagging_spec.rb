require 'spec_helper'

class Foo
  include Mongoid::Document
  field :name, type: String
end

describe Mongoid::Tagging do

  before :each do
    @tagging = Mongoid::Tagging.new
  end
  
  it { should belong_to :tag }
  it { should belong_to :taggable }

  it "should not be valid with a invalid tag" do
    @tagging.taggable = Foo.create(:name => "Bob Jones")
    @tagging.tag = Mongoid::Tag.new(:name => "")
    @tagging.context = "tags"

    @tagging.should_not be_valid
    
    @tagging.errors[:tag].should == ["can't be blank"]
  end

  it "should not create duplicate taggings" do
    @taggable = Foo.create(:name => "Bob Jones")
    @tag = Mongoid::Tag.create(:name => "awesome")

    lambda {
      2.times { Mongoid::Tagging.create(:taggable => @taggable, :tag => @tag, :context => 'tags') }
    }.should change(Mongoid::Tagging, :count).by(1)
  end
  
end
