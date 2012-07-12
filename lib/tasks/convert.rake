require 'xmlsimple'

def dump_records(klass)
	path = File.join(File.join(Rails.root, 'new_data'), "#{klass.to_s.tableize}.xml")
	res = klass.all.to_xml
	begin
		file = File.open(path, "w")
		file.write(res)
	rescue Exception
		STDERR.puts "export_to_xml failed, #{$!}"
	ensure
		file.close()
	end
end

namespace :db do
	desc 'load all records from xml'
	task :load => :environment do
		for k in [Import::Occurrence, Import::Teachers, Import::Course, Import::Section, 
										Import::Assignment, Import::SectionAssignment] do
			k.load_from_data
		end
	end
end

namespace :occurrences do
	desc 'Import teachers'
	task :import => :environment do
		Import::Occurrence.import_and_create
	end
	desc "Export teachers"
	task :export => :environment do
		Import::Occurrence.export_to_xml
	end
	desc "Load teachers"
	task :load => :environment do
		Import::Occurrence.load_from_data
	end
	task :dump => :environment do
		dump_records(Occurrence)
	end
	task :ld => [:load, :dump]
	task :all => [:import, :export, :load, :dump]
end

desc 'import'
namespace :teachers do
	desc 'Import teachers'
	task :import => :environment do
		Import::Teacher.import_and_create
	end
	desc "Export teachers"
	task :export => :environment do
		Import::Teacher.export_to_xml
	end
	desc "Load teachers"
	task :load => :environment do
		Import::Teacher.load_from_data
	end
	task :dump => :environment do
		dump_records(Teacher)
	end
	task :ld => [:load, :dump]
	task :all => [:import, :export, :load, :dump]
end

namespace :courses do
	desc 'Import courses'
	task :import => :environment do
		Import::Course.import_and_create
	end
	desc "Export courses"
	task :export => :environment do
		Import::Course.export_to_xml
	end
	desc "Load teachers"
	task :load => :environment do
		Import::Course.load_from_data
	end
	task :dump => :environment do
		dump_records(Course)
	end
	task :ld => [:load, :dump]
	task :all => [:import, :export, :load, :dump]
end

namespace :sections do
	desc 'Import sections'
	task :import => :environment do
		Import::Section.import_and_create
	end
	desc "Export sections"
	task :export => :environment do
		Import::Section.export_to_xml
	end
	
	desc "Load sections"
	task :load => :environment do
		Import::Section.load_from_data
	end
	task :dump => :environment do
		dump_records(Section)
	end
	task :ld => [:load, :dump]
	task :all => [:import, :export, :load, :dump]
end

namespace :assignments do
	desc 'Import assignments'
	task :import => :environment do
		Import::Assignment.import_and_create
	end
	desc "Export assignments"
	task :export => :environment do
		Import::Assignment.export_to_xml
	end
	desc "Load assignments"
	task :load => :environment do
		Import::Assignment.load_from_data
	end
	task :dump => [:load, :environment] do
		dump_records(Assignment)
	end
	task :ld => [:load, :dump]
	task :all => [:import, :export, :load, :dump]
end

namespace :sas do
	desc 'Import section_assignments'
	task :import => :environment do
		Import::SectionAssignment.import_and_create
	end
	desc "Export section_assignments"
	task :export => :environment do
		Import::SectionAssignment.export_to_xml
	end
	desc "Load section_assignments"
	task :load => :environment do
		Import::SectionAssignment.load_from_data
	end
	task :dump => :environment do
		dump_records(SectionAssignment)
	end
	task :ld => [:load, :dump]
	task :all => [:import, :export, :load, :dump]
end

namespace :tags do
	task :dump => :environment do
		dump_records(Tag)
	end
end

	

