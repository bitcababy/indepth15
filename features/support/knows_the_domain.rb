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

Before('@anypage') do
	visit home_path
end

Before('@anyone') do
	@the_user = Fabricate(:guest)
end

Before('@teacher') do
	@the_user = Fabricate(:test_teacher) unless Admin.where(login: :test_teacher).exists?
end

Before('@admin') do
	@the_user = Fabricate(:test_admin) unless Admin.where(login: :test_admin).exists?
end

