class Import::Course  < Import
	cattr_reader :convert_class, :mapping, :skip
	validates_uniqueness_of :number
	
	@@mapping = {
		"id" 							=> :orig_id,
		'course_num' 			=> :number,
		'name' 						=> :short_name,
		'logo_URL' 				=> :logo_url,
		'has_assgts' 			=> :has_assignments,
		'duration' 				=> :duration,
		'credits' 				=> :credits,
		'full_name' 			=> :full_name,
		'short_name' 			=> :short_name,
		'schedule_name' 	=> :schedule_name,
		'in_catalog' 			=> :in_catalog,
		'occurrences' 		=> :occurrences,
		'has_assignments' => :has_assignments,
		'info' 						=> :info,
		'resources' 			=> :resources,
		'semesters' 			=> :semesters,
		'policies' 				=> :policies,
		'prog_of_studies_descr' => :prog_of_studies_descr,
		}
	
end
