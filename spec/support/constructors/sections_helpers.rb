module SectionsHelpers
  def create_some_sections(teachers: 3, courses: 4, years: 2)
    teachers.times { Fabricate :teacher }
    courses.times { Fabricate :course }
    Teacher.each do |t|
      Course.each do |c|
        (Settings.academic_year - (years-1)).upto(Settings.academic_year) do |y|
          Fabricate :section, course: c, teacher: t, year: y
        end
      end
    end
  end

end