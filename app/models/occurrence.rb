class Occurrence
  include Mongoid::Document

	field :block_name, type: String
	field :occurrence, type: Integer
	field :day_number, type: Integer
	field :period, type: Integer

	def self.import_from_hash(hash)
		Occurrence.create! hash
	end
		
end
