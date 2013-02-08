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
			"assgt_id" 							=> :assgt_id,
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
				"semester" => :semesters,
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

class Occurrence
	def self.import_from_hash(hash)
		return Occurrence.create! hash
	end
end

class Department
  include Mongoid::Document
  def self.import_from_hash(hash)
    DepartmentDocument.delete_all
    dept = Department.create name: hash[:name]
    dept.homepage_docs.create(title: "How to use the new Westonmath app", content: hash[:how_to_use], pos: 0)
    dept.homepage_docs.create(title: "Why not Teacherweb?", content: hash[:why], pos: 1)
    dept.homepage_docs.create(title: "News", content: hash[:news], pos: 2)
    dept.homepage_docs.create(title: "Resources", content: hash[:resources], pos: 3)
    dept.homepage_docs.create(title: "Puzzle", content: hash[:puzzle], pos: 4)
    
    dept.save!
  end
  
end

class Course
  include Mongoid::Document
	BRANCH_MAP = {
		321 => 'Geometry',
		322 => 'Geometry',
		326 => 'Algebra',
		331 => 'Algebra',
		332 => 'Algebra',
		333 => 'Algebra',
		341 => 'Precalculus',
		342 => ['Precalculus', 'Statistics', 'Algebra'],
		343 => 'Discrete Math',
		352 => 'Precalculus',
		361 => 'Calculus',
		371 => 'Calculus',
		391 => 'Statistics',
	}
	MAJOR_TAGS = {
		'Geometry' => [
			'Transformations', 'Similarity', 'Congruence', 'Logic/Proof',
			'Measurement', 'Non-Euclidean', 'Circles', 'Polygons', 'Parallel Lines'
			],
		'Algebra' => [
			'Functions',
			'Quadratics',
			'Exponents/Logs',
			'Systems of Equations',
			'Number Theory',
			'Probability/Combinatorics',
			'Data Distributions',
			'Correlation/Regression',
		],
		'Precalculus' => [
			'Functions',
			'Trigonometry',
			'Probability/Combinatorics',
			'Complex Numbers',
			'Polynomials',
			'Iteration',
			'Rational Functions',
			'Logic/Proof',
			'Number Theory',
		],
		'Calculus' => [
			'Limits',
			'Sequences/Series',
			'Derivatives',
			'Integrals',
			],
		'Statistics' => [
			'Data Distributions',
			'Data Collection',
			'Sampling Distributions',
			'Inference',
			'Correlation/Regression',
			],
		'Discrete Math' => [
			'Inference',
			'Data Collection',
			'Queueing Theory',
			'Manhattan Metric',
			'Game Theory',
			'Graph Theory',
			'Emergence',
			'Risk Analysis',
			],
	}

  def add_major_tags
    branches = BRANCH_MAP[self.number].to_a
    self.major_tags = (branches.collect {|b| MAJOR_TAGS[b]}).flatten.uniq
  end

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
			course = Department.first.courses.create hash
      course.add_major_tags
      course.documents.create kind: :resources, content: r
      course.documents.create kind: :policies, content: p
      course.documents.create kind: :news, content: n
      course.documents.create kind: :description, content: d
      course.documents.create kind: :information, content: i
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
		# puts "#{hash[:generic_msg]}"
		hash[:upcoming_msg] = coder.decode(hash[:upcoming_msg])
		[:phrase, :old_current, :teacher_id, :orig_id].each {|k| hash.delete(k)}
		teacher = self.create! hash
		return teacher
	end
end

class Section
  include Mongoid::Document
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
      section.days << Occurrence.find_by(block: section.block, number: occ).day
		end
    section.days.sort!
    section.save!
		return section
	end
end

class SectionAssignment
  include Mongoid::Document

	def self.import_from_hash(hash)
		section,assignment = self.get_sa(hash)
     # crit = SectionAssignment.where(assignment: assignment, block: hash[:block], section: section)
    # if crit.exists?
    #   sa = crit.first
    #   raise "no section_assignment" unless sa
    #   sa.due_date = hash[:due_date]
    #   sa.use = hash[:use] == 'Y'
    #   sa.save!
    #   return sa
    # else
			hash[:use] = hash[:use] == 'Y'
			hash[:assignment] = assignment
      hash.delete(:block) # Have to do this or the block delegation won't work
			return section.section_assignments.create! hash
    # end
	end
	
	def self.get_sa(hash)
		assgt_id = hash.delete(:assgt_id)
		year = hash[:year]
		course_num = hash.delete(:course_num).to_i
		block = hash[:block]
		name = hash[:name]
		teacher_id = hash.delete(:teacher_id)
		course = Course.find_by(number: course_num)
		raise "Course #{course_num} not found" unless course
		teacher = Teacher.find_by(login: teacher_id)
		raise "Course #{teacher_id} not found" unless teacher
		section = Section.find_by(course: course, block: block, academic_year: year, teacher: teacher)
		raise "Section #{course}/#{block}/#{teacher_id} not found" unless teacher
		assignment = Assignment.find_by(assgt_id: assgt_id)
		return section,assignment
	end
end

class Assignment
  include Mongoid::Document
  before_save :fix_content

	scope :dupes, ->(a) { where(:assgt_id.gt => a.assgt_id, :content => a.content) }

	index( {assgt_id: 1}, {unique: true})
	scope :with_assgt_id, ->(i) {where(assgt_it: i)}

	def self.import_from_hash(hash)
    # assgt_id = hash[:assgt_id]
		hash[:content] ||= ""
    # crit = self.with_assgt_id(assgt_id)
    # if crit.exists?
    #   asst = crit.first
    #   asst.content = hash[:content]
    #   return asst.save!
    # else
			author = Teacher.find_by(login: hash[:teacher_id])
			raise "Couldn't find teacher #{hash[:teacher_id]}" unless author
			hash.delete(:teacher_id)
			return Assignment.create! hash.merge(last_editor: author.to_param)
    # end
	end

	def self.massage_content(txt)
		txt.gsub!(/http:\/\/www\.westonmath\.org/, "")
		txt.gsub!(/http:\/\/westonmath\.org/, "")
		txt.gsub!(/\/teachers\//, "/files/")
		txt.gsub!(/href\s+=\s+'teachers\//, "href='/files/")
		txt.gsub!(/href\s+=\s+"teachers\//, "href=\"/files/")
		txt.gsub!(/href\s+=\s+(["'])teachers/, "href=\1/files")
		return txt
	end

	def fix_content
		self.content = Assignment.massage_content(self.content)
	end
end
