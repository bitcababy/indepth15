class Import::Teacher < Import
	cattr_reader :convert_class, :mapping, :skip
	
	@@mapping = {
		"id" 					=> :orig_id,
		"last_name" 	=> :last_name,
		'first_name' 	=> :first_name,
		'teacher_id' 	=> :login,
		'title' 			=> :honorific,
		'phrase' 			=> :phrase,
		'photo_URL' => :photo_url,
		'personal_hp_URL' => :home_page,
		'generic_assgts_msg' => :generic_msg,
		'upcoming_assgts_msg' => :upcoming_msg,
		'current' => :old_current,
		'default_room' => :default_room,
	}
end
