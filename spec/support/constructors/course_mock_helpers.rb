# module CourseMockHelpers
#   include DueDate
# 
#   def mock_and_stub(name, opts)
#     mock name do
#       opts.each { |k,v| stub(k).and_return(v) }
#     end
#   end
#     
#   def mock_teacher(opts={})
#     defaults = {
#         login: 'doej',
#         first_name: "John",
#         last_name: "Doe",
#         formal_name: "Mr. Doe",
#         full_name: "John Doe",
#         generic_msg: "Generic msg", 
#         current_msg: "Current msg", 
#         upcoming_msg: "Upcoming_msg"}
#     opts = defaults.merge(opts)
#     # opts[:menu_label] = opts[:formal_name]
#     # opts.merge!(defaults) {|key, v1, v2| v1}
#     mock_and_stub opts[:full_name], opts
#   end
# 
#   def mock_section(opts={})
#     defaults = {year: 2013, 
#         block: Settings.blocks.sample, 
#         days_for_section: [1,2,3,4,5], 
#         room: "222"}
#     opts = defaults.merge(opts)
#     opts[:teacher] = mock_teacher unless opts[:teacher]
#     opts[:course] = mock_course unless opts[:course]
#     mock_and_stub "Section #{opts[:block]}", opts
#   end
#   
#   def mock_text_doc(txt)
#     mock 'text_document' do
#       stub(:content).and_return txt
#     end
#   end
# 
#   def mock_course(opts={})
#     opts.merge!({number: 321, 
#         duration: Course::FULL_YEAR, credits: 5.0, 
#         year: Settings.academic_year,
#         full_name: "Fractals 101", 
#         }) {|key, v1, v2| v1}
#     
#     [:description, :policies, :resources, :information, :news].each do |area|
#       opts[area] =  mock_text_doc("#{area.to_s.capitalize} for course #{opts[:number]}")
#     end
#     opts[:menu_label] = opts[:full_name]
#     mock_and_stub "Course #{opts[:number]}", opts
#   end
# 
#   def mock_section_assignment(opts={})
#     opts.merge!( {name: "21", due_date: Date.new(2012, 7, 20), assigned: true }) {|key, v1, v2| v1}
#     if opts[:name]
#       opts[:name] = mock_assignment("This is assignment #{opts[:name]}")
#     end
#     
#      mock_and_stub "section_assignment", opts
#   end
#   
#   def mock_assignment(txt)
#     mock 'assignment' do
#       stub(:content).and_return txt
#     end
#   end
#   
#   def mock_section_assignments(n=3)
#     (1..n).collect {|i| mock_section_assignment(name: "Assignment #{i}", assignment: "Content for assignments #{i}") }
#   end
# 
#   def mock_section_with_assignments(opts={})
#     if opts[:teacher]
#       the_teacher = opts[:teacher]
#     else
#       the_teacher = mock_teacher login: "foobar", email: "foo@example.com" 
#     end
# 
#     if opts[:course]
#       the_course = opts[:course]
#     else
#       the_course = mock_course
#     end
#     the_section = mock_section course: the_course, teacher: the_teacher, block: "B"
#     the_course.stub(:sections).and_return [the_section]
#     the_course.stub(:sorted_sections).and_return [sections]
#   
#     sas = []
#     1.times do |i|
#       name = "1#{i}"
#       asst = mock_assignment "Assignment #{name}"
#       sas << mock_section_assignment(assignment: asst, 
#         due_date: future_due_date + i, 
#         name: name,
#         section: the_section
#         )
#     end
#     the_section.stub(:current_assignments).and_return sas
# 
#     sas = []
#     3.times do |i|
#       name = "2#{i}"
#       asst = mock_assignment "Assignment #{name}"
#       sas << mock_section_assignment(assignment: asst, 
#         due_date: future_due_date + i, 
#         name: name,
#         section: the_section
#         )
#     end
#     the_section.stub(:upcoming_assignments).and_return sas
# 
#     sas = []
#     4.times do |i|
#       name = "1#{i}"
#       asst = mock_assignment "Assignment #{name}"
#       sas << mock_section_assignment(assignment: asst, 
#             due_date: future_due_date - i,
#             name: name,
#             section: @the_section
#             )
#     end
#     the_section.stub(:past_assignments).and_return sas
#     the_section.stub(:section_assignments).and_return sas
#     return the_section
#   end
#   
#   def add_assignments_to(section)
#     sas = []
#     3.times do |i|
#       name = "2#{i}"
#       asst = mock_assignment "Assignment #{name}"
#       sas << mock_section_assignment(due_date:  future_due_date + i + 1, name: name, section: section, assignment: asst)
#     end
# 
#     4.times do |i|
#       name = "2#{i}"
#       asst = mock_assignment "Assignment #{name}"
#       sas << mock_section_assignment(due_date:  future_due_date - i - 1, name: name, section: section, assignment: asst)
#     end
# 
#     return section
#   end
#   
#   def mock_course_with_sections(n = 3)
#     course = mock_course
#     sections = []
#     n.times do |i|
#       sections << mock_section
#     end
#     course.stub(:sections).and_return sections
#     course.stub(:sorted_sections).and_return sections
#     return course
#   end  
#     
# end
#     