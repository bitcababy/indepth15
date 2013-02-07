class DepartmentDocumentsController < ApplicationController
  before_filter :find_doc
	before_filter :authenticate_user!

  def edit
		respond_to do |format|
			format.html { render layout: !request.xhr?  }
    end
  end
  
  # PUT text_documents/1
  # PUT text_documents/1.json
  def update
    if request.xhr?
      respond_to do |format|
        if @doc.update_from_params(params[:department_document])
          format.html { redirect_to :back, notice: 'Document was saved.' }
        else
          format.json { render json: doc.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        if @doc.update_from_params(params[:department_document])
          format.json { head :no_content }
          format.html { redirect_to :back, notice: 'Document was successfully updated.' }
        else
          format.json { render json: doc.errors, status: :unprocessable_entity }
          format.html { render action: "edit", error: 'Invalid parameters' }
        end
      end
    end
  end
  
  private
  def find_doc
    dept = Department.find params[:dept_id]
    @doc = dept.homepage_docs.find params[:id]
  end
end