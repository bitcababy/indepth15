require 'mysql'

module Bridge
	SERVER = (Rails.env == 'production') ? 'http://www.westonmath.org' : 'http://0.0.0.0:3000'
	
	class << self
		def connector
			return Mysql.connect "db1.xoala.net", 'whswriter', 'hyperbole', ((Rails.env == 'production')  ? 'whsmd' : 'whsmd_testing'), 3306, "/var/run/mysqld/mysqld.sock"
		end
		
		def create_or_update_assignment(assgt_id)
			res = ""
			if conn = connector
				begin 
					conn.query("SELECT assgt_id, teacher_id, content FROM assignments WHERE assgt_id=#{assgt_id}").each_hash do |hash|
						if Assignment.where(assgt_id: assgt_id).exists?
							asst = Assignment.find_by(assgt_id: assgt_id)
							asst.content = hash['content']
							asst.save!
						else
							Assignment.create! hash
						end
						conn.query("UPDATE assgts_status SET sent=1 WHERE assgt_id=#{assgt_id}")
						res += <<EOT
	<assgt_id>#{assgt_id}</assgt_id>
EOT
					end
				ensure
					conn.close
				end
				return res
			end
		end
				
		def create_or_update_assignments
			res = ""
			if conn = connector
				begin
					conn.query("SELECT assgt_id FROM assgts_status WHERE sent=0").each do |rec|
						res += create_or_update_assignment(rec[0].to_i)
					end
				ensure
					conn.close
				end
			end

			return res
		end
		
		def create_or_update_sa(hash)
			res = ""
			if conn = connector
				begin
					section = Section.find_by course_id: hash['course_num'].to_i, teacher_id: hash['teacher_id'], block: hash['block']
					raise "Missing section #{hash}" unless section
					adid = hash['id']
					conn.query("SELECT due_date, assgt_id, use_assgt FROM section_assignments WHERE id=#{adid}").each_hash do |hash2|
						hash['use'] = hash.delete('use_assgt') == 'Y'
						raise "assignment #{hash['assgt_id']} doesn't exist" unless Assignment.where(assgt_id: hash['assgt_id'].to_i).exists?

						if section.section_assignments.where(assgt_id: hash2['assgt_id']).exists?
							sa = section.section_assignments.find_by(assgt_id: hash2['assgt_id'])
							sa.update_attributes hash2
							sa.save!
						else
							section.add_assignment(hash2['name'], hash2['assgt_id'], hash2['use'])
						end
						conn.query("UPDATE assgt_dates_status SET sent=1 WHERE id=#{adid}")
						res += <<EOT
	<assgt_date>#{adid}</assgt_date>
EOT
					end
				ensure
					conn.close
				end
			end
			return res
		end

		def create_or_update_sas
			res = ""
			if conn = connector
				begin
					conn.query("SELECT assgt_dates.id, assgt_id,course_num,teacher_id,block FROM assgt_dates,assgt_dates_status WHERE assgt_dates.id=assgt_dates_status.id").each_hash do |hash|
						res += create_or_update_sa(hash)
					end
				ensure
					conn.close
				end
			end
			return res
		end

	end
	
end
