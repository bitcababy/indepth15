require 'xmlsimple'

module Convert
	MAPPINGS = {
		Occurrence => 	{
			'block_name' => :block,
			'occurrence' => :number,
			'day_num' => :day,
			'period' => :period,
		},
		Teacher => {
			"last_name" 			=> :last_name,
			'first_name' 			=> :first_name,
			'teacher_id' 			=> :login,
			'title' 					=> :honorific,
			'phrase' 					=> :phrase,
			'photo_URL' 			=> :photo_url,
			'personal_hp_URL' => :home_page,
			'generic_assgts_msg' => :generic_msg,
			'upcoming_assgts_msg' => :upcoming_msg,
			'current' 				=> :old_current,
			'default_room' 		=> :default_room,
		},
		Assignment => {
			"assgt_id" 							=> :assgt_id,
			"teacher_id"						=> :teacher_id,
			"description"						=> :description,
			"kind"									=> :kind,
			"year"									=> :year,
			"name"									=> :name,
			},
		Course => 	{
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
				'prog_of_studies_descr' => :description,
				},
		Section => {
				"section_num" => :number,
				"block" => :block,
				"days" => :days,
				"room" => :room,
				"semester" => :semesters,
				"which_occurrences" => :which_occurrences,
				"dept_id" => :dept_id,
				"course_num" => :course_num,
				"year" => :year,
				"room" => :room,
				"teacher_id" => :teacher_id,
			},
		SectionAssignment => {
			"assgt_id" 				=> :assgt_id,
			"teacher_id" 			=> :teacher_id,
			"block" 					=> :block,
			"use_assgt" 			=> :use_assgt,
			"schoolyear" 			=> :schoolyear,
			"date_due" 				=> :due_date,
			"course_num" 			=> :course_num,
			"deleted" 				=> :deleted,
		},
	}
	CONVERSIONS = {
		/^\d+$/ => lambda{|s| s.to_i},
		/^null$/ => nil,
		/^NULL$/ => nil,
		/^true$/ => true,
		/^false$/ => false,
	}
	
	class << self

		def import_old_file(name)
			path = File.join(File.join(Rails.root, 'old_data'), name)
			imported = ::XmlSimple.xml_in(path,
					'KeyToSymbol' => true,
					'GroupTags' => {
					},
					# :conversions => @conversions,
					"KeyAttr" => ['database'],
					'ForceArray' => false,
			)
			imported[:database][:table].collect {|h| h[:column]}
		end
		
		def one_record(klass, arr)
			map = MAPPINGS[klass]
			hash = arr.inject({}) do |memo, pair|
				k = pair['name']
				v = pair[:content]

				if map[k] then
					k = map[k] || k
					v = pair[:content]
					if v then
						memo[k] = case 
						when v =~ /^\d+$/
							v.to_i
						when v == "NULL"
							nil
						when v == "false"
							false
						when v == "true"
							false
						else
							v
						end
					end
				end
				memo
			end
			klass.import_from_hash(hash)
		end

		def from_hashes(klass, arr)
			klass.delete_all
			arr.each {|a| one_record(klass, a)}
			puts klass.count
			arr
		end
	end
	
end
