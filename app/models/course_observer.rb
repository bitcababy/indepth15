class CourseObserver < Mongoid::Observer
	
	def after_create(obj)
		branches = Course::BRANCH_MAP[obj.number]
		if branches
			branches = [branches] unless branches.kind_of? Array

			for branch in branches do
				obj.branches.find_or_create_by(name: branch)
			end
		end
			
		obj.create_information
		obj.create_resources
		obj.create_policies
		obj.create_news
		obj.create_description
		obj.save!
		return obj
	end
		
end
