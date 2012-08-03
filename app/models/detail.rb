class Detail
  include Mongoid::Document
	
	embedded_in :owner, polymorphic: true

	def add(hash={})
		hash.each_pair {|k,v| self[k] = v}
	end

end
