Fabricator(:course) do
	number					{ sequence(:number, 42) }
	duration				{ Course::DURATIONS.sample }
	credits					5.0
	full_name				{ |attrs| "Course #{attrs[:number]}"}
  occurrences     (1..5).to_a
  department
  after_build     {|c|
    # c.sections.clear
    # c.teachers.clear
    # c.major_topics.clear
    # c.assignments.clear
  }
end
