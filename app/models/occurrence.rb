class Occurrence
  include Mongoid::Document
  include Mongoid::History::Trackable

	field :n, as: :number, type: Integer
	field :bn, as: :block, type: String
	field :dn, as: :day, type: Integer
	field :pe, as: :period, type: Integer
	
	index( {number: 1, block: 1} )
	
	validates :block, presence: true
	validates :number, presence: true, numericality: true
  
  track_history version_field: :version
	
	def self.import_from_hash(hash)
		return Occurrence.create! hash
	end
	
	def to_s
		"#{block}#{number}"
	end

end
