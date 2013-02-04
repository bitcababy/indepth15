module CourseHelper
	
	def setup_course(course, args)
		args.merge max_sections: 5, teachers: 3
		args[:teachers].times { Fabricate :teacher }
		rand(1.max_sections).times { Fabricate :section, course: course, teacher: Teacher.sample }
	end
	
	def setup_courses(args)
		args.merge courses: 3, max_sections: 5, teachers: 3
		for course in Course.all do
			setup_course(course, args)
		end
	end
end
