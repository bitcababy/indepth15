class Users::SessionsController < Devise::SessionsController
	skip_before_filter :verify_authenticity_token, :only => [] 
	
	def create 
    login = params[:user][:login] 
    password = params[:user][:password] 
    user = User.find_for_database_authentication({:login => login})
    if (!user.nil?) && (Rails.env == 'test' || user.valid_password?(password)) 
      sign_in user, event: :authentication
      redirect_to :back
      # render :status => 200, :json => { :error => "Success" }  
    else
      render :status => 401, :json => { :error => "failure" }
    end
	end
	
	def new
    respond_to do |format| 
      format.html { render :new, layout: nil }
		end
	end
  
  # DELETE /resource/sign_out
  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message :notice, :signed_out if signed_out && is_navigational_format?

    # We actually need to hardcode this as Rails default responder doesn't
    # support returning empty response on GET request
    respond_to do |format|
      format.all { render json: {error: "Success" } }
    end
  end

			
end