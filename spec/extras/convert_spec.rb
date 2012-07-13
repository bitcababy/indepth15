require 'spec_helper'

describe Convert do
	describe 'import_old_file' do
		it "imports a file using XmlSimple and returns an array of name, content hashes" do
			res = Convert.import_old_file('teachers.xml')
			res.should be_kind_of Array
		end
	end
	
	context 'flattening and renaming of keys' do
		before :each do
			@res = Convert.import_old_file('teachers.xml')
		end
			
		describe 'one_record' do
			it "turns an array of name/content hashes into a hash of name => content hashes" do
				Convert.one_record(Teacher, @res[0]).should be_kind_of Teacher
			end
		end
	
		describe 'from_hashes' do
			it "fixed an entire set of hashes (see flatten_one)" do
				Convert.from_hashes(Teacher, @res).should be_kind_of Array
			end
		end
		
	end
			
end

