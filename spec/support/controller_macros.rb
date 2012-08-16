module ControllerMacros
  def login_admin
     before(:each) do
       @request.env["devise.mapping"] = Devise.mappings[:user]
       sign_in Fabricate(:test_admin) 
     end
   end
 
  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = Fabricate(:user)
      sign_in user
    end
  end

  def login_teacher
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = Fabricate(:test_teacher)
      sign_in user
    end
  end
end
