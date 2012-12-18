require 'xmlsimple'
require 'import_methods'

module Convert
	MAPPINGS = {
    Occurrence =>   {
      'block_name' => :block,
      'occurrence' => :number,
      'day_num' => :day,
      'period' => :period,
    },
		Department => {
			'dept_id' => :name,
			'objectives' => :objectives,
			'how_to_use' => :how_to_use,
			'news'	=> :news,
			'resources' => :resources,
			'puzzle' => :puzzle,
			'why' => :why,
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
			"content"								=> :content,
			},
		Course => 	{
				'number' 					=> :number,
				'has_assgts' 			=> :has_assignments,
				'duration' 				=> :duration,
				'credits' 				=> :credits,
				'full_name' 			=> :full_name,
				'short_name' 			=> :short_name,
				'schedule_name' 	=> :schedule_name,
				'in_catalog' 			=> :in_catalog,
				'occurrences' 		=> :occurrences,
				'has_assignments' => :has_assignments,
				'info' 						=> :information,
				'resources' 			=> :resources,
				'semesters' 			=> :semesters,
				'policies' 				=> :policies,
				'prog_of_studies_descr' => :description,
				},
		Section => {
				"dept_id" => :dept_id,
				"course_num" => :course_num,
				"semester" => :semesters,
				"block" => :block,
				"year" => :year,
				"room" => :room,
				"which_occurrences" => :which_occurrences,
				"teacher_id" => :teacher_id,
			},
		SectionAssignment => {
			"id"							=> :old_id,
			"teacher_id" 			=> :teacher_id,
			"year" 						=> :year,
			"course_num" 			=> :course_num,
			"block" 					=> :block,
			"assgt_id" 				=> :assgt_id,
			"use_assgt" 			=> :use,
			"due_date" 				=> :due_date,
			"name"						=> :name
		},
	}

	CONVERSIONS = {
		/^\d+$/ => lambda{|s| s.to_i},
		/^null$/ => nil,
		/^NULL$/ => nil,
		/^true$/ => true,
		/^false$/ => false,
	}
	
	def self.import_xml_file(name, dir='old_data')
		path = File.join(File.join(Rails.root, dir), name)
		imported = ::XmlSimple.xml_in(path,
				'KeyToSymbol' => true,
				'GroupTags' => {
				},
				# :conversions => @conversions,
				"KeyAttr" => ['database'],
				'ForceArray' => false,
		)
    unless imported[:database][:table].kind_of? Array
      imported[:database][:table] = [imported[:database][:table]]
    end
    # if imported[:database][:table].kind_of?(Array) && imported[:database][:table].keys.include? :column
    #   imported[:database][:table] = [imported[:database][:table]]
    # end
		imported[:database][:table].collect {|h| h[:column]}
	end
	
		
	def self.one_record(klass, arr)
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
		begin
			klass.import_from_hash(hash)
		rescue ArgumentError => msg
			print msg
		end
	end

	def self.from_hashes(klass, arr, delete = true)
		klass.delete_all if delete
		arr.each {|a| one_record(klass, a)}
		puts klass.count
		arr
	end
	
end
