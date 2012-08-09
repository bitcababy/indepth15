task :convert => :environment do
  Mongoid.unit_of_work(disable: :all) do
		[Occurrence, Teacher, Course, Section, Assignment, SectionAssignment].each do |klass|
			arr = Convert.import_old_file "#{klass.to_s.tableize}.xml"
			Convert.from_hashes klass, arr
		end
	end
end
