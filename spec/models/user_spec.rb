require 'spec_helper'

describe User do
	[:honorific, :first_name, :last_name, :email, :login].each do |field|
		it {should validate_presence_of field }
	end
	
	it { should validate_uniqueness_of :login}
	
	context "Fabrication testing" do
		context ":user" do
			subject {Fabricate :user, first_name: 'Ralph', last_name: 'Kramden', login: 'kramdenr'}
			specify { subject.login.should == 'kramdenr' }

			it "should accept a login override" do
				Fabricate(:user, login: 'greenx')
				User.where(login: 'greenx' ).should exist
			end
		end
		
		context ":teacher" do
			subject {Fabricate :teacher, first_name: 'Ralph', last_name: 'Kramden', login: 'kramdenr'}
			specify { subject.login.should == 'kramdenr' }
			specify { subject.should be_kind_of Teacher}
		end

		context ":test_teacher" do
			subject {Fabricate :test_teacher, first_name: 'Ralph', last_name: 'Kramden', login: 'kramdenr'}
			specify { subject.should be_kind_of Teacher}
		end

		context ":test_admin" do
			subject {Fabricate :test_admin, first_name: 'Ralph', last_name: 'Kramden', login: 'kramdenr'}
			specify { subject.should be_kind_of Admin}
		end

	end
	
	describe '#formal_name' do
		it "should return the honorific + the last name" do
			user = Fabricate :user, honorific: "Mr.", last_name: "Masterson"
			user.formal_name.should == "Mr. Masterson"
		end
	end
	
	describe '#full_name' do
		it "should return the honorific + the last name" do
			user = Fabricate :user, first_name: "Bat", last_name: "Masterson"
			user.full_name.should == "Bat Masterson"
		end
	end
	
end