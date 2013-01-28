class SectionAssignmentsController < ApplicationController
  before_filter :authenticate_user!, except: [:find_sa]
	before_filter :find_sa, except: []

  def edit
		respond_to do |format|
			format.html { render layout: !request.xhr? }
    end
   end
  
   # PUT text_documents/1
   # PUT text_documents/1.json
   def update
     respond_to do |format|
       if @sa.update_attributes(params[:section_assignment])
         format.html { redirect_to :back, notice: 'Section assignment was saved.' }
       else
         format.json { render json: @sa.errors, status: :unprocessable_entity }
       end
     end
  end

  private
  def find_sa
    @sa = SectionAssignment.find params[:id]
  end

end
