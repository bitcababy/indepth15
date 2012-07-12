require 'spec_helper'
require 'import_massaged'


class Import::TestCase
	include Mongoid::Document
	include ImportMassaged
end

describe 'ImportMassaged' do

	# describe 'cleanup'
	# 
	# describe 'to_real_class' do
	# 	it "returns the base part of the module, lowercase and singularized" do
	# 		puts Import::TestCase.to_real_class
	# 	end
	# end
	# 
	# describe 'path_for_class' do
	# 	it "returns the path to the import file for the klass" do
	# 		Import::TestCase.path_for_class.should == File.join(File.join(Rails.root, 'data'), "test_cases.xml")
	# 	end
	# end
	# 
	# describe 'import_to_array' do
	# 	it "loads all objects from a matching xml file" do
	# 		res = Import::TestCase.import_to_array
	# 		res['test_case'].should_not be_nil
	# 		arr = res['test_case']
	# 		arr.should be_kind_of Array
	# 	end
	# end
	# 
	# describe 'load_from_data' do
	# 	it "creates records from an xml file" do
	# 		res = Import::TestCase.import_to_array
	# 		n = res['test_case'].count
	# 		Import::TestCase.load_from_data
	# 		Import::TestCase.count.should == n
	# 	end
	# end
			

end
