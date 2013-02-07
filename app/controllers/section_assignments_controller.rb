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
     if request.xhr?
       respond_to do |format|
         if @sa.update_attributes(params[:department_document])
           format.html { redirect_to :back, notice: 'Document was saved.' }
         else
           format.json { render json: doc.errors, status: :unprocessable_entity }
         end
       end
     else
       respond_to do |format|
         if @sa.update_attributes(params[:department_document])
           format.html { redirect_to session[:goto_url], notice: 'SectionAssignment was successfully updated.' }
           format.json { head :no_content }
         else
           format.html { render action: "edit", error: 'Invalid parameters' }
           format.json { render json: doc.errors, status: :unprocessable_entity }
         end
       end
     end
  end

  private
  def find_sa
    @sa = SectionAssignment.find params[:id]
  end

end
