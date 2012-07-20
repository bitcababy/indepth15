Fabricator :menu_item do
	label					nil
	object				nil
	item_id				''
	item_class		''
end

Fabricator :menu, from: :menu_item do
	label					nil
	menu_class		'sub-menu'
end

Fabricator :menu_item_with_link, from: :menu_item do
	label					{ sequence(:menu_item) {|i| "Item #{i}"} }
	link					{ sequence(:link) {|i| "http://foo#{i},example.com"} }
end

Fabricator :menu_with_label, from: :menu do
	label					{ sequence(:menu) {|i| "Menu #{i}"} }
end
