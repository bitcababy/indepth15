Fabricator(:section) do
  transient             :sas_count
	year	                { Settings.academic_year }
	duration			        { Course::DURATIONS.sample }
  room                  { sequence(:room) {|i| "Room #{i}"} }
	block	                { sequence(:block_name) {|i| Settings.blocks[i%Settings.blocks.length]} }
  section_assignments   []
  course
  teacher
  after_build           { |section, t| 
    (t[:sas_count] || 0 ).times { section.section_assignments << Fabricate.build(:section_assignment) }
  }
  after_create { |section, t|
    if section.course
      course.sections << section
      course.save
    end
    if section.teacher
      teacher.sections << section
      teacher.save
    end
  }
end

Fabricator :section_earlier_year, from: :section do
  transient             :offset
	year	                { |attrs| Settings.academic_year - (attrs[:offset] || 1) }
end

