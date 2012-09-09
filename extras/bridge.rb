require 'mysql'

module Bridge
	SERVER = (Rails.env == 'production') ? 'http://www.westonmath.org' : 'http://0.0.0.0:3000'
	
	class << self
		def connector
			return Mysql.connect "db1.xoala.net", 'whswriter', 'hyperbole', ((Rails.env == 'production')  ? 'whsmd' : 'whsmd_testing'), 3306, "/var/run/mysqld/mysqld.sock"
		end
		
		def create_or_update_assignment(hash)
			res = ""
			assgt_id = hash['assgt_id']
			if Assignment.where(assgt_id: assgt_id).exists?
				asst = Assignment.find_by(assgt_id: assgt_id)
				if asst.content != hash['content'] 
					asst.content = hash['content']
					asst.save!
				end
			else
				Assignment.create! hash
			end
			res + <<EOT
<assgt_id>#{assgt_id}</assgt_id>
EOT
		end
				
		def create_or_update_assignments
			res = ""
			if conn = connector
				begin
					conn.query("SELECT assignments.assgt_id, assignments.teacher_id, assignments.content FROM assgts_status, assignments WHERE assgts_status.sent=0 AND assgts_status.assgt_id=assignments.assgt_id").each_hash do |hash|
						res += create_or_update_assignment(hash)
						conn.query("UPDATE assgts_status SET sent=1 WHERE assgt_id=#{hash['assgt_id']}")
					end
				ensure
					conn.close
				end
			end

			return res
		end
		
		def create_or_update_sa(hash)
			res = ""
			hash['academic_year'] = hash['academic_year'].to_i
			hash['course_id'] = hash['course_id'].to_i
			section = Section.find_by course_id: hash['course_id'], teacher_id: hash['teacher_id'], block: hash['block'], academic_year: hash['academic_year']
			raise "Missing section #{hash}" unless section
			raise "assignment #{hash['assgt_id']} doesn't exist" unless Assignment.where(assgt_id: hash['assgt_id'].to_i).exists?

			if section.section_assignments.where(assgt_id: hash['assgt_id']).exists?
				sa = section.section_assignments.find_by(assgt_id: hash['assgt_id'])
				sa.due_date = hash['due_date']
				sa.due_date = hash.delete('use_assgt') == 'Y'
				sa.save!
			else
				section.add_assignment(hash['name'], hash['assgt_id'], hash['use'])
			end
			return res + <<EOT
	<assgt_date>#{hash['id']}</assgt_date>
EOT
		end

		def create_or_update_sas
			res = ""
			if conn = connector
				begin
					threads = []
					conn.query("SELECT assgt_dates.id, assgt_id, course_num AS course_id,teacher_id,block,date_due AS due_date,use_assgt,schoolyear AS academic_year FROM assgt_dates,assgt_dates_status WHERE assgt_dates.id=assgt_dates_status.id AND assgt_dates_status.sent=0").each_hash do |hash|
						res += create_or_update_sa(hash)
						conn.query("UPDATE assgt_dates_status SET sent=1 WHERE id=#{hash['id']}")
					end
				ensure
					conn.close
				end
			end
			return res
		end

	end
	
end
