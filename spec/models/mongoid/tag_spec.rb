require 'spec_helper'

describe Mongoid::Tag do
  before(:each) do
    @tag = Mongoid::Tag.new
  end

  context 'scopes' do
    before(:each) do
      @tag.name = "awesome"
      @tag.save
    end

    it "should be findable by name" do
      Mongoid::Tag.named('awesome').count.should == 1
    end
    
    it "should not find one that doesn't exist'" do
      Mongoid::Tag.named('foo').count.should == 0
    end

    it "should be findable using any case" do
      Mongoid::Tag.named('AwEsome').count.should == 1
    end
      
    it "should be findable in a list" do
      Mongoid::Tag.named_any(['foo', 'aWesome']).count.should == 1
      Mongoid::Tag.named_any(['foo', 'bar']).count.should == 0
    end
      
    it "should match substrings" do
      Mongoid::Tag.named_like('we').count.should == 1
      Mongoid::Tag.named_like('WeS').count.should == 1
      Mongoid::Tag.named_like('foo').count.should == 0
    end
      
    it "should match substrings in lists" do
      Mongoid::Tag.named_like_any(['foo', 'we']).count.should == 1
    end
        
  end

  describe "find or create by name" do
    before(:each) do
      @tag.name = "awesome"
      @tag.save
    end
    
    it "should find by name" do
      Mongoid::Tag.find_or_create_with_like_by_name("awesome").should == @tag
    end
    
    it "should find by case-insensitive name" do
      Mongoid::Tag.find_or_create_with_like_by_name("aWeSome").should == @tag
    end

    it "should create by name" do
      lambda {
        Mongoid::Tag.find_or_create_with_like_by_name("epic")
      }.should change(Mongoid::Tag, :count).by(1)
    end

  end

  describe "find or create all by any name" do
    before(:each) do
      @tag.name = "awesome"
      @tag.save
    end
    
    it "should find by name" do
      Mongoid::Tag.find_or_create_all_with_like_by_name("awesome").to_a.should == [@tag]
    end

    it "should find by name case insensitive" do
      Mongoid::Tag.find_or_create_all_with_like_by_name("AWESOME").should == [@tag]
    end

    it "should create by name" do
      lambda {
        Mongoid::Tag.find_or_create_all_with_like_by_name("epic")
      }.should change(Mongoid::Tag, :count).by(1)
    end
  
    it "should find or create by name" do
      lambda {
        Mongoid::Tag.find_or_create_all_with_like_by_name("awesome", "epic").map(&:name).should == ["awesome", "epic"]
      }.should change(Mongoid::Tag, :count).by(1)
    end

    it "should return an empty array if no tags are specified" do
      Mongoid::Tag.find_or_create_all_with_like_by_name([]).should == []
    end
  end
  
  it "should require a name" do
    @tag.valid?

    @tag.errors[:name].should == ["can't be blank"]

    @tag.name = "something"
    @tag.valid?

    @tag.errors[:name].should == []
  end

  it "should equal a tag with the same name" do
    @tag.name = "awesome"
    new_tag = Mongoid::Tag.new(name: "awesome")
    new_tag.should == @tag
  end

  it "should return its name when to_s is called" do
    @tag.name = "cool"
    @tag.to_s.should == "cool"
  end

  describe "escape wildcard symbols in like requests" do
    before(:each) do
      @tag.name = "cool"
      @tag.save
      @another_tag = Mongoid::Tag.create!(:name => "coo*")
      @another_tag2 = Mongoid::Tag.create!(:name => "coolish")
    end

    it "return escaped result when Regexp chars present in tag" do
        Mongoid::Tag.named_like('coo*').should_not include(@tag)
        Mongoid::Tag.named_like('coo*').should include(@another_tag)
    end

  end

end
