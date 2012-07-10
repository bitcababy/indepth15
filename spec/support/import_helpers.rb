module ImportHelpers

	FILE_MAP = {
		'teachers' => Import::Teacher,
		'course_info' => Import::Course,
		'master_schedule' => Import::Section,
		'assgts' => Import::Assignment,
		'assgt_dates' => Import::SectionAssignment
	}
	
	def import_and_create(file)
		klass = FILE_MAP[file]
		klass.mapping.should_not be_nil
		arr = klass.import_file("#{file}.xml")
		klass.create_imported_records(arr)
		return klass
	end

	def import_and_convert(file)
		klass = import_and_create(file)
		klass.convert_class.should_not be_nil
		klass.convert_all
	end

end
