class BridgeController < ApplicationController

	def import
		res = <<EOT
<?xml version="1.0" encoding="utf-8"?>

<sent>
EOT
		
		res += Bridge.create_or_update_assignments
		res += Bridge.create_or_update_sas
		res += "</sent>"
		head :success
	end

end
