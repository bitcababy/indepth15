Fabricator(:section) do
	academic_year	{ |attrs| attrs[:academic_year] || Settings.academic_year }
	semester			{ Section::SEMESTERS.sample }
	block					{ |attrs| attrs[:block] || sequence(:block) {|i| Settings.blocks[i%Settings.blocks.length]} }
	teacher				{ |attrs| attrs[:teacher] || Fabricate(:teacher )}
	course				{ |attrs| attrs[:course] || Fabricate(:course )}
end

Fabrication::Transform.define(:in_block, lambda {|b| 
	if Section.where(block: b).exists?
		Section.find_by(block: b)
	else
		Fabricate(:section, block: b)
	end
	})
	