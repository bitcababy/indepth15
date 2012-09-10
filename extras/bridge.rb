require 'mysql'

module Bridge
	SERVER = (Rails.env == 'production') ? 'http://www.westonmath.org' : 'http://0.0.0.0:3000'
	
	class << self
		def connector
			return Mysql.connect "db1.xoala.net", 'whswriter', 'hyperbole', ((Rails.env == 'production')  ? 'whsmd' : 'whsmd_testing'), 3306, "/var/run/mysqld/mysqld.sock"
		end
		
		def create_or_update_assignment(hash)
			assgt_id = hash['assgt_id'].to_i
			if Assignment.where(assgt_id: assgt_id).exists?
				asst = Assignment.find_by(assgt_id: assgt_id)
				asst.content = hash['content']
				asst.save!
			else
				Assignment.create! assgt_id: assgt_id, content: hash['content']
			end
		end
				
		def create_or_update_sa(hash)
			assgt_id = hash['assgt_id'].to_i
			use = hash['use_assgt'] == 'Y'
			ay = hash['academic_year'].to_i
			course_id = hash['course_id'].to_i
			due_date = Date.parse(hash['due_date'])

			section = Section.find_by course_id: course_id, teacher_id: hash['teacher_id'], block: hash['block'], academic_year: ay
			raise "Missing section #{hash}" unless section
			raise "assignment #{assgt_id} doesn't exist" unless Assignment.where(assgt_id: assgt_id).exists?
			
			if sa = section.section_assignments.detect {|s| s.assignment.assgt_id == assgt_id}
				sa.due_date = due_date
				sa.use = use
				sa.name = hash['name']
				section.save!
			else
				section.section_assignments.create! name: hash['name'], due_date: due_date, assignment: Assignment.find_by(assgt_id: assgt_id), use: use
			end
		end

		def create_or_update_assignments
			if conn = connector
				begin
					conn.query("SELECT assignments.assgt_id, assignments.teacher_id, assignments.content FROM assgts_status, assignments WHERE assgts_status.sent=0 AND assgts_status.deleted=0 AND assgts_status.assgt_id=assignments.assgt_id").each_hash do |hash|
						create_or_update_assignment(hash)
						conn.query("UPDATE assgts_status SET sent=1 WHERE assgt_id=#{hash['assgt_id']}")
					end
				rescue
					logger.warn "Couldn't connect to database #{SERVER}"
				ensure
					conn.close if conn
				end
			end

			# return res
		end
		
		def create_or_update_sas
			# res = ""
			if conn = connector
				begin
					conn.query("SELECT section_assignments.id, assgt_id, name, course_num AS course_id,teacher_id,block,due_date,academic_year,use_assgt FROM section_assignments,assgt_dates_status WHERE assgt_dates_status.sent=0 AND AND assgts_status.deleted=0 section_assignments.id=assgt_dates_status.id").each_hash do |hash|
						create_or_update_sa(hash)
						conn.query("UPDATE assgt_dates_status SET sent=1 WHERE id=#{hash['id']}")
					end
				rescue
				ensure
					conn.close if conn
				end
			end
		end

	end
	
end
