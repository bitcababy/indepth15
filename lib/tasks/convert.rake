CLASSES = %W[department occurrence teacher course section assignment section_assignment]

namespace :convert do
	CLASSES.each do |klass|
    task klass.downcase.pluralize.intern => :environment do
      require Rails.root.join('import/convert')
      puts "Converting #{klass}"
  		arr = Convert.import_xml_file "#{klass.tableize}.xml"
  		Convert.from_hashes klass.camelize.constantize, arr
    end
  end
  
  task :sas => :environment do
    require Rails.root.join('import/convert')
      arr = Convert.import_xml_file "section_assignments.xml"
      Convert.from_hashes SectionAssignment, arr
  end

	task :all => CLASSES.collect {|c| c.downcase.pluralize.intern } 
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


namespace :add_2011 do	
  # task :courses => :environment do
  #     require Rails.root.join('import/convert')
  #   arr = Convert.import_xml_file "2011_sections.xml", 'updates'
  #   Convert.from_hashes Course, arr, false
  # end
  # 
  # task :assignments => :environment do
  #     require Rails.root.join('import/convert')
  #   arr = Convert.import_xml_file "2011_assignments.xml", 'updates'
  #   Convert.from_hashes Assignment, arr, false
  #   # path = File.join(File.join(Rails.root, 'updates'), 'updated_assignments.xml')
  #   # puts path
  # end
  # 
	task :sas => :environment do
    require Rails.root.join('import/convert')
		arr = Convert.import_xml_file "2011_sas.xml"
		Convert.from_hashes SectionAssignment, arr, false
	end
	
	task :all => [:sections, :assignments, :sas]
	
end


task :default do
end
