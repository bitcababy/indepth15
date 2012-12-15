class Department
  def self.import_from_hash(hash)
    dept = Department.new
    dept.name = hash[:name]
    dept.save!
    i = 0
    TextDocument.create(title: "How to use the new Westonmath app", content: hash[:how_to_use], owner: dept, position: ++i)
    TextDocument.create(title: "Why not Teacherweb?", content: hash[:why], owner: dept, position: ++i)
    TextDocument.create(title: "Objectives", content: hash[:objectives], owner: dept, position: ++i)
    TextDocument.create(title: "News", content: hash[:news], owner: dept, position: ++i)
    TextDocument.create(title: "Resources", content: hash[:resources], owner: dept, position: ++i)
    TextDocument.create(title: "Puzzle", content: hash[:puzzle], owner: dept, position: ++i)
  end
  
end

class Course
	class << self
  	SEMESTER_MAP = {
  		12 => FULL_YEAR,
  		1 => FIRST_SEMESTER,
  		2 => SECOND_SEMESTER,
  		3 => FULL_YEAR_HALF_TIME,
  	}

		def massage_content(txt)
			return "" unless txt
			txt.gsub!(/http:\/\/www\.westonmath\.org/, "")
			txt.gsub!(/http:\/\/westonmath\.org/, "")
			txt.gsub!(/\/teachers\//, "/files/")
			txt.gsub!(/href\s+=\s+'teachers\//, "href='/files/")
			txt.gsub!(/href\s+=\s+"teachers\//, "href=\"/files/")
			txt.gsub!(/href\s+=\s+(["'])teachers/, "href=\1/files")
			return txt
		end
		
		def import_from_hash(hash)
			i = hash.delete(:information)
			r = hash.delete(:resources)
			p = hash.delete(:policies)
			n = hash.delete(:news)
			d = hash.delete(:description)
			
			hash[:duration] = SEMESTER_MAP[hash.delete(:semesters).to_i]
			course = self.create! hash
			course.information.content = massage_content(i)
			course.information.save!
			course.resources.content = massage_content(r)
			course.resources.save!
			course.policies.content = massage_content(p)
			course.policies.save!
			course.news.content = massage_content(n)
			course.news.save!
			course.description.content = massage_content(d)
			course.description.save!
			return course
		end
	end
end

class Teacher
	def self.import_from_hash(hash)
		hash[:email] = hash[:login] + "@mail.weston.org"
		hash[:password] = (hash[:phrase].split(' ').map &:first).join('') if (hash[:phrase])
		hash[:current] = hash[:old_current] == 1
		coder = HTMLEntities.new
		hash[:generic_msg] = coder.decode(hash[:generic_msg])
		# puts "#{hash[:generic_msg]}"
		hash[:upcoming_msg] = coder.decode(hash[:upcoming_msg])
		[:phrase, :old_current, :teacher_id, :orig_id].each {|k| hash.delete(k)}
		teacher = self.create! hash
		return teacher
	end
end

class Section
	def self.import_from_hash(hash)
		year = hash[:academic_year] = hash.delete(:year)
		return if year < Settings.start_year

		occurrences = hash.delete(:which_occurrences)
		hash[:semester] = (hash.delete(:semesters) == 2) ? Course::SECOND_SEMESTER : Course::FIRST_SEMESTER
		teacher_id = hash.delete(:teacher_id)
		hash[:room] = hash[:room].to_s
		
		course_number = hash.delete(:course_num)
		course = Course.find_by(number: course_number)
		hash[:course] = course
		
		[:course_num, :semesters].each {|k| hash.delete(k)}

		teacher = Teacher.find_by login: teacher_id
		hash[:teacher] = teacher
		section = course.sections.create!(hash)

		occurrences = (occurrences == 'all') ? (1..5).to_a : (occurrences.split(',').collect {|x| x.to_i})
		for occ in occurrences
			section.occurrences.find_or_create_by(block: section.block, number: occ)
		end
		return section
	end
end

class SectionAssignment
	def self.import_from_hash(hash)
		section,assignment = self.get_sa(hash)
		
		crit = SectionAssignment.where(assignment: assignment, block: hash[:block], section: section)
		if crit.exists?
			sa = crit.first
			raise "no section_assignment" unless sa
			sa.due_date = hash[:due_date]
			sa.use = hash[:use] == 'Y'
			sa.save!
			return sa
		else
			hash[:use] = hash[:use] == 'Y'
			hash[:assignment] = assignment
      hash.delete(:block) # Have to do this or the block delegation won't work
			return section.section_assignments.create! hash
		end
	end
end

class Assignment
	def self.import_from_hash(hash)
		assgt_id = hash[:assgt_id]
		hash[:content] ||= ""
		crit = self.with_assgt_id(assgt_id)
		if crit.exists?
			asst = crit.first
			asst.content = hash[:content]
			return asst.save!
		else
			author = Teacher.find_by(login: hash[:teacher_id])
			raise "Couldn't find teacher #{hash[:teacher_id]}" unless author
			hash.delete(:teacher_id)
			return Assignment.create! hash.merge(owner: author)
		end
	end
end
  