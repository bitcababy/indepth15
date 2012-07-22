class MenuSet
  include Mongoid::Document
	field :name, type: Symbol
	
	MENUBAR = :menubar
	
	embeds_many :menus
	
	cattr_reader :all_menus

	class << self
		@all_menus = nil

		def build_menubar
			mset = self.create! name: MENUBAR
			mset.menus << Menu.for_home
			mset.menus << Menu.for_courses
			mset.menus << Menu.for_teachers
			mset.save!
			@all_menus = mset
			return mset
		end
	
		def all_menus
			@all_menus ||= self.build_menubar
		end
	end
		
end
