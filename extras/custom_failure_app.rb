# From: https://github.com/plataformatec/devise/wiki/How-To:-Do-not-redirect-to-login-page-after-session-timeout
class CustomFailureApp < Devise::FailureApp
  def redirect
    message = warden.message || warden_options[:message]
    if message == :timeout
      redirect_to home_path
    else
      super
    end
  end
end
