Fabricator(:section) do
	block		{ ('A'..'E').to_a.sample }
	days		{ (1..8).sample(5) }
	room		{ "Room #{Fabricate.sequence}"}
	course
	teacher
	assignments
end

