class Users::SessionsController < Devise::SessionsController
	skip_before_filter :verify_authenticity_token, :only => [] 
	
	def create 
    login = params[:user][:login] 
    user = User.find_for_database_authentication({:login => login})
    password = params[:user][:password] 
    if (!user.nil?)
      sign_in user, event: :authentication
      respond_to do |format|
        format.json { render status: 200, json: {error: "Success"} }
      end
    else
      respond_to do |format|
        format.html { render partial: 'failed_signin' }
        format.json { render :head, status: "failure" }
      end
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
      respond_to do |format|
        format.json { render status: 200, json: {error: "Success"} }
      end
    end
  end

end
