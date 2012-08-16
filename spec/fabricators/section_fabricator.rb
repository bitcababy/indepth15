Fabricator(:section) do
	academic_year	{ Settings.academic_year }
	semester			{ Section::SEMESTERS.sample }
	block					{ Settings.blocks.sample }
	teacher
	course
	after_build	{ |obj|
		# obj.teacher ||= Fabricate(:teacher)
		# obj.course ||= Fabricate(:course)
		}
end

Fabricate.sequence(:block) {|i| Settings.blocks[i%Settings.blocks.length] }

Fabrication::Transform.define(:in_block, lambda {|b| 
	if Section.where(block: b).exists?
		Section.find_by(block: b)
	else
		Fabricate(:section, block: b)
	end
	})
	