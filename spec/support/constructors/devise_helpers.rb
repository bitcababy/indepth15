module DeviseHelpers
  def create_guest
    guest = mock(:guest)
    request.env['warden'].stub(:authenticate!).and_throw(:warden, {scope: :user})
    controller.stubs(:current_user).returns user
  end
  
  def create_user
    user = mock(:user)
    request.env['warden'].stubs(:authenticate!).returns user
    controller.stubs(:current_user).returns user
  end  
end
