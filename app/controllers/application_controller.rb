class ApplicationController < ActionController::Base
  protect_from_forgery
	
	# For ajax requests
	# skip_before_filter :verify_authenticity_token, :only => [:name_of_your_action] 

	helper_method :user_signed_in?

	def user_signed_in?
		!!current_user
	end
	
	helper_method :current_user

	def current_user
		@current_user ||= warden.authenticate(:scope => :user)
	end
	
	def user_session
		current_user && warden.session(:user)
	end

	# if user is logged in, return current_user, else return guest_user
	 def current_or_guest_user
    if current_user
      if session[:guest_user_id]
        logging_in
        guest_user.destroy
        session[:guest_user_id] = nil
      end
      current_user
    else
      guest_user
    end
  end

  # find guest_user object associated with the current session,
  # creating one as needed
  def guest_user
    User.find(session[:guest_user_id].nil? ? session[:guest_user_id] = create_guest_user.id : session[:guest_user_id])
  end

  private

  # called (once) when the user logs in, insert any code your application needs
  # to hand off from guest_user to current_user.
  def logging_in
    # For example:
    # guest_comments = guest_user.comments.all
    # guest_comments.each do |comment|
      # comment.user_id = current_user.id
      # comment.save
    # end
  end

  def create_guest_user
    u = User.new
    u.save(:validate => false)
    u
  end

	# def devise_mapping
	# 	@devise_mapping ||= Devise.mappings[:user]
	# end

end
