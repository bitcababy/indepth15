Fabricator(:section) do
	block					{ sequence(:block) }
	occurrences		{ (1..3).collect {sequence(:occurrence_number) {|i| i}} }
	room					{ "Room #{Fabricate.sequence}"}
	teacher				{ Fabricate :teacher }
	academic_year	{ Settings.academic_year }
	after_build		{|obj| obj.occurrences.each {|i| 
										Fabricate(:occurrence, block: obj.block, number: i ) unless Occurrence.where(number: i, block: obj.block).exists?
										} }
end

Fabricate.sequence(:block) {|i| Settings.blocks[i%Settings.blocks.length] }

Fabrication::Transform.define(:block, lambda {|b| 
	if Section.where(block: b).exists?
		Section.find_by(block: b)
	else
		Fabricate(:section, block: b)
	end
	})