require 'spec_helper'

class Import::TestCase
	include Mongoid::Document
	include InitialImport
	field :un, as: :unique_name, type: String
	field :cu, as: :current, type: Boolean
	field :ga, as: :generic_msg, type: String
	field :ga, as: :current_msg, type: String
	field :dr, as: :default_room, type: String
	field :hp, as: :home_page, type: String
	field :pw, as: :password, type: String
	
	MAP = {}
end

describe InitialImport do
	before :each do
		@data = 
				[
					{"name"=>"id", :content=>["1"]},
					{"name"=>"last_name", :content=>["Abrams"]},
					{"name"=>"first_name", :content=>["Joshua"]},
					{"name"=>"teacher_id", :content=>["abramsj"]},
					{"name"=>"title", :content=>["Mr."]},
					{"name"=>"base_URL", :content=>["NULL"]},
					{"name"=>"default_room", :content=>["203"]},
					{"name"=>"phrase", :content=>["temp"]},
					{"name"=>"photo_URL", :content=>["http://www.westonmath.org/teachers/abramsj/math4/picture.jpg"]},
					{"name"=>"personal_hp_URL", :content=>["http://www.westonmath.org/teachers/abramsj/math4/quotes.html"]},
					{"name"=>"generic_assgts_msg"},
					{"name"=>"upcoming_assgts_msg"},
					{"name"=>"extra_stuff"},
					{"name"=>"logged_in", :content=>["0"]},
					{"name"=>"current", :content=>["1"]},
					{"name"=>"admin_level", :content=>["none"]},
					{"name"=>"updated_at", :content=>["2012-05-11 15:25:06"]
				}
			]
	end
	
	describe "methods" do
		it "should contain some methods" do
			Import::TestCase.public_method_defined?(:import_file).should be_true
			Import::TestCase.should respond_to :import_file
		end
	end

	describe '::import_file' do
		it "returns the attributes of a set of records" do
			res = Import::TestCase.import_file('teachers.xml')
			res.should be_kind_of Array
		end
	end
	
	describe '::flatten' do
		it "returns a hash for each record" do
			Import::TestCase.flatten([@data]).should be_kind_of Array
			Import::TestCase.flatten([@data])[0].should be_kind_of Hash
		end
	end
	
	describe '::import_and_create' do
		it "creates records from a MySQL xml dump file" do
			Import::TestCase.import_and_create
			Import::TestCase.count.should > 0
		end
	end
			
	
end