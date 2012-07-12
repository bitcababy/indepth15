namespace :db do
	task :convert => :environment do
		[Occurrence, Teacher, Course, Section, Assignment, SectionAssignment].each do |klass|
			arr = Convert.import_old_file "#{klass.to_s.tableize}.xml"
			Convert.from_hashes klass, arr
		end
	end
end
			
