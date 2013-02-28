Fabricator(:section) do
	academic_year	{ |attrs| attrs[:academic_year] || Settings.academic_year }
	semesters			{ Course::DURATIONS.sample }
	block					{ |attrs| attrs[:block] || sequence(:block) {|i| Settings.blocks[i%Settings.blocks.length]} }
  room          { sequence(:room) {|i| "Room #{i}"} }
  section_assignments []
  course
  teacher
end

Fabrication::Transform.define(:in_block, lambda {|b| 
	if Section.where(block: b).exists?
		Section.find_by(block: b)
	else
		Fabricate(:section, block: b)
	end
	})
	