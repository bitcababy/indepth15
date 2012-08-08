module CourseMockHelpers
	def mock_teacher(opts={})
		opts.merge!(formal_name: "Mr. Doe") {|key, v1, v2| v1}
		mock(opts[:formal_name]) do
					opts.each_pair {|k, v| stubs(k).returns v}
				end
	end

	def mock_section(opts={})
		opts.merge!({block: Settings.blocks.sample, days_for_section: [1,2,3,4,5], room: "222"}) {|key, v1, v2| v1}
		opts[:teacher] = mock_teacher unless opts[:teacher]
		mock("Section #{opts[:block]}") do
			opts.each_pair {|k, v| stubs(k).returns v}
		end
	end

	def mock_course(opts={})
		opts.merge!({number: 321, duration: Course::FULL_YEAR, credits: 5.0, 
				description: "A description", full_name: "Fractals 101"}) {|key, v1, v2| v1}
		return mock("Course #{opts[:number]}") do
			opts.each_pair {|k, v| stubs(k).returns v}
		end
	end

	def mock_section_assignment(opts={})
		opts.merge!( {name: "21", due_date: Date.new(2012, 7, 20) }) {|key, v1, v2| v1}
		sa = mock("section_assignment") do
			opts.each_pair {|k, v| stubs(k).returns v}
		end
		# sa = mock("section_assignment '#{opts[:name]}'", opts)
		if opts[:assignment]
			sa.stubs(:assignment).returns mock_assignment("This is assignment #{opts[:name]}")
		end
		return sa
	end
	
	def mock_assignment(txt)
		mock('assignment') do
			stubs(:content).returns txt
		end
	end
	
	def mock_section_assignments(n=3)
		(1..n).collect {|i| mock_section_assignment(name: "Assignment #{i}", assignment: "Content for assignments #{i}") }
	end

	def mock_section_with_assignments
		the_teacher = mock_teacher login: "foobar", email: "foo@example.com" 
		the_course = mock_course
		the_section = mock_section course: the_course, teacher: the_teacher, block: "B"
		course.stubs(:sections).returns [the_section]
		course.stubs(:current_sections).returns [the_section]
	
		sas = []
		3.times do |i|
			name = "2#{i}"
			asst = mock_assignment "Assignment #{name}"
			sas << mock_section_assignment(assignment: asst, 
				due_date: Utils.future_due_date + i, 
				name: name,
				section: the_section
				)
		end

		4.times do |i|
			name = "1#{i}"
			asst = mock_assignment "Assignment #{name}"
			sas << mock_section_assignment(assignment: asst, 
						due_date: Utils.future_due_date - i,
						name: name,
						section: @the_section
						)
		end
		the_section.stubs(:section_assignments).returns sas
		return the_section
	end
	
	def add_assignments_to(section)
		sas = []
		3.times do |i|
			name = "2#{i}"
			asst = mock_assignment "Assignment #{name}"
			sas << mock_section_assignment(due_date:  Utils.future_due_date + i + 1, name: name, section: section, assignment: asst)
		end

		4.times do |i|
			name = "2#{i}"
			asst = mock_assignment "Assignment #{name}"
			sas << mock_section_assignment(due_date:  Utils.future_due_date - i - 1, name: name, section: section, assignment: asst)
		end

		return section
	end
	
	
	def mock_course_with_sections(n = 3)
		course = mock_course
		sections = []
		n.times do |i|
			sections << mock_section
		end
		course.stubs(:sections).returns sections
		course.stubs(:current_sections).returns sections
		return course
	end
		

	# def do_the_mock(name, opts)
	# 	as_new = opts.delete(:new)
	# 	as_new ? mock(name, *opts).as_new_object : mock(name, *opts)
	# end
	# 	
	# def make_teacher(opts={})
	# 	opts.merge!({formal_name: "Mr. " + %W(Black Blue Orange Purple).sample,
	# 		generic_message: "This is a generic message.",
	# 		current_message: "This is a current message.",
	# 		upcoming_message: "This is an upcoming message.",
	#  		})
	# 	do_the_mock(:teacher, opts)
	# end
	# 
	# def make_course(opts={})
	# 	opts.merge(teacher: make_teacher)
	# 	do_the_mock(:course, opts)
	# end
	# 
	# def make_section(opts={})
	# 	opts.merge!(teacher: make_teacher, course: make_course)
	# 	do_the_mock(:section, opts)
	# end
	# 
	# def mock_assignment(opts={})
	# 	future = opts.delete(:future)
	# 
	# 	opts.merge!(content: "Lorum ipsum blah blah yadda yadda yadda", name: "Foobar")
	# 	opts.merge(due_date: Date.today + (future ? rand(1..3) : rand(-3..-1)))
	# 	do_the_mock(:assignment, opts)
	# end
	# 
	# def mock_assignments(n, opts={})
	# 	assigments = []
	# 	n.times { assigments << mock_assignment(opts) }
	# 	return assigments
	# end

end
		