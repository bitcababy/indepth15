require 'spec_helper'

describe Teacher do
	it { should have_many(:sections) }
		
	# context "scopes" do
	# 	it "should return current teachers" do
	# 		3.times {Fabricate(:teacher, current: true)}
	# 		2.times {Fabricate(:teacher, current: false)}
	# 		Teacher.count.should == 5
	# 		Teacher.current.count.should == 3
	# 	end
	# end
	# 
	
	context "Fabrication testing" do
		it "should accept a login override" do
			Fabricate(:teacher, login: 'greenx')
			Teacher.where(login: 'greenx' ).should exist
		end
	end
	
	context 'importing' do
		describe '::convert_record' do
			before :each do
				@hash = {
					:default_room=>203, :first_name=>"Joshua", :generic_msg=>"generic message", 
					:home_page=>"http://www.westonmath.org/teachers/abramsj/math4/quotes.html", 
					:honorific=>"Mr.", :last_name=>"Abrams", :old_current=>1,
					:photo_url=>"http://www.westonmath.org/teachers/abramsj/math4/picture.jpg", 
					:phrase=>"this is a password", :login=>"abramsj", :upcoming_msg=>"Upcoming message"}
				@teacher = Teacher.import_from_hash(@hash)
				@teacher.should_not be_nil
			end
		
			it "creates an email address from the teacher_id" do
				@teacher.email.should == "abramsj@mail.weston.org"
			end
			it "creates a password from the phrase" do
				@teacher.password.should == "tiap"
			end
			it "sets current from old_current" do
				@teacher.current.should be_true
			end
			
		end
	end
	
end
