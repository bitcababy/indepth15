module UsersHelper
	def resource_class
		return User
	end

	def resource_name
		return :user
	end

	def resource
		return @resource || User.new
	end

	def devise_mapping
		return @devise_mapping ||= Devise.mappings[:user]
	end

	def resource_name
		return devise_mapping.name
	end

	def resource_class
		return devise_mapping.to
	end

	def authenticate_user!(opts={})
		opts[:scope] = :user
		return warden.authenticate!(opts) if !devise_controller? || opts.delete(:force)
	end
end

