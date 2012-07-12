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
	describe 'formal_name' do
		it "should return the honorific + the last name" do
			teacher = Fabricate :teacher, honorific: "Mr.", last_name: "Masterson"
			teacher.formal_name.should == "Mr. Masterson"
		end
	end
	
	# context 'importing' do
	# 	describe '::convert_record' do
	# 		before :each do
	# 			@hash ={
	# 				"_id"=>"4ff9f8f5092427cdc1000001", 
	# 				"default_room"=>203, "first_name"=>"Joshua", "generic_msg"=>nil, 
	# 				"home_page"=>"http://www.westonmath.org/teachers/abramsj/math4/quotes.html", 
	# 				"honorific"=>"Mr.", "last_name"=>"Abrams", "old_current"=>1, "orig_id"=>1, 
	# 				"photo_url"=>"http://www.westonmath.org/teachers/abramsj/math4/picture.jpg", 
	# 				"phrase"=>"this is a password", "teacher_id"=>"abramsj", "upcoming_msg"=>nil}
	# 			@teacher = Teacher.convert_record(@hash)
	# 			@teacher.should_not be_nil
	# 		end
	# 	
	# 		it "creates an email address from the teacher_id" do
	# 			@teacher.email.should == "abramsj@mail.weston.org"
	# 		end
	# 		it "creates a password from the phrase" do
	# 			@teacher.password.should == "tiap"
	# 		end
	# 		it "sets current from old_current" do
	# 			@teacher.current.should be_true
	# 		end
	# 		
	# 		it "sets its login from the teacher_id" do
	# 			@teacher.login.should == "abramsj"
	# 		end
	# 	end
	# 	
	# 	describe 'load_from_data' do
	# 		it "should have records created by its import class" do
	# 			Import::Teacher.load_from_data
	# 			Teacher.count.should > 0
	# 		end
	# 	end
	# end
	
end
