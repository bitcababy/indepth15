# From: https://github.com/plataformatec/devise/wiki/How-To:-Do-not-redirect-to-login-page-after-session-timeout
class CustomFailureApp < Devise::FailureApp
  def redirect
    logger.warn "*** In CustomFailureApp ***"
    message = warden.message || warden_options[:message]
    if message == :timeout
      redirect_to attempted_path
    else
      super
    end
  end
end
