# module FabricationMacros
#   DEFAULT_FUTURE = 3
#   DEFAULT_PAST = 2
#   include DueDate
#   
#   def create_occurrences(section)
#     for occ in section.occurrences 
#       Fabricate :occurrence, block: section.block, number: occ, day: (1..8).to_a.sample
#     end
#   end
#     
#   def course_with_sections
#     course = Fabricate(:course)
#     t1 = Fabricate :teacher, login: "foobar"
#     t2 = Fabricate :teacher, login: "mastersonb"
#     3.times {Fabricate :section, course: course, teacher: t1 }
#     2.times {Fabricate :section, course: course, teacher: t2 }
#     return course
#   end
# 
#   def make_assignments(section, n = 3, kind = :future)
#     n.times {|i| section.add_assignment(i.to_s, Fabricate(:assignment), future_due_date + (kind == :future ? rand(1..5) : rand(-5..-1)), true)  }
#   end
# 
#   def section_with_assignments(options = {})
#     c = options[:course]
#     section = Fabricate(:section, year: Settings.academic_year)
#     section.course = c if c
#     nf = options[:future] || DEFAULT_FUTURE
#     np = options[:past] || DEFAULT_PAST
#     make_assignments(section, nf, :future)
#     make_assignments(section, np, :past)
#     return section
#   end
#   
#   def add_some_assignments(section, past, future)
#     past.times {|i| section.add_assignment("past #{i}", Fabricate(:assignment), Date.today + rand(1..10))}
#     future.times { section.add_assignment("future #{i}", Fabricate(:assignment), Date.today - 1) }
#     return section
#   end
#   
# end #CourseExampleHelpers
