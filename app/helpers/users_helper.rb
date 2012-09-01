module UsersHelper
	def resource_class
		User
	end

	def resource_name
		:user
	end

	def resource
		@resource || User.new
	end

	def devise_mapping
		@devise_mapping ||= Devise.mappings[:user]
	end

	def resource_name
		devise_mapping.name
	end

	def resource_class
		devise_mapping.to
	end

	def authenticate_user!(opts={})
		opts[:scope] = :user
		warden.authenticate!(opts) if !devise_controller? || opts.delete(:force)
	end
end

