class Users::SessionsController < Devise::SessionsController
	skip_before_filter :verify_authenticity_token, :only => [] 
	
	def create
		respond_to do |format|
			format.html { super }
			format.json {
	       	warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#new")  
	        render :status => 200, :json => { :error => "Success" }  
			}
		end
	end
	
	def create 
    login = params[:user][:login] 
    password = params[:user][:password] 
    user = User.find_for_database_authentication({:login => login})
    if (!user.nil?) && (user.valid_password?(password)) 
      sign_in user, event: :authentication
      render :status => 200, :json => { :error => "Success" }  
    else
      render :status => 401, :json => { :error => "failure" }
    end
	end
	
	def new
    respond_to do |format| 
      format.html { render :new, layout: nil }
		end
	end
			
end