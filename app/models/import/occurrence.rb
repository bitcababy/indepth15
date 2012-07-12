class Import::Occurrence < Import
	cattr_reader :mapping

	@@mapping = {
		'block_name' => :block_name,
		'occurrence' => :occurrence,
		'day_num' => :day_number,
		'period' => :period,
	}
	
end
