Fabricator(:user) do
	honorific								{ %W(Mr. Mrs. Ms. Dr.).sample }
	first_name							{ %W(John Jane Jake Dan Larry).sample }
	last_name								{ %W(Black White Orange Red).sample }
	authentication_token		"user"
	after_build						{ |obj|
		obj.login ||= (obj.last_name + obj.first_name.first).downcase
		obj.email ||= obj.login + "@example.com"
		}
end

Fabricator :author, from: :user, class_name: 'Author' do
	authentication_token		'author'
end

Fabrication::Transform.define(:author, lambda{|full_name|
	name = full_name.split(" ")
	if Author.where(first_name: name[0], last_name: name[1]).exists? then
		Author.find_by(first_name: name[0], last_name: name[1])
	else
		Fabricate(:author, first_name: name[0], last_name: name[1])
	end
})

Fabricator :guest, from: :user  do
end

Fabricator :teacher, from: :author, class_name: 'Teacher' do
	current									true
	authentication_token		'teacher'
	sections								[]
end

Fabrication::Transform.define(:teacher, lambda{|full_name|
	name = full_name.split(" ")
	if Teacher.where(first_name: name[0], last_name: name[1]).exists? then
		Teacher.find_by(first_name: name[0], last_name: name[1])
	else
		Fabricate(:teacher, first_name: name[0], last_name: name[1])
	end
})

Fabrication::Transform.define :general_msg, lambda{|txt| Fabricate :teacher_page, content: txt}
Fabrication::Transform.define :current_msg, lambda{|txt| Fabricate :teacher_page , content: txt}
	
Fabricator :test_teacher, from: :teacher do
	honorific					"Mr."
	first_name				"John"
	last_name					"Doe"
	email							"teacher@example.com"
	authentication_token	'test_teacher'
	general_leadin		"This is the general leadin"
	current_leadin		"This is the current leadin"
end

Fabricator :test_admin, from: :author  do
	honorific					{ %W(Mr. Mrs. Ms. Dr.).sample }
	first_name				{ %W(John Jane Jake Dan Larry).sample }
	last_name					{ %W(Black White Orange Red).sample }
	current						true
	authentication_token	'admin'
end

