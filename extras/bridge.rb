require 'mysql'

module Bridge
	SERVER = (Rails.env == 'production') ? 'http://www.westonmath.org' : 'http://0.0.0.0:3000'
	
	class << self
		def connector
			c = Mysql.connect "db1.xoala.net", 'whswriter', 'hyperbole', ((Rails.env == 'production')  ? 'whsmd' : 'whsmd_testing'), 3306, "/var/run/mysqld/mysqld.sock"
			c.charset = 'utf8'
			return c
		end
		
		##
		## Courses
		##
		def update_course(hash)
			begin
				course = Course.find hash['course_num'].to_i
				for k in [:description, :policies, :news, :resources, :information] do
					doc = course.send k
					doc.content = hash[k.to_s]
					doc.save!
				end
			rescue
				return false
			end
		end

		def update_courses
			if conn = connector
				begin
					conn.query("SELECT course_info.course_num, prog_of_studies_descr 
					AS description, info AS information, policies, resources,news FROM course_info, course_info_status 
					WHERE course_info_status.sent=0 AND course_info_status.course_num=course_info.course_num").each_hash do |hash|
						if update_course(hash)
							conn.query("UPDATE course_info_status SET sent=1 WHERE course_num=#{hash['course_num']}") if update_course(hash)
						end
					end
				ensure
					conn.close if conn
				end
			end
		end
		
		##
		## Assignments
		##
		def create_assignment(hash)
			assgt_id = hash['assgt_id'].to_i
			asst = Assignment.new assgt_id: assgt_id, content: hash['content']
			if asst.valid?
				return asst.save!
			else
				return false
			end
		end
		
		def delete_assignment(hash)
			begin
				asst = Assignment.find_by assgt_id: hash['assgt_id'].to_i
				if (Rails.env == 'production')
					return asst.delete!
				else
					puts "#{asst} would have been deleted"
					return true
				end
			rescue
				return false
			end
		end
		
		def update_assignment(hash)
			assgt_id = hash['assgt_id'].to_i
			return false unless (crit = Assignment.where(assgt_id: assgt_id)).exists?
			asst = crit.first
			asst.content = hash['content']
			return asst.save!
		end
		
		def create_or_update_assignment(hash)
			assgt_id = hash['assgt_id'].to_i
			if Assignment.where(assgt_id: assgt_id).exists?
				update_assignment(hash)
			else
				create_assignment(hash)
			end
		end

		def create_or_update_assignments
			if conn = connector
				conn.query("UPDATE assgts_status SET sent=1 WHERE sent=0 AND new=1 AND deleted = 1")
				begin
					conn.query("SELECT assignments.assgt_id, assignments.teacher_id, assignments.content FROM assgts_status, assignments WHERE assgts_status.sent=0 AND assgts_status.deleted=0 AND assgts_status.assgt_id=assignments.assgt_id").each_hash do |hash|
						if create_or_update_assignment(hash) 
							conn.query("UPDATE assgts_status SET sent=1 WHERE assgt_id=#{hash['assgt_id']}")
						else
							puts "problem with #{hash}"
						end
					end
				ensure
					conn.close if conn
				end
			end
		end
		
		def delete_assignments
			if conn = connector
				begin
					conn.query("SELECT assgt_id FROM assgts_status
								WHERE assgts_status.sent=0 AND assgts_status.deleted=1").each_hash do |hash|
						if delete_assignment(hash) 
							conn.query("UPDATE assgts_status SET sent=1 WHERE assgt_id=#{hash['assgt_id']}") 
						else
							puts "problem with #{hash}"
						end
					end
				ensure
					conn.close if conn
				end
			end
		end

		##
		## SectionAssignments
		##
		def create_sa(section, hash)
			sa = section.section_assignments.new name: hash['name'],  due_date: hash['due_date'], 
					assignment: Assignment.find_by(assgt_id: hash['assgt_id']), 
					use: hash['use']
			if sa.valid?
				return sa.save!
			else
				return false
			end
		end
		
		def update_sa(sa, hash)
			sa.due_date = hash['due_date']
			sa.use = hash['use']
			sa.name = hash['name']
			return sa.save!
		end
		
		def create_or_update_sa(hash)
			hash['assgt_id'] = hash['assgt_id'].to_i
			hash['use'] = hash['use_assgt'] == 'Y'
			hash['academic_year'] = hash['academic_year'].to_i
			hash['course_id'] = hash['course_id'].to_i
			hash['due_date'] = Date.parse(hash['due_date'])
			hash['old_id'] = hash['old_id'].to_i
			old_id = hash['old_id'].to_i
			if SectionAssignment.where(old_id: old_id).exists?
				return update_sa(SectionAssignment.find_by(old_id: old_id), hash)
			else
				section = Section.find_by course: hash['course_id'].to_i, teacher_id: hash['teacher_id'], block: hash['block']
				return create_sa(section, hash)
			end
		end

		def create_or_update_sas
			if conn = connector
				begin
					conn.query("UPDATE assgt_dates_status SET sent=1 WHERE sent=0 AND new=1 AND deleted=1")
					conn.query("SELECT section_assignments.id AS old_id, assgt_id, name, course_num 
								AS course_id,teacher_id,block,due_date,year AS academic_year,use_assgt 
								FROM section_assignments,assgt_dates_status 
								WHERE section_assignments.id=assgt_dates_status.id 
								AND assgt_dates_status.sent=0 AND assgt_dates_status.deleted=0").each_hash do |hash|
						if create_or_update_sa(hash)
							conn.query("UPDATE assgt_dates_status SET sent=1,new=0 WHERE id=#{hash['old_id']}")
						else
							puts "problem with #{hash}"
						end
					end
				ensure
					conn.close if conn
				end
			end
		end

		def delete_sa(hash)
			begin
				sa = SectionAssignment.find_by old_id: hash['id'].to_i
				if (Rails.env == 'production') 
					return sa.delete!
				else
					puts "#{sa} would have been deleted"
					return true
				end
			rescue
				return false
			end
		end

		def delete_sas
			if conn = connector
				begin
					conn.query("SELECT assgt_dates_status.id FROM assgt_dates_status 
								WHERE assgt_dates_status.sent=0
								AND assgt_dates_status.deleted=1 ").each_hash do |hash|
						if delete_sa(hash)
							conn.query("UPDATE assgt_dates_status SET sent=1 WHERE id=#{hash['id']}")
						else
							puts "Couldn't delete #{hash['id']}"
						end
					end
				# rescue
				ensure
					conn.close if conn
				end
			end
		end
	end
	
end
