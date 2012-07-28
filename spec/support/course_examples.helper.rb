module CourseExamplesHelper
	DEFAULT_FUTURE = 3
	DEFAULT_PAST = 2
	
	def create_occurrences(section)
		for occ in section.occurrences 
			Fabricate :occurrence, block: section.block, number: occ, day: (1..8).to_a.sample
		end
	end
		
	def course_with_sections(n = 3)
		course = Fabricate(:course)
		n.times { section_with_assignments(course: course) }
		return course
	end

	def make_assignments(section, n = 3, kind = :future)
		n.times { section.add_assignment( Fabricate(:assignment), Date.today + (kind == :future ? rand(1..5) : rand(-5..-1)))	}
	end

	def section_with_assignments(options = {})
		c = options[:course]
		section = Fabricate(:section, academic_year: Settings.academic_year)
		section.course = c if c
		nf = options[:future] || DEFAULT_FUTURE
		np = options[:past] || DEFAULT_PAST
		make_assignments(section, nf, :future)
		make_assignments(section, np, :future)
		return section
	end
	
	def add_some_assignments(section, past, future)
		past.times { section.add_assignment(Fabricate(:assignment), Date.today + rand(1..10))}
		future.times { section.add_assignment(Fabricate(:assignment), Date.today - 1) }
		return section
	end
	
end #CourseExamplesHelper
