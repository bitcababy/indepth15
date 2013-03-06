Fabricator :assignment, from: :document, class_name: :assignment  do
  name                "The name"
	content							"Some content"
  major_topics        SortedSet.new
	section_assignments []
  teacher
  course
  after_create        {|obj|
    if course
      course.assignments << obj
      course.save
    end
    if teacher
      teacher.assignments << obj
      teacher.save
    end
  }
end
