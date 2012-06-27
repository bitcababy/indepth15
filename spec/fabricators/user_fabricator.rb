Fabricator(:user) do
end

Fabricator(:registered_user, parent: :user) do
	honorific				{ %W(Mr. Mrs. Ms. Dr.).sample }
	first_name			{ %W(John Jane Jake Dan Larry).sample }
	last_name				{ %W(Black White Orange Red).sample }
end

Fabricator(:teacher, parent: :registered_user) do
	honorific				{ %W(Mr. Mrs. Ms. Dr.).sample }
	first_name			{ %W(John Jane Jake Dan Larry).sample }
	last_name				{ %W(Black White Orange Red).sample }
	general_leadin	"This is the general leadin"
	current_leadin	"This is the current leadin"
	current					true
end
