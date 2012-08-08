class UserObserver < Mongoid::Observer
	def before_create(obj)
		if obj.roles.empty?
			obj.roles << Role.find_or_create_by_name(Role::REGISTERED)
		end
	end
end
