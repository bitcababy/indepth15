Fabricator(:course) do
  transient       :num_sections
  transient       :teacher
	number					{ sequence(:course_number, 42) }
	duration				{ Durations::DURATIONS.sample }
	credits					{ Settings.credits.sample }
	full_name				{ |attrs| "Course #{attrs[:number]}" }
  sections        []
  occurrences     (1..5).to_a
  after_build     { |course, t|
    if (n = t[:num_sections])
      teacher = t[:teacher] || Fabricate.build(:teacher)
      n.times { 
        s = Fabricate.build(:section, teacher: teacher, course: course)
        course.sections << s
        teacher.sections << s
      }
    end
  }
end

Fabricator :course_full_year, from: :course do
  duration      Durations::FULL_YEAR
  credits       5.0
end

Fabricator :course_first_semester, from: :course do
  duration      Durations::FIRST_SEMESTER
  credits       2.5
end

Fabricator :course_second_semester, from: :course do
  duration      Durations::SECOND_SEMESTER
  credits       2.5
end

Fabricator :course_half_time, from: :course do
  duration      Durations::FULL_YEAR_HALF_TIME
  credits       2.5
end

