Fabricator(:section) do
	number	{ sequence(:section_number) }
	block		{ ('A'..'E').to_a.sample }
	days		{ (1..8).to_a.sample(5) }
	room		{ "Room #{Fabricate.sequence}"}
	course
	teacher
	assignments	[]
end

Fabricate.sequence(:section_number) {|i| i }

