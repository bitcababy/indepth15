require 'spec_helper'

describe User do
	
	context "Fabrication testing" do
		subject {Fabricate :user, first_name: 'Ralph', last_name: 'Kramden'}
		specify { subject.login.should == 'kramdenr' }
		it "should accept a login override" do
			Fabricate(:teacher, login: 'greenx')
			User.where(login: 'greenx' ).should exist
		end
	end
	
	describe 'formal_name' do
		it "should return the honorific + the last name" do
			user = Fabricate :user, honorific: "Mr.", last_name: "Masterson"
			user.formal_name.should == "Mr. Masterson"
		end
	end
end