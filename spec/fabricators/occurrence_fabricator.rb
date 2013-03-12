Fabricator(:occurrence) do
	number			{ sequence(:occurrence) {|i| i} }
	block				{ sequence(:block) }
	day					{ (1..8).to_a.sample }
	period			{ (1..5).to_a.sample }
end

