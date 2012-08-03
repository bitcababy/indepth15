Then /^I should see a menubar with these menus(?::)$/ do |table|
  page.should have_selector('ul#menubar')
	menubar = page.find('ul#menubar')
	for hash in table.hashes do 
		menubar.should have_selector('li', text: hash['name'])
	end
end
