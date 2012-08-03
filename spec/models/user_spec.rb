require 'spec_helper'

describe User do
	[:honorific, :first_name, :last_name, :email, :login].each do |field|
		it {should validate_presence_of field }
	end
	
	context "Fabrication testing" do
		subject {Fabricate :user, first_name: 'Ralph', last_name: 'Kramden', login: 'kramdenr'}
		specify { subject.login.should == 'kramdenr' }

		it "should accept a login override" do
			Fabricate(:user, login: 'greenx')
			User.where(login: 'greenx' ).should exist
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