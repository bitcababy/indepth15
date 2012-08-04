namespace :heroku do
	task :push => :environment do
		sh 'git push heroku mer.master'
	end
end
