
namespace :convert do
	task :data => :environment do
    require Rails.root.join('import/convert')
    Branch.delete_all
    Branch.create_all
    Document.delete_all
	  Mongoid.unit_of_work(disable: :all) do
			[Department, Occurrence, Teacher, Course, Section, Assignment, SectionAssignment].each do |klass|
        puts "Converting #{klass.to_s}"
				arr = Convert.import_xml_file "#{klass.to_s.tableize}.xml"
				Convert.from_hashes klass, arr
			end
		end
	end
end

namespace :update do
	task :assignments => :environment do
    require Rails.root.join('import/convert')
		arr = Convert.import_xml_file "updated_assignments.xml", 'updates'
		Convert.from_hashes Assignment, arr, false
		# path = File.join(File.join(Rails.root, 'updates'), 'updated_assignments.xml')
		# puts path
	end
	
	task :sas => :environment do
    require Rails.root.join('import/convert')
		arr = Convert.import_xml_file "updated_sas.xml", 'updates'
		Convert.from_hashes SectionAssignment, arr, false
	end

	task :courses => :environment do
    require Rails.root.join('import/convert')
		arr = Convert.import_xml_file "updated_courses.xml", 'updates'
		Convert.from_hashes Course, arr, false
	end
	
	task :all => [:assignments, :sas]
	
end

task :default do
end
