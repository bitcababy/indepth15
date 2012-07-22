require 'spec_helper'

describe MenuSet do
  it { should embed_many :menus }
	
	describe '::build_menubar' do
		it "creates the main menus" do
			set = MenuSet.build_menubar
			set.should be_kind_of MenuSet
			set.menus.each {|menu| menu.should be_kind_of Menu}
			MenuSet.all_menus.should_not be_nil
		end
	end

end
