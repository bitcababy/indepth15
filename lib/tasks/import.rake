task :import => :environment do
	Bridge.create_or_update_assignments
	Bridge.create_or_update_sas
end
