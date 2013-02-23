class ApplicationController < ActionController::Base
	protect_from_forgery
  before_filter :reload_settings

  ##
  # Stuff to store and return to last recorded page
  ##
  def remember_current_page
    flash[:notice] = nil
    flash[:error] = nil
    cookies[:last_page] = request.original_fullpath
  end

  helper_method :stored_page
  def stored_page
    cookies[:last_page]
  end
  
  def return_to_last_page(args = {})
    flash[:notice] = args[:notice]
    flash[:error] = args[:error]
    redirect_to stored_page
  end

  def reload_settings
    Settings.reload unless Rails.env.test?
  end

	# For ajax requests
	# skip_before_filter :verify_authenticity_token, :only => [:name_of_your_action] 
	
  unless Rails.application.config.consider_all_requests_local
      rescue_from Exception, with: :render_500
      rescue_from ActionController::RoutingError, with: :render_404
      rescue_from ActionController::UnknownController, with: :render_404
      rescue_from ::AbstractController::ActionNotFound, with: :render_404
      rescue_from Mongoid::Errors::DocumentNotFound, with: :render_404
  end  
  # 
  ## Note: Unclear why I need any of these
	##
	## Devise methods
	##
  # helper_method :current_user
  # 
  def current_user
    return @current_user ||= warden.authenticate(:scope => :user)
  end
  
  helper_method :current_user_name
  def current_user_name
    return user_signed_in? ? current_user.full_name : "Guest"
  end
  
  # helper_method :user_signed_in?
  # 
  def user_signed_in?
    return !!current_user
  end
  # 
  def user_session
    return current_user && warden.session(:user)
  end

	# if user is logged in, return current_user, else return guest_user
  def current_or_guest_user
    if current_user
      if session[:guest_user_id]
        logging_in
        guest_user.destroy
        session[:guest_user_id] = nil
      end
      return current_user
    else
      return guest_user
    end
  end
  
  # # find guest_user object associated with the current session,
  # # creating one as needed
  # def guest_user
  #   return  User.find(session[:guest_user_id].nil? ? session[:guest_user_id] = create_guest_user.id : session[:guest_user_id])
  # end

	private

	# called (once) when the user logs in, insert any code your application needs
	# to hand off from guest_user to current_user.
  # def logging_in
  #   # For example:
  #   # guest_comments = guest_user.comments.all
  #   # guest_comments.each do |comment|
  #     # comment.user_id = current_user.id
  #     # comment.save
  #   # end
  # end
  # 
  # def create_guest_user
  #   u = User.new
  #   u.save(:validate => false)
  #   return u
  # end

	# def devise_mapping
	#		@devise_mapping ||= Devise.mappings[:user]
	# end
	
	protected
		def ckeditor_filebrowser_scope(options = {})
			super({ :assetable_id => current_user.id, :assetable_type => 'User' }.merge(options))
		end
		
	private
  def render_404(exception)
    @not_found_path = exception.message
		##
		## handle old paths
		##
		if m = exception.message.match(/^\/course_index\.php\?course_num=(\d+)$/)
			redirect_to controller: :courses, action: :show, id: "#{m[0]}.to_i"
			return 
		end

    respond_to do |format|
      format.html { render template: 'errors/error_404', layout: 'layouts/application', status: 404 }
      format.all { render nothing: true, status: 404 }
    end
  end

  def render_500(exception)
    @error = exception
    respond_to do |format|
      format.html { render template: 'errors/error_500', layout: 'layouts/application', status: 500 }
      format.all { render nothing: true, status: 500}
    end
  end
	  
end
