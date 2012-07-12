module DeviseHelper
  # A simple way to show error messages for the current devise resource. If you need
  # to customize this method, you can either overwrite it in your application helpers or
  # copy the views to your application.
  #
  # This method is intended to stay simple and it is unlikely that we are going to change
  # it to add more behavior or options.
  # def devise_error_messages!
  #   return "" if resource.errors.empty?
  # 
  #   messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
  #   sentence = I18n.t("errors.messages.not_saved",
  #                     :count => resource.errors.count,
  #                     :resource => resource.class.model_name.human.downcase)
  # 
  #   html = <<-HTML
  #   <div id="error_explanation">
  #     <h2>#{sentence}</h2>
  #     <ul>#{messages}</ul>
  #   </div>
  #   HTML
  # 
  #   html.html_safe
  # end

	def authenticate_user!(opts={})
		opts[:scope] = :user
		warden.authenticate!(opts) if !devise_controller? || opts.delete(:force)
	end

	def user_signed_in?
		!!current_user
	end

	def current_user
		@current_user ||= warden.authenticate(:scope => :user)
	end

	def user_session
		current_user && warden.session(:user)
	end

end