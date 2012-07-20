class Occurrence
  include Mongoid::Document

	field :no, as: :number, type: Integer
	field :bn, as: :block, type: String
	field :dn, as: :day_number, type: Integer
	field :pe, as: :period, type: Integer
	
	scope :for_block, lambda {|b| where(block_name: b)}
	
	def self.import_from_hash(hash)
		Occurrence.create! hash
	end
	
	def to_s
		"Occurrence: #{number}/#{block}/#{day_number}/#{period}"
	end
		
end
