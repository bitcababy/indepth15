class CourseObserver < Mongoid::Observer
	
	def after_create(obj)
		branches = Course::BRANCH_MAP[obj.number]
		branches = [branches] unless branches.kind_of? Array

		for branch in branches do
			obj.branches.find_or_create_by(name: branch)
		end
		branches = Course::BRANCH_MAP[obj.number]
		branches = [branches] unless branches.kind_of? Array

		for branch in obj.branches do
			obj.major_tags.concat branch.major_tags
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
