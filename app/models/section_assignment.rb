class SectionAssignment
	include Mongoid::Document
  include Mongoid::Timestamps::Short
  include Mongoid::History::Trackable
  include Utils

	field :dd, as: :due_date, type: Date, default: -> { Utils.future_due_date }
	field :as, as: :assigned, type: Boolean, default: false
  field :bl, as: :block, type: String
  field :y, as: :year, type: Integer
  field :tn, as: :teacher_name, type: String
  field :cn, as: :course_name, type: String
  
	index({due_date: -1, assigned: 1})
	
	belongs_to :section, counter_cache: true, autosave: true, index: true
	belongs_to :assignment, counter_cache: true, autosave: true, index: true
      
  belongs_to :teacher, index: true
  belongs_to :course, index: true
  
  index({year: -1, course_id: 1, teacher_id: 1, block: 1, due_date: 1})
  index({year: -1, course_id: 1, teacher_id: 1})
 
  scope :for_section,       ->(s) { where(section: s) }
  scope :for_course,        ->(c) { where(course: c) }
  scope :for_teacher,       ->(t) { where(teacher: t) }
  scope :for_year,          ->(t) { where(year: t) }

  scope :due_after,         ->(date){ gt(due_date: date) }
  scope :due_on_or_after,   ->(date) { gte(due_date: date) }
  scope :due_on,            ->(date){ where(due_date: date) }
  scope :due_before,        ->(date) { lt(due_date: date) }
  scope :assigned,          -> { where(assigned: true) }
  scope :past,              -> { due_before(future_due_date) }
  scope :future,            -> { due_on_or_after(future_due_date ) }
  scope :next_assignment,   -> { due_on_or_after(future_due_date).asc(:due_date).limit(1) }
  
  before_create :sync_with_section
  
  def sync_with_section
    self.year = self.section.year
    self.course = self.section.course
    self.block = self.section.block
    self.teacher = self.section.teacher
    self.course_name = self.course.short_name
    self.teacher_name = self.teacher.full_name
  end
    
  # data_table_options.merge!({
 #    fields: %w(year course teacher semester block name asst),
 #    dataset: ->(sa) {
 #      {
 #        0 => sa.section.year,
 #        1 => sa.section.course.full_name,
 #        2 => sa.section.teacher.full_name,
 #        3 => sa.section.duration,
 #        4 => sa.section.block,
 #        5 => sa.assignment.name,
 #        6 => sa.assignment.content
 #      }
 #    }
 #  })

  track_history track_create: true
  
	def to_s
		return "#{due_date}/#{assigned}"
	end
  
  def potential_major_topics
    self.course.major_topics
  end
  
	def self.upcoming
		na = self.future.assigned.asc.first
		if na
			return self.due_after(na.due_date)
		else
			return self.future
		end
	end
  
  # {"sEcho"=>"1", 
  #   "iColumns"=>"10", 
  #   "sColumns"=>"year,course,teacher,block,due_date,name,content,last_name,first_name,course_id", 
  #   "iDisplayStart"=>"0", 
  #   "iDisplayLength"=>"20",
  #   "iSortCol_0"=>"0", 
  #   "sSortDir_0"=>"asc", 
  #   "iSortCol_1"=>"1", 
  #   "sSortDir_1"=>"asc", 
  #   "iSortCol_2"=>"7", 
  #   "sSortDir_2"=>"asc", 
  #   "iSortCol_3"=>"8", 
  #   "sSortDir_3"=>"asc", 
  #   "iSortCol_4"=>"3", 
  #   "sSortDir_4"=>"asc", 
  #   "iSortCol_5"=>"4", 
  #   "sSortDir_5"=>"asc", 
  #   "iSortingCols"=>"6", 
  #   "bSortable_0"=>"true", 
  #   "bSortable_1"=>"true", 
  #   "bSortable_2"=>"true", "bSortable_3"=>"false", "bSortable_4"=>"false", "bSortable_5"=>"false", "bSortable_6"=>"false", "bSortable_7"=>"true", "bSortable_8"=>"true", "bSortable_9"=>"true", "_"=>"1364230910350"}
   
  
#
  def SectionAssignment.process_data_request(h)
    return nil if h.empty?
    cols = h["sColumns"].split(",")
    start = h["iDisplayStart"]
    limit = h["iDisplayLength"]
    crit = SectionAssignment.skip(start).limit(limit)
    crit = crit.for_year(h["sFilter_0"].to_i) unless h["sFilter_0"].empty?
    crit = crit.for_course(h["sFilter_1"].to_i) unless h["sFilter_1"].empty?
    crit = crit.for_teacher(h["sFilter_2"]) unless h["sFilter_2"].empty?
    # Get the order
    order = self.get_order(cols, h)
    crit = crit.order_by(order.join(','))
       
    data = self.get_data(crit, cols)

    res = {}
    res["iTotalRecords"] = SectionAssignment.count
    res["iTotalDisplayRecords"] = crit.count
    res["sEcho"] = h["sEcho"]
    res["aaData"] = data
    return res
  end
  
  def SectionAssignment.get_order(cols, h)
    order = []
    0.upto(2) do |i|
      dir = h["sSortDir_#{i}"]
      next unless dir
      
      col_no = h["iSortCol_#{i}"].to_i
      col = cols[col_no]
      
      order << "#{col} #{dir}"
    end
    order << "year desc" unless h["sSortDir_0"]
    order << "course_id asc" unless h["sSortDir_1"]
    order << "teacher_id asc" unless h["sSortDir_2"]
    order << "block asc"
    order << "due_date asc"
  
    return order
  end

  def self.get_data(sas, cols)
    data = []
    sas.each do |sa|
      row = []
      for col in cols do
        datum = case col
        when "year"
        sa.year
        when "course"
        sa.course_name
        when "teacher"
        sa.teacher_name
        when "block"
        sa.block
        when "due_date"
        sa.due_date
        when "name"
        sa.assignment.name
        when "content"
        sa.assignment.content
        when "course_id"
        sa.course.to_param
        when "teacher_id"
        sa.teacher.to_param
        end
        row << datum
      end
      data << row
    end
    return data
  end #get_data
  
   
end

