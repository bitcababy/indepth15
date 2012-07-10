require 'spec_helper'

class Foo
  include Mongoid::Document
	include Export
	field :a, type: String, default: "Lorum ipsum"
	field :n, type: Integer, default: lambda { rand(1..5) }
end

describe Export do

	# describe "export_to_seed" do
	# 	it "writes out the Ruby code to create the object"
	# 	it "iterates through each object of a class, writing each out to the file"
	# end
	# 
	# describe "export_one_to_seed" do
	# 	it "outputs the text for Ruby creation of itself" do
	# 		obj = Foo.create! a: "bar", n: 6
	# 		puts Foo.export_one_to_seed(obj)
	# 	end
	# end

end
