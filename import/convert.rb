# encoding: utf-8
require 'xmlsimple'

module Convert

	MAPPINGS = {
    ::Occurrence =>   {
      'block_name' => :block,
      'occurrence' => :number,
      'day_num' => :day,
      'period' => :period,
    },
		::Department => {
			'dept_id' => :name,
			'objectives' => :objectives,
			'how_to_use' => :how_to_use,
			'news'	=> :news,
			'resources' => :resources,
			'puzzle' => :puzzle,
			'why' => :why,
		},
		::Teacher => {
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
		::Assignment => {
			"assgt_id" 							=> :oid,
			"teacher_id"						=> :teacher_id,
			"content"								=> :content,
			},
		::Course => 	{
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
				'resources' 			=> :resources,
				'semesters' 			=> :semesters,
				'policies' 				=> :policies,
				'description'     => :description,
				'info'           => :information,
			},
		::Section => {
				"dept_id" => :dept_id,
				"course_num" => :course_num,
				"semester" => :semester,
				"block" => :block,
				"year" => :year,
				"room" => :room,
				"which_occurrences" => :which_occurrences,
				"teacher_id" => :teacher_id,
			},
		::SectionAssignment => {
			"id"							=> :old_id,
			"teacher_id" 			=> :teacher_id,
			"year" 						=> :year,
			"course_num" 			=> :course_num,
			"block" 					=> :block,
			"assgt_id" 				=> :assgt_id,
			"use_assgt" 			=> :assigned,
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

class Occurrence
	def self.import_from_hash(hash)
		return Occurrence.create! hash
	end
end

class Department
  include Mongoid::Document
  def self.import_from_hash(hash)
    DepartmentDocument.delete_all
    dept = Department.new name: 'whs_md', full_name: 'Math Department'
    dept.homepage_docs.build(title: "How to use the new Westonmath app", content: hash[:how_to_use], pos: 0)
    dept.homepage_docs.build(title: "Why not Teacherweb?", content: hash[:why], pos: 1)
    dept.homepage_docs.build(title: "News", content: hash[:news], pos: 2)
    dept.homepage_docs.build(title: "Resources", content: hash[:resources], pos: 3)
    dept.homepage_docs.build(title: "Puzzle", content: hash[:puzzle], pos: 4)
    
    dept.save!
  end
  
end

class Course
  include Mongoid::Document

	class << self
  	SEMESTER_MAP = {
  		12 => FULL_YEAR,
  		1 => FIRST_SEMESTER,
  		2 => SECOND_SEMESTER,
  		3 => FULL_YEAR_HALF_TIME,
  	}

		def import_from_hash(hash)
			i = massage_content hash.delete(:information)
			r = massage_content hash.delete(:resources)
			p = massage_content hash.delete(:policies)
			n = massage_content hash.delete(:news)
			d = massage_content hash.delete(:description)
			
			hash[:duration] = SEMESTER_MAP[hash.delete(:semesters).to_i]
      hash[:short_name] ||= hash[:full_name]
			course = Department.first.courses.new hash
      course.documents.build kind: :resources, content: r
      course.documents.build kind: :policies, content: p
      course.documents.build kind: :news, content: n
      course.documents.build kind: :description, content: d
      course.documents.build kind: :information, content: i
 			return course.save!
		end
	end
	def self.massage_content(txt)
		return "" unless txt
		txt.gsub!(/http:\/\/www\.westonmath\.org/, "")
		txt.gsub!(/http:\/\/westonmath\.org/, "")
		txt.gsub!(/\/teachers\//, "/files/")
		txt.gsub!(/href\s+=\s+'teachers\//, "href='/files/")
		txt.gsub!(/href\s+=\s+"teachers\//, "href=\"/files/")
		txt.gsub!(/href\s+=\s+(["'])teachers/, "href=\1/files")
		return txt
	end

end

class Teacher
  include Mongoid::Document
	def self.import_from_hash(hash)
		hash[:email] = hash[:login] + "@mail.weston.org"
		hash[:password] = (hash[:phrase].split(' ').map &:first).join('') if (hash[:phrase])
		hash[:current] = hash[:old_current] == 1
		coder = HTMLEntities.new
		hash[:generic_msg] = coder.decode(hash[:generic_msg])
		hash[:upcoming_msg] = coder.decode(hash[:upcoming_msg])
		Teacher.create hash
	end
end

class Section
  DUR_MAP = {
    1 => Course::FIRST_SEMESTER,
    2 => Course::SECOND_SEMESTER,
    3 => Course::FULL_YEAR,
    12 => Course::FULL_YEAR,
  }
	def self.import_from_hash(hash)
		year = hash[:year]
		return if year < Settings.start_year

		occurrences = hash[:which_occurrences]
		room = hash[:room].to_s
    block = hash[:block]
		duration = DUR_MAP[hash[:semester]] || Course::FULL_YEAR
		course = Course.find_by(number: hash[:course_num])
		teacher = Teacher.find_by login: hash[:teacher_id]

		occurrences = (occurrences == 'all') ? (1..5).to_a : (occurrences.split(',').collect {|x| x.to_i})
    days = []
		for occ in occurrences
      days << Occurrence.find_by(block: block, number: occ).day
		end
    days.sort!
  
		section = course.sections.build block: block, duration: duration, year: year, days: days, room: room, course: course, teacher: teacher
    puts section.attributes unless section.valid?
    section.save!
		return section
	end
end

class Assignment
  before_create :fix_content
  
	def self.import_from_hash(hash)
    hash[:oid] = hash[:oid].to_i
 		return Assignment.create! hash
	end

	def fix_content
		self.content.gsub!(/http:\/\/www\.westonmath\.org/, "")
		self.content.gsub!(/http:\/\/westonmath\.org/, "")
		self.content.gsub!(/\/?teachers\//, "/files/")
		self.content.gsub!(/href\s+=\s+'teachers\//, "href='/files/")
		self.content.gsub!(/href\s+=\s+"teachers\//, "href=\"/files/")
		self.content.gsub!(/href\s+=\s+(["'])teachers/, "href=\1/files")
	end

end

class SectionAssignment
  include Mongoid::Document

	def self.import_from_hash(hash)
		section, assignment = self.get_sa(hash)
    assignment.name = hash.delete(:name)
    assignment.name = assignment.name.to_i if assignment.name =~ /^\d+$/
    assignment.teacher = section.teacher
    section.teacher.assignments << assignment
    assignment.save!
 		hash[:assigned] = hash[:assigned] == 'Y'
		hash[:assignment] = assignment
		section.section_assignments.create! hash
	end

	def self.get_sa(hash)
		assgt_id = hash.delete(:assgt_id)
		year = hash[:year]
		course_num = hash.delete(:course_num).to_i
		block = hash[:block]
		teacher_id = hash.delete(:teacher_id)
		course = Course.find_by(number: course_num)
		raise "Course #{course_num} not found" unless course
		teacher = Teacher.find_by(login: teacher_id)
		raise "Course #{teacher_id} not found" unless teacher
		section = Section.find_by(course: course, block: block, year: year, teacher: teacher)
		raise "Section #{course}/#{block}/#{teacher_id} not found" unless teacher
		assignment = Assignment.find_by(oid: assgt_id)
		return section, assignment
	end
end
