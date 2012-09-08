require 'mysql'

module Bridge
	SERVER = (Rails.env == 'production')? 'http://www.westonmath.org' : 'http://0.0.0.0:3000'
	
	class << self
		def connector
			return Mysql.connect "db1.xoala.net", 'whswriter', 'hyperbole', 'whsmd', 3306, "/var/run/mysqld/mysqld.sock"
		end
		
		def create_or_update_assignments
			conn = connector
			conn.query("SELECT assgt_id FROM assgts_status WHERE sent=0").each do |rec|
				assgt_id = rec[0].to_i
				conn.query("SELECT assgt_id, teacher_id, content FROM assignments WHERE assgt_id=#{assgt_id}").each_hash do |hash|
					if Assignment.where(assgt_id: assgt_id).exists?
						asst = Assignment.find_by(assgt_id: assgt_id)
						asst.content = hash['content']
						asst.save!
					else
						Assignment.create! hash
					end
					conn.query("UPDATE assgts_status SET sent=1 WHERE assgt_id=#{assgt_id}")
				end
			end
			return true
		end
		
		def create_or_update_sas
			conn = connector

			conn.query("SELECT id, assgt_id,course_num,teacher_id,block FROM assgt_dates_status WHERE sent=0").each_hash do |hash|
				# puts "hash is #{hash}"
				section = Section.find_by course_id: hash['course_num'].to_i, teacher_id: hash['teacher_id'], block: hash['block']

				conn.query("SELECT due_date, assgt_id, use_assgt FROM section_assignments WHERE id=#{hash['id']}").each_hash do |hash2|
					hash['use'] = hash.delete('use_assgt') == 'Y'
					raise "assignment #{hash['assgt_id']} doesn't exist" unless Assignment.where(assgt_id: hash['assgt_id']).exists?
					
					if section.section_assignments.where(assgt_id: hash2['assgt_id']).exists?
						sa = section.section_assignments.find_by(assgt_id: hash2['assgt_id'])
						sa.update_attributes hash2
						sa.save!
					else
						section.add_assignment(hash2['name'], hash2['assgt_id'], hash2['use'])
					end
					conn.query("UPDATE assgt_dates_status SET sent=1 WHERE id=#{hash['id']}")
				end
			end
			return true
		end		
	end
end
