class Occurrence
  include Mongoid::Document

	field :n, as: :number, type: Integer
	field :bn, as: :block, type: String
	field :dn, as: :day, type: Integer
	field :pe, as: :period, type: Integer
	
	index( {number: 1, block: 1} )
	
	def self.import_from_hash(hash)
		occ = Occurrence.create! hash
		return occ
	end
	
	def to_s
		number.to_s
	end

end
