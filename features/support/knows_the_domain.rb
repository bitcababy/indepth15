module KnowsTheDomain
	def guest
		@the_user ||= Fabricate(:guest)
	end
	
	def logged_in_user
		@the_user ||= Fabricate(:guest)
	end

	def the_user=(u)
		@the_user = u
	end
	
	def the_section
		@the_section ||= Fabricate(:section)
	end
	
	def the_section=(s)
		@the_section = s
	end

	def the_course
		@the_course ||= Fabricate(:course)
	end
	
	def the_course=(c)
		@the_course = c
	end
	
end

World(KnowsTheDomain)
