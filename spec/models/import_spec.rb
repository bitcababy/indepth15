require 'spec_helper'

class TestCase < Import
	include Mongoid::Document
	cattr_reader :mapping, :skip
	field :orig_id, type: Integer
	field :default_room, type: String
	field :old_current, type: Boolean
	# field :last_name, type: String
	# field :first_name, type: String
	# field :honorific, type: String
	# field :teacher_id, type: String
	# field :title, type: String
	# field :base_url, type: String
	# field :photo_url, type: String
	# field :personal_hp_url, type: String
	# field :generic_msg, type: String
	# field :upcoming_msg, type: String

	@@mapping = {
		"id" 					=> :orig_id,
		"last_name" 	=> :last_name,
		'first_name' 	=> :first_name,
		'teacher_id' 	=> :teacher_id,
		'title' 			=> :honorific,
		'base_URL' 	=> :base_url,
		'phrase' 			=> :phrase,
		'photo_URL' => :photo_url,
		'personal_hp_URL' => :home_page,
		'generic_assgts_msg' => :generic_msg,
		'upcoming_assgts_msg' => :upcoming_msg,
		# 'extra_stuff' => :extra_stuff,
		'current' => :old_current,
		'default_room' => :default_room,
		'updated_at' => nil
	}
	
	def self.convert_record(hash)
		self.create! hash
	end
	
end

describe Import do
	before :each do
		@data = 
				[[
					{"name"=>"id", :content=>"1"},
					{"name"=>"last_name", :content=>"Abrams"},
					{"name"=>"first_name", :content=>"Joshua"},
					{"name"=>"teacher_id", :content=>"abramsj"},
					{"name"=>"title", :content=>"Mr."},
					{"name"=>"base_URL", :content=>"NULL"},
					{"name"=>"default_room", :content=>"203"},
					{"name"=>"phrase", :content=>"temp"},
					{"name"=>"photo_URL", :content=>"http://www.westonmath.org/teachers/abramsj/math4/picture.jpg"},
					{"name"=>"personal_hp_URL", :content=>"http://www.westonmath.org/teachers/abramsj/math4/quotes.html"},
					{"name"=>"generic_assgts_msg"},
					{"name"=>"upcoming_assgts_msg"},
					{"name"=>"extra_stuff"},
					{"name"=>"logged_in", :content=>"0"},
					{"name"=>"current", :content=>"1"},
					{"name"=>"admin_level", :content=>"none"},
					{"name"=>"updated_at", :content=>"2012-05-11 15:25:06"
				}
			]]
	end

	describe '::import_file' do
		it "returns the attributes of a set of records" do
			res = TestCase.import_file('test_cases.xml')
			res.should be_kind_of Array
			puts res[0]
		end
	end

	describe '::flatten' do
		it "returns a hash for each record" do
			arr = TestCase.import_file('test_cases.xml')
			rec = arr[0]
			res = TestCase.flatten(rec)
			res.should be_kind_of Hash
			# puts res
		end
	end
	
	describe '::import_and_create' do
		it "creates records from a MySQL xml dump file" do
			TestCase.import_and_create
			TestCase.count.should > 0
			# puts TestCase.first.attributes
		end
	end

	describe "::create_imported_records" do
		it "creates a new Teacher record for each imported one" do
			arr = TestCase.import_file('test_cases.xml')
			n = arr.count
			TestCase.create_imported_records(flatten(arr))
			TestCase.count.should == n
			# puts TestCase.first.attributes
		end
	end
	
	
	
	context "records have been created" do
		before :each do
			TestCase.import_and_create
		end

		describe '#to_xml' do
			it "returns its properties in xml format" do
				puts TestCase.first.to_xml
			end
		end

		describe '#to_xml' do
			it "does returns a string of the attributes" do
				res = TestCase.first.to_xml
				res.should be_kind_of String
				puts res
			end
		end
	
		describe '::export_to_xml' do
			it 'writes all records of the class to a file' do
				TestCase.export_to_xml
				pending "Unfinished test"
			end
		end

		describe 'to_real_class' do
			it "returns the base part of the module, lowercase and singularized" do
				TestCase.to_real_class.should == TestCase
			end
		end
	
		describe 'path_for_class' do
			it "returns the path to the import file for the klass" do
				TestCase.path_for_class.should == File.join(File.join(Rails.root, 'data'), "test_cases.xml")
			end
		end

		describe 'import_to_array' do
			it "loads all objects from a matching xml file" do
				res = TestCase.import_to_array
				arr = res['test-case']
				arr.should_not be_nil
				arr.should be_kind_of Array
				puts arr[0]
			end
		end

		describe 'load_from_data' do
			it "creates records from an xml file" do
				TestCase.load_from_data
				TestCase.count.should > 0
				# res = TestCase.import_to_array
				# arr = res['test-case']
				# arr.should be_kind_of Array
				# n = arr.size
				# TestCase.count.should == n
				# puts TestCase.first.attributes
			end
		end
	end

end