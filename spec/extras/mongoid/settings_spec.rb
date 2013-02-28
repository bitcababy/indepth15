# require 'spec_helper'
# 
# class Foo < Mongoid::Settings
# end
# 
# describe Mongoid::Settings do
#   it { should embed_many :settings }
#   describe "::current" do
#     it "returns the current settings" do
#       expect(Foo.current).to be_kind_of Mongoid::Settings
#     end
#   end
#   
#   describe ':[]=' do
#     it "sets the value of a key" do
#       Foo[:blocks] = [1,2,3]
#       expect(Foo.current.settings[:blocks]).to eq [1,2,3]
#     end
#   end
#   
#   describe ':[]' do
#     it "returns the value of a key" do
#       Foo[:blocks] = [1,2,3]
#       Foo[:blocks].should eq [1, 2, 3]
#     end
#   end
#       
#   describe '::clear' do
#     it "clears the settings hash" do
#       Foo[:blocks] = [1,2,3]
#       Foo.clear
#       expect(Foo.current.settings).to be_empty
#     end
#   end
#   
#   describe '::clear?' do
#     before :each do
#       Foo.clear
#     end
#     it "returns false if there are settings" do
#       Foo[:blocks] = [1,2,3]
#       expect(Foo.clear?).to be_false
#     end
#     it "returns true if there are no settings" do
#       expect(Foo.clear?).to be_true
#     end
#   end
#   
#   describe '::merge' do
#     it "merges in a hash" do
#       Foo[:a] = "Hello"
#       Foo.merge(a: 1, b: 2)
#       expect(Foo[:a]).to eq 1
#     end
#   end
#   
#   describe '::delete' do
#     it "deletes the key from the settings" do
#       Foo[:a] = "Hello"
#       expect(Foo[:a]).to eq "Hello"
#       Foo.delete :a
#       expect(Foo[:a]).to be_nil
#     end
#   end
#       
#     
#       
#   
# end
