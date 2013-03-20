# module DeviseHelpers
#   def create_guest
#     guest = mock(:guest)
#     request.env['warden'].stub(:authenticate!).and_throw(:warden, {scope: :user})
#     controller.stub(:current_user).and_return user
#   end
#   
#   def create_user
#     user = mock(:user)
#     request.env['warden'].stub(:authenticate!).and_return user
#     controller.stub(:current_user).and_return user
#   end  
# end
