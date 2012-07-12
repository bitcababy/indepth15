Fabricator(:section) do
	number	{ sequence(:section_number) }
	block		{ ('A'..'H').to_a.sample }
	occurrences		{ (1..5).to_a }
	room		{ "Room #{Fabricate.sequence}"}
end

Fabricate.sequence(:section_number) {|i| i }

Fabrication::Transform.define(:section, lambda {|i| 
	if Section.where(number: i).exists?
		Section.find_by(number: i)
	else
		Fabricate(:section, number: i)
	end
	})