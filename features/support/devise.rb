include Warden::Test::Helpers
Warden.test_mode!

# Will run the given code as the user passed in
def as_user(user = nil, &block)
  current_user = user || Factory.create(:user)
  if request.present?
    sign_in(current_user)
  else
    login_as(current_user, :scope => :user)
  end
  block.call if block.present?
  return self
end


# Will run the given code as the user passed in
def as_admin(user = nil, &block)
  current_user = user || Factory.create(:test_admin)
  if request.present?
    sign_in(current_user)
  else
    login_as(current_user, :scope => :user)
  end
  block.call if block.present?
  return self
end

def as_visitor(user=nil, &block)
  current_user = user || Factory.stub(:guest)
  if request.present?
    sign_out(current_user)
  else
    logout(:user)
  end
  block.call if block.present?
  return self
end