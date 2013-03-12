Fabricator(:course) do
  transient       :num_sections
  transient       :teacher
	number					{ sequence(:course_number, 42) }
	duration				{ Course::DURATIONS.sample }
	credits					{ Settings.credits.sample }
	full_name				{ |attrs| "Course #{attrs[:number]}" }
  sections        []
  teachers        []
  department
  occurrences     (1..5).to_a
  after_create     { |course, t|
    if (n = t[:num_sections])
      teacher = t[:teacher] || Fabricate(:teacher)
      n.times { course.sections << Fabricate(:section, teacher: teacher) } 
    end
  }
end

Fabricator :course_full_year, from: :course do
  duration      Course::FULL_YEAR
  credits       5.0
end

Fabricator :course_first_semester, from: :course do
  duration      Course::FIRST_SEMESTER
  credits       2.5
end

Fabricator :course_second_semester, from: :course do
  duration      Course::SECOND_SEMESTER
  credits       2.5
end

Fabricator :course_half_time, from: :course do
  duration      Course::FULL_YEAR_HALF_TIME
  credits       2.5
end

