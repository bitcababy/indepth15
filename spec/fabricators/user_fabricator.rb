Fabricator(:user) do
	honorific					{ %W(Mr. Mrs. Ms. Dr.).sample }
	first_name				{ %W(John Jane Jake Dan Larry).sample }
	last_name					{ %W(Black White Orange Red).sample }
	login							{ |attrs| attrs['last_name'].downcase + attrs['first_name'].first }
	email							{ |attrs| attrs['login'] + 'example.com' }
	password					'password'
end

Fabricator(:registered_user) do
	honorific					{ %W(Mr. Mrs. Ms. Dr.).sample }
	first_name				{ %W(John Jane Jake Dan Larry).sample }
	last_name					{ %W(Black White Orange Red).sample }
	login							{ |attrs| attrs['last_name'].downcase + attrs['first_name'].firsts }
	email							{ |attrs| attrs['login'] + 'example.com' }
	password					'password'
	authentication_token		'user'
end

Fabrication::Transform.define(:user, lambda{|full_name|
	name = full_name.split(" ")
	if User.where(first_name: name[0], last_name: name[1]).exists? then
		User.find_by(first_name: name[0], last_name: name[1])
	else
		Fabricate(:user, first_name: name[0], last_name: name[1])
	end
})

Fabricator(:guest, from: :user) do
end

Fabricator :teacher, from: :registered_user do
	current						true
	general_msg				"This is the general leadin"
	current_msg				"This is the urrent leadin"
	authentication_token	'teacher'
	sections					[]
	generic_msg_doc		{|attrs| Fabricate(:teacher_page, content: attrs['general_msg'])}
	current_msg_doc		{|attrs| Fabricate(:teacher_page, content: attrs['current_msg'])}
end

Fabrication::Transform.define(:teacher, lambda{|full_name|
	name = full_name.split(" ")
	if Teacher.where(first_name: name[0], last_name: name[1]).exists? then
		Teacher.find_by(first_name: name[0], last_name: name[1])
	else
		Fabricate(:teacher, first_name: name[0], last_name: name[1])
	end
})

Fabricator :test_teacher, from: :teacher do
	honorific					"Mr."
	first_name				"John"
	last_name					"Doe"
	email							"teacher@example.com"
	authentication_token	'test_teacher'
end

Fabricator :test_admin, from: :user  do
	honorific					{ %W(Mr. Mrs. Ms. Dr.).sample }
	first_name				{ %W(John Jane Jake Dan Larry).sample }
	last_name					{ %W(Black White Orange Red).sample }
	current						true
	general_leadin		"This is the general leadin"
	current_leadin		"This is the current leadin"
	after_build				{ |user| user.login = user.last_name.downcase + user.first_name.downcase.first}
	after_build				{ |user| user.email = user.login + 'example.com'}
	after_build				{ |user| user.password = "password" }
	authentication_token	'admin'
end

