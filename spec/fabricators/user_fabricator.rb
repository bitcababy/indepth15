Fabricator :user do
	honorific								{ %W(Mr. Mrs. Ms Dr.).sample }
	first_name							{ %W(John Jane Jake Dan Larry).sample }
	last_name								{ %W(Black White Orange Purple).sample }
	authentication_token		"user"
	login										nil
	email										nil
	suffix									{ sequence }
  encrypted_password      "password"
	# role									{Fabricate :role, name: :registered_user}
	after_build							{ |obj|
		obj.login ||= (obj.last_name + obj.first_name.first).downcase + obj.suffix.to_s
		obj.email ||= obj.login + "@example.com"
		}
end

# Fabricate.sequence :first_name, {|i| }

Fabricator :author, from: :user, class_name: :author do
	# role										{Fabricate :role, name: :author}
	authentication_token		'author'
end

Fabricator :guest, from: :user  do
	# role										{Fabricate :role, name: :guest}
end

Fabricator :teacher, from: :user, class_name: :teacher do
	current									true
	authentication_token		'teacher'
	general_msg							"This is the general leadin"
	current_msg							"This is the current leadin"
	upcoming_msg						"This is the current leadin"
end

Fabrication::Transform.define(:teacher, lambda{|full_name|
	name = full_name.split(" ")
	if Teacher.where(first_name: name[0], last_name: name[1]).exists? then
		Teacher.find_by(first_name: name[0], last_name: name[1])
	else
		Fabricate(:teacher, first_name: name[0], last_name: name[1])
	end
})

Fabricator :test_teacher, from: :teacher, class_name: :teacher do
	email										"teacher@example.com"
	login										'test_teacher'
	authentication_token		'test_teacher'
end

Fabricator :test_admin, from: :user, class_name: :admin  do
	honorific					{ %W(Mr. Mrs. Ms. Dr.).sample }
	first_name				{ %W(John Jane Jake Dan Larry).sample }
	last_name					{ %W(Black White Orange Red).sample }
	current						true
	login							'test_admin'
	authentication_token	'test_admin'
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



