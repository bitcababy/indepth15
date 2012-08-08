class Occurrence
  include Mongoid::Document

	field :n, as: :number, type: Integer
	field :bn, as: :block, type: String
	field :dn, as: :day, type: Integer
	field :pe, as: :period, type: Integer
	
	index( {number: 1, block: 1} )
	
	validates :block, presence: true
	validates :number, presence: true, numericality: true
	
	def self.import_from_hash(hash)
		return Occurrence.create! hash
	end
	
	def to_s
		"#{block}#{number}"
	end

end
