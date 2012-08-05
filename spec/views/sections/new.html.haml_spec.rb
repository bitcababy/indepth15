require 'spec_helper'

describe "sections/new" do
	before(:each) do
		assign(:section, section = Section.new room: "5")
	end

	it "renders new section form" do
		render
		rendered.should have_selector('form.new_section', action: sections_path, method: 'post') do |form|
			form.should have_selector('div.form-inputs') do |inputs|
				# Block radio buttons
				inputs.should have_selector('div#blocks') do
					Settings.blocks.each do |block|
						inputs.should have_selector('input', type: 'radio', value: block)
					end
				end
				pending "Unfinished test"
				
			end
		end
		pending "Unfinished test"
	end
end
