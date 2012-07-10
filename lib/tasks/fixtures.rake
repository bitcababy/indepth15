# def export(klass)
# 	path = File.join(Rails.root, 'spec', 'fixtures', "#{klass.to_s.tableize}.xml")
# 	res = klass.all.to_xml
# 	begin
# 		file = File.open(path, "w")
# 		file.write(res)
# 	rescue Exception
# 		STDERR.puts "export_to_xml failed, #{$!}"
# 	ensure
# 		file.close()
# 	end
# end
# 
# namespace :db do
# 	namespace :export do
# 		desc 'export teachers to fixtures'
# 		task :teachers => :environment do
# 			export(Teacher)
# 		end
# 		desc 'export courses to fixtures'
# 		task :courses => :environment do
# 			export(Course)
# 		end
# 		desc 'export courses to fixtures'
# 		task :sections => :environment do
# 			export(Section)
# 		end
# 
# 	end
# end
