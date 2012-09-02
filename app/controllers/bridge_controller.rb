class BridgeController < ApplicationController
	before_filter :authenticate_user!, only: []

	def incoming
		hash = fix_hash params['wmdhs']
		if v = hash[:assignments] then
			Assignment.handle_incoming(v)
		end
		if v = hash[:courses] then
			Course.handle_incoming(fix_has())
		end
		if v = hash[:section_assignments] then
			SectionAssignment.handle_incoming(v)
		end
	end

	def fix_hash(hash)
		new_hash = Hash.new
		hash.each {|k,v| new_hash[k.to_sym] = v} 
		return new_hash
	end
end
