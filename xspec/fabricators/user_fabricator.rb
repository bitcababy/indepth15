Fabricator :user do
	honorific								{ %W(Mr. Mrs. Ms Dr.).sample }
	first_name							{ %W(John Jane Jake Dan Larry).sample }
	last_name								{ "jones" + sequence(1).to_s }
	authentication_token		"user"
	login										{ |attrs| attrs[:last_name] + attrs[:first_name][0] unless attrs[:login]}
	email										{ |attrs| attrs[:login] + "@example.com"}
  password                'secret'
end


Fabricator :teacher, from: :user, class_name: :teacher do
  transient               :section_count
  transient               :courses
  transient               :dept
	current									true
	authentication_token		'teacher'
	general_msg							"This is the general leadin"
	current_msg							"This is the current leadin"
  assignments             []
  sections                []
  departments             []
  after_build             { |teacher, t| 
    if (n = t[:section_count])
      courses = (t[:courses] || Fabricate(:course)).to_a
      n.times { Fabricate :section, course: courses.sample, teacher: teacher } 
    end
    teacher.departments << t[:dept] if t[:dept]
  }
end

Fabricator :test_teacher, from: :teacher, class_name: :teacher do
	email										"teacher@example.com"
	login										'test_teacher'
	authentication_token		'test_teacher'
end
