require 'spec_helper'

describe Menu do
	describe '.top_level' do
		it "returns a list of the top-level menus" do
			menus = Menu.top_level
			menus.should be_kind_of Array
			for menu in menus do
				menu.should be_kind_of Menu
			end
		end
	end
	describe '.for_home' do
		subject { Menu.for_home }
		it { should be_kind_of Menu }
		specify { subject.label.should == 'Home' }
		it { should have(2).child_menu_items }
	end
	
	describe '.for_courses' do
		include CourseHelper

		before :each do
			@course1 = Fabricate :course, full_name: 'Math 101', in_catalog: true
			@course2 = Fabricate :course, full_name: 'Fractals', in_catalog: true
			Course.count.should == 2
			Course.in_catalog.count.should == 2
			3.times { Fabricate :section, course: @course1 }
			2.times { Fabricate :section, course: @course2 }
		end
		
		subject { Menu.for_courses }
		it { should be_kind_of Menu }
		it { should have(2).child_menu_items }
		
		it "should have a submenu for 'Math 101'" do
			submenu = subject.child_menu_items[0]
			submenu.menu_label.should == 'Math 101'
			submenu.child_menu_items.count.should == 3
		end
		
		it "should have a submenu for 'Fractals" do
			submenu = subject.child_menu_items[1]
			submenu.menu_label.should == 'Fractals'
			submenu.child_menu_items.count.should == 2
		end

	end
			
	describe '.for_teachers' do
		before :each do
			3.times { Fabricate :teacher }
		end
		subject { Menu.for_teachers }
		it { should have(3).child_menu_items }

		it "should have a submenu for each teacher that has a link to the teacher's home page" do
			subject.child_menu_items.each do |submenu|
				item = submenu.child_menu_items.first
					item.object.should be_kind_of Teacher
				item.menu_label.should == item.object.menu_label
			end
		end
				
				
		
	end
	
	describe '.for_admins'
		
		
end
