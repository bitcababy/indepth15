module DeviseControllerMacros
  ###
  # Devise
  ###
  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = Fabricate :user
      sign_in user
    end
  end
end

RSpec.configure do |config|
  config.extend DeviseControllerMacros, :type => :controller
end
