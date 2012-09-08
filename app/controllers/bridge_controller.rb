class BridgeController < ApplicationController

	def import
		Bridge.create_or_update_assignments
		Bridge.create_or_update_sas
		head :success
	end

end
