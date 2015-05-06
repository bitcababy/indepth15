module World
  def self.create_world(tn: 3, cn: 2, sn: 2, an: 2)
    dept = Fabricate :department
    tn.times { Fabricate :teacher, dept: dept}
    cn.times { Fabricate :course, department: dept }
    ::Teacher.each do |teacher|
      courses = ::Course.all.sample(3)
      courses.each do |course|
        sn.times { Fabricate :section, teacher: teacher, course: course }
      end
    end
    
    ::Course.each do |course|
      course.teachers.each do |teacher|
        sections = teacher.sections.for_course(course)
        unless sections.empty?
          an.times { Fabricate :assignment}
          for section in sections do
            ::Assignment.each do |asst|
              section.section_assignments << Fabricate(:section_assignment, section: section, assignment: asst)
            end
          end
        end
      end
    end
    return dept
  end #create_world
end
