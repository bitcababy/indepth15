class Menu < MenuItem
	field :mc, as: :menu_class, type: String, default: "sub-menu"
	
	embedded_in :menu_set
	
	def self.for_home
		menu = self.create! label: 'Home', link: 'home', item_class: 'home'
		menu.child_menu_items.create! label: 'Sign in', link: 'sign_in', controller: 'devise/sections', action: :new
		menu.child_menu_items.create! label: 'About', link: 'about'
		return menu
	end
	
	def self.for_courses
		menu = self.create! label: 'Courses', link: 'courses', item_class: 'courses'
		Course.in_catalog.where(academic_year: Settings.academic_year).each do |course|
			submenu = Menu.create! object: course
			for section in course.sections do
				submenu.child_menu_items.create! object: section
			end
			menu.child_menu_items << submenu
		end
		menu.save!

		return menu
	end
	
	def self.for_teachers
		menu = self.create! label: 'Teachers', link: 'teachers', controller: :teachers, action: :index, item_class: 'Teachers'
		Teacher.where(current: true).asc(:last_name).asc(:first_name).each do |teacher|
			submenu = Menu.create! label: teacher.menu_label
			submenu.child_menu_items.create! object: teacher
			menu.child_menu_items << submenu
		end
		return menu
	end
		
		

end
