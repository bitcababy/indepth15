class Occurrence
  include Mongoid::Document

	field :no, as: :number, type: Integer
	field :bn, as: :block, type: String
	field :dn, as: :day, type: Integer
	field :pe, as: :period, type: Integer
	
	scope :for_block, lambda {|b| where(block_name: b)}
	
	index {number: 1, block: 1}
	
	def self.import_from_hash(hash)
		return Occurrence.create! hash
	end
	
	def to_s
		return "Occurrence: #{number}/#{block}/#{day}/#{period}"
	end
		
end
