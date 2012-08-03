Fabricator(:section) do
	block					{ sequence(:block) {|i| Settings.blocks[i%Settings.blocks.length] } }
	teacher				{ Fabricate :teacher }
	academic_year	{ Settings.academic_year }
	semester			{ Section::SEMESTERS.sample }
end

Fabricate.sequence(:block) {|i| Settings.blocks[i%Settings.blocks.length] }

Fabrication::Transform.define(:block, lambda {|b| 
	if Section.where(block: b).exists?
		Section.find_by(block: b)
	else
		Fabricate(:section, block: b)
	end
	})