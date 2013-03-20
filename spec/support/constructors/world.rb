# module World
#   def setup
#     Fabricate :department
#     5.times { Fabricate :teacher }
#     4.times { Fabricate :course }
#     Teacher.each do |teacher|
#       courses = Course.all.sample(3)
#       courses.each do |course|
#         Fabricate :section, teacher: teacher, course: course
#       end
#     end
#     
#     Courses.each do |course|
#       course.teachers.each do |teacher|
#         sections = teacher.sections.for_course(course)
#         unless sections.empty?
#           assts = [Fabricate(:assignment), Fabricate(:assignment), Fabricate(:assignment)]
#           for section in sections do
#             for asst in assts do
#               section.section_assignments << Fabricate(:section_assignment, section: section, assignment: asst)
#             end
#           end
#         end
#       end
#     end
# 
#   end #setup
# end
