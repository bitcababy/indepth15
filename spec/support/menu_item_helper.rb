module MenuItemHelper
	def item_with_link(opts={})
		opts.merge!({label: "Google", link: 'http://google.com' })
		Fabricate :menu_item, opts
	end
	
	def item_with_controller(opts={})
		opts.merge!({label: "Courses", controller: 'courses', action: 'index'})
		Fabricate :menu_item, opts
	end
	
	def item_with_object(opts)
		opts.merge!({label: "Item"})
		Fabricate :menu_item, opts
	end
	
	def simple_menu(opts={})
		opts.merge!({menu_label: "Menu", children: 3})
		menu = Fabricate :menu_with_label, opts
		opts[:children].times {|i| menu.child_menu_items << Fabricate(:menu_item_with_link)}
		return menu
	end
	

end
