# encoding: UTF-8

class Section
	include Mongoid::Document
  # include Mongoid::Timestamps
	SEMESTERS = [Course::FIRST_SEMESTER, Course::SECOND_SEMESTER]

	field :de, as: :dept, type: Integer
	field :bl, as: :block, type: String
	field :rm, as: :room, type: String
	field :se, as: :semester, type: Symbol
	field :ay, as: :academic_year, type: Integer, default: Settings.academic_year
	field :oc, as: :occurrences, type: Array, default: (1..Settings.num_occurrences).to_a
	
	index({ academic_year: -1, semester: 1, block: 1 }, { name: 'ysb' } )

	belongs_to :course, index: true
	belongs_to :teacher, index: true

	embeds_many :section_assignments
	# has_and_belongs_to_many :occurrences

	validates :block, presence: true, inclusion: {in: Settings.blocks}
	# validates :room, presence: true
	validates :semester, presence: true, inclusion: {in: SEMESTERS}
	validates :academic_year, presence: true, numericality: true
	
	scope :for_year, ->(y){ where(academic_year: y)}
	scope :current, ->{ where(academic_year: Settings.academic_year)}
	
	def upcoming_assignments
		self.section_assignments.upcoming.asc(:due_date)
	end
	
	def current_assignment
		[self.section_assignments.current]
	end
	
	def future_assignments
		self.section_assignments.future.asc(:date_due).map &:assignment
	end

	def past_assignments
		self.section_assignments.past.desc(:date_due).map &:assignment
	end
	
	def add_assignment(asst, due_date, show=true)
		self.section_assignments.create! due_date: due_date, assignment: asst
	end
	
	def page_header
		"#{course.full_name}, Block #{self.block}"
	end
		
	def to_s
		course = self.course
		"#{course.full_name}#{course.academic_year}/#{self.teacher.login}/#{self.block}"
	end
		
	def days_for_section
		occ = Occurrence.where(block: self.block).in(number: self.occurrences)
		(occ.map &:day).sort
	end
	
	class << self
		def import_from_hash(hash)
			year = hash[:academic_year] = hash[:year]
			return if year < Settings.start_year
	
			occurrences = hash[:which_occurrences]
			semesters = hash[:semesters]
			teacher_id = hash[:teacher_id]
			hash[:room] = hash[:room].to_s
			hash[:academic_year] = hash[:year]
			course_number = hash[:course_num]
			course = Course.find_by(number: course_number)
			hash[:course] = course
			
			[:which_occurrences, :semester, :sched_color, :year, :dept_id, :number, :course_num, :semesters, :style_id].each {|k| hash.delete(k)}

			teacher = Teacher.find_by login: teacher_id
			hash[:teacher] = teacher
			hash[:occurrences] = (occurrences == 'all') ? (1..5).to_a : (occurrences.split(',').collect {|x| x.to_i})
			
			hash[:semester] = [1,3,12].contains?(semesters) ? Course::FIRST_SEMESTER : Course::SECOND_SEMESTER
			
			section = course.sections.create!(hash)
			section.save!
			section.occurrences.each do |i|
				puts "Occurrence #{i}/#{section.block} does not exist" unless Occurrence.where(number: i, block: section.block).exists?
			end
			return section
		end
	
	end

end