class Import::Section < Import

	cattr_reader :mapping, :convert_class
	field :year, type: Integer
	
	validates_uniqueness_of :number, scope: [:year, :course_num]
	validates_uniqueness_of :block,
		scope: [:year, :course_num, :teacher_id]
	
	@@mapping = {
		"id" => :orig_id,
		"section_num" => :number,
		"block" => :block,
		"days" => :days,
		"room" => :room,
		"semester" => :semesters,
		"which_occurrences" => :which_occurrences,
		"dept_id" => :dept_id,
		"course_num" => :course_num,
		"year" => :year,
		"room" => :room,
		"teacher_id" => :teacher_id,
		"sched_color" => :sched_color,
		"style_id" => :style_id,
		}
		
	def self.gather_all_for_export
		self.where(:year.gte => 2011).desc(:year).all
	end

end
