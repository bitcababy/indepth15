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
	current									true
	authentication_token		'teacher'
	general_msg							"This is the general leadin"
	current_msg							"This is the current leadin"
	upcoming_msg						"This is the current leadin"
  assignments             []
  courses                 []
  sections                []
end

Fabricator :test_teacher, from: :teacher, class_name: :teacher do
	email										"teacher@example.com"
	login										'test_teacher'
	authentication_token		'test_teacher'
end

Fabricator :test_admin, from: :user, class_name: :admin  do
	login							    'test_admin'
	authentication_token	'test_admin'
	authentication_token	"admin"
end

Fabrication::Transform.define(:teacher, lambda { |formal_name|
		h,l = formal_name.split(' ')
		cond = {honorific: h.strip, last_name: l.strip}
		if Teacher.where(cond).exists?
			Teacher.find_by(cond)
		else
			Fabricate(:teacher, honorific: h, last_name: l)
		end
	})

Fabrication::Transform.define(:author, lambda{|full_name|
	name = full_name.split(" ")
	if Author.where(first_name: name[0], last_name: name[1]).exists? then
		Author.find_by(first_name: name[0], last_name: name[1])
	else
		Fabricate(:author, first_name: name[0], last_name: name[1])
	end
})
