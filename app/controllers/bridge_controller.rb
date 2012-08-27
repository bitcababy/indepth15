class BridgeController < ApplicationController
	def incoming
		hash = params['wmdhs']
		if v = hash["assignments"] then
			Assignment.handle_incoming(v)
		end
		if v = hash["section_assignments"] then
			logger.warn(v)
			SectionAssignment.handle_incoming(v)
		end
	end
end
