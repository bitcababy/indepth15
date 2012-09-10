class BridgeController < ApplicationController

	def import
		importer = ImportJob.new
		importer.import_new_stuff
		head :success
	end

end
