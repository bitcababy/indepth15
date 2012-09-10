class ImportJob
	def import_new_stuff
		Bridge.create_or_update_assignments
		Bridge.create_or_update_sas
	end
	
	handle_asynchronously :import_new_stuff
end


	