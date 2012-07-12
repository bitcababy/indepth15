require 'spec_helper'

describe Assignment do
	
	context "Fabricator" do
		subject { Fabricate(:assignment) }
		specify { subject.content.should_not be_nil }
	end

	# context "importing" do
	# 	describe '::convert_record' do
	# 		before :each do
	# 			@hash = {
	# 				'description' => (@txt = "Read and study section 5.3 and do problems 10,13,14,17,22,23,24, and 30."),
	# 				'kind' => 'HTML',
	# 				'orig_id' => 609595,
	# 				'teacher_id' => 'gabrinerd',
	# 				'year' => 2010
	# 			}
	# 			@assignment = Assignment.convert_record(@hash)
	# 		end
	# 	
	# 		it "should have contents that match the 'description' field" do
	# 			@assignment.content.should == @txt
	# 		end
	# 	end
	# 	
	# end

end
