module World
  def setup(tn: 3, cn: 2, sn: 2, an: 2)
    Fabricate :department
    tn.times { Fabricate :teacher }
    cn.times { Fabricate :course }
    Teacher.each do |teacher|
      courses = Course.all.sample(3)
      courses.each do |course|
        sn.times { Fabricate :section, teacher: teacher, course: course }
      end
    end
    
    Courses.each do |course|
      course.teachers.each do |teacher|
        sections = teacher.sections.for_course(course)
        unless sections.empty?
          assts = an.times { Fabricate :assignments}
          for section in sections do
            for asst in assts do
              section.section_assignments << Fabricate(:section_assignment, section: section, assignment: asst)
            end
          end
        end
      end
    end

  end #setup
end
