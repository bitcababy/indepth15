class SectionsController < ApplicationController
	before_filter :find_section, only: []
	
 	private
	def find_section
		n = params[:id]
		@section = Section.find(n)
	end
end
