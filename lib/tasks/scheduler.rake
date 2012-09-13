desc "This task is called by the Heroku scheduler add-on"
task :import => :environment do
	Bridge.create_or_update_assignments
	Bridge.create_or_update_sas
end
