Fabricator(:occurrence) do
	number			{ sequence(:occurrence_numbr) {|i| i} }
	block				{ (A..H).to_a.sample }
	day_number	{ (1..8).to_a.sample }
	period			{ (1..5).to_a.sample }
end

