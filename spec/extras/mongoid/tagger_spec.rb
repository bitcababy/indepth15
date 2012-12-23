require 'spec_helper'

class Foo
  include Mongoid::Document
  include Mongoid::Tagger
end

describe 'Mongoid::Tagger' do
  before :each do
    @user = TaggableUser.create
    @taggable = TaggableModel.new(:name => "Bob Jones")
  end
  
  
end
