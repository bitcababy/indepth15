# From: https://github.com/plataformatec/devise/wiki/How-To:-Do-not-redirect-to-login-page-after-session-timeout
class CustomFailureApp < Devise::FailureApp
  def http_auth
    # logger.warn "***http_auth"
    super
  end

  def recall
    # logger.warn "***recall" 
    super
  end

  def respond
    # logger.warn "***respond"
    super
  end

  def redirect
    flash[:warden] = warden.message || warden_options[:message]
    if flash[:warden] == :timeout
      redirect_to home_path
    else
      super
    end
  end
end
