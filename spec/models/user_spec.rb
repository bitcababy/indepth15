require 'spec_helper'

describe User do
	[:honorific, :first_name, :last_name, :email, :login].each do |field|
		it {should validate_presence_of field }
	end
	
	it { should validate_uniqueness_of :login}
	
  describe 'to_s' do
    it "returns the full name of a teacher" do
      teacher = Fabricate(:teacher, first_name: "John", last_name: "Doe")
      expect(teacher.to_s).to eq "John Doe"
    end
  end

  describe 'menu_label' do
    it "returns the full name of a teacher" do
      teacher = Fabricate(:teacher, first_name: "John", last_name: "Doe")
      expect(teacher.menu_label).to eq teacher.full_name
    end
  end

	context "Fabrication testing" do
		context ":user" do
			subject {Fabricate :user, first_name: 'Ralph', last_name: 'Kramden', login: 'kramdenr'}
			specify { expect(subject.login).to eq 'kramdenr' }

			it "should accept a login override" do
				Fabricate(:user, login: 'greenx')
				expect(User.where(login: 'greenx')).to exist
			end
		end
		
    # context ":teacher" do
    #   subject {Fabricate :teacher, first_name: 'Ralph', last_name: 'Kramden', login: 'kramdenr'}
    #   specify { expect(subject.login).to eq 'kramdenr' }
    #   specify { expect(subject).to be_kind_of Teacher}
    # end
    # 
    # context ":test_teacher" do
    #   subject {Fabricate :test_teacher, first_name: 'Ralph', last_name: 'Kramden', login: 'kramdenr'}
    #   specify { expect(subject).to be_kind_of Teacher}
    # end
    # 
    # context ":test_admin" do
    #   subject {Fabricate :test_admin, first_name: 'Ralph', last_name: 'Kramden', login: 'kramdenr'}
    #   specify { expect(subject).to be_kind_of Admin}
    # end

	end
	
	describe '#formal_name' do
		it "should return the honorific + the last name" do
			user = Fabricate :user, honorific: "Mr.", last_name: "Masterson"
			expect(user.formal_name).to eq "Mr. Masterson"
		end
	end
	
	describe '#full_name' do
		it "should return the honorific + the last name" do
			user = Fabricate :user, first_name: "Bat", last_name: "Masterson"
			expect(user.full_name).to eq "Bat Masterson"
		end
	end
	
end