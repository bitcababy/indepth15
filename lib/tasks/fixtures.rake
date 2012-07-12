def export(klass)
	path = File.join(Rails.root, 'spec', 'fixtures', "#{klass.to_s.tableize}.yml")
	res = klass.all.to_yaml
	begin
		file = File.open(path, "w")
		file.write(res)
	rescue Exception
		STDERR.puts "exporting to yaml failed, #{$!}"
	ensure
		file.close()
	end
end

namespace :yaml do
	desc 'export teachers to fixtures'
	task :teachers => :environment do
		export(Teacher)
	end
	desc 'export courses to fixtures'
	task :courses => :environment do
		export(Course)
	end
	desc 'export courses to fixtures'
	task :sections => :environment do
		export(Section)
	end

end
