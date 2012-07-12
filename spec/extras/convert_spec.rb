require 'spec_helper'

describe Convert do
	describe 'import_old_file' do
		it "imports a file using XmlSimple and returns an array of name, content hashes" do
			res = Convert.import_old_file('sections.xml')
			res.should be_kind_of Array
		end
	end
	
	context 'flattening and renaming of keys' do
		before :each do
			@res = Convert.import_old_file('sections.xml')
		end
			
		describe 'one_record' do
			it "turns an array of name/content hashes into a hash of name => content hashes" do
				puts Convert.one_record(Section, @res[0])
			end
		end
	
		describe 'from_hashes' do
			it "fixed an entire set of hashes (see flatten_one)" do
				Convert.from_hashes(Section, @res).should be_kind_of Array
			end
		end
		
		# describe 'one_record' do
		# 	it "calls 'convert_to_record' with a hash of values" do
		# 		arr = Convert.flatten(@map, @res)
		# 		puts arr[0]
		# 		# puts Convert.one_record(SectionAssignment, arr[0])
		# 	end
		# end
		
	end
			
	# describe 'export_to_xml' do
	# 	it "uses XmlSimple to write an array of hashes" do
	# 		res = Convert.import_old_file('teachers.xml')
	# 		res = Convert.flatten(Convert::MAPPINGS[:teacher], res)
	# 		path = File.join(Rails.root, 'data', "teachers.xml")
	# 		Convert.export_to_xml(path, res)
	# 	end
	# end
	# 
	# describe 'path_for_class' do
	# 	it "returns a path in the data directory for a class" do
	# 		Convert.path_for_class(Teacher).should == File.join(Rails.root, 'data', 'teachers.xml')
	# 	end
	# end
			
end

