class UserSessionsController < Devise::SessionsController
	layout :choose_layout 
	
	# def create
	# 	respond_to do |format|
	# 		format.html { super }
	# 		format.json {
	#        	warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#new")  
	#         render :status => 200, :json => { :error => "Success" }  
	# 		}
	# 	end
	# end
	
	def create 
    login = params[:user][:login] 
    password = params[:user][:password] 
    user = User.find_for_database_authentication({:login => login})
    if (!user.nil?) && (user.valid_password?(password)) 
      sign_in user, event: :authentication
    else
      @user = User.new 
      respond_to do |format| 
        format.html { render :new } 
        # format.js { render_to_facebox } 
      end 
    end
	end
		
	def logged_in
		foo
	end

	def new
		@user = User.new
		respond_to do |format|
      format.html
			format.js
     end
	end

	def destroy
		super
	end
	
	private 

  def choose_layout 
    (request.xhr?) ? nil : 'application' 
  end

end
