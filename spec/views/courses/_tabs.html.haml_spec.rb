require 'spec_helper'

describe 'course/_tabs' do
	it "shows various tabs" do
		course = mock do
			stubs(:full_name).returns "Fractals 101"
		end
		render partial: 'courses/tabs', locals: {course: course}
		for tab_name in %W(Sections Information Resources Policies News) do
			rendered.should have_selector('li', id: tab_name.downcase) do |li|
				li.should have_selector('a', title: tab_name, content: tab_name)
			end
		end
	end
end
