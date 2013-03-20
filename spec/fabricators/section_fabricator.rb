Fabricator(:section) do
  transient             :sas_count
  transient             :offset
	year	                { |attrs| Settings.academic_year - (attrs[:offset] || 0)}
	duration			        { Course::DURATIONS.sample }
  room                  { sequence(:room) {|i| "Room #{i}"} }
	block	                { sequence(:block_name) {|i| Settings.blocks[i%Settings.blocks.length]} }
  section_assignments   {[]}
  course
  teacher
  after_build           { |section, t| 
    (t[:sas_count] || 0 ).times { section.section_assignments << Fabricate.build(:section_assignment) }
    teacher.sections << section
    course.sections << section
  }
end
