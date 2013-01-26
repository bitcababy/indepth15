class DepartmentsController < ApplicationController
	before_filter :find_department, except: [:edit_doc, :save_doc]
  before_filter :authenticate_user!, only: [:edit_doc]

	def home
    @panes = @dept.homepage_docs.sort
		respond_to do |format|
			format.html { render }
			format.json { render json: @panes }
		end
	end

  def about
  end

  def edit_doc
    @doc = DepartmentDocument.find params[:doc_id]
    if true || @doc.can_lock?(current_user)
      @doc.lock(current_user)
  		respond_to do |format|
  			format.html { render layout: false }
        # format.html { render layout: !request.xhr? }
      end
    else
      ## Smell: Is this the right way to do it?
  		respond_to do |format|
        format.html { head :bad_request }
        # format.html { render template: 'shared/document_locked', layout: !request.xhr?}
      end
    end
  end
  
  # PUT text_documents/1
  # PUT text_documents/1.json
  def save_doc
    doc = DepartmentDocument.find params[:id]
    if request.xhr?
      respond_to do |format|
        if doc.update_attributes(params[:department_document])
          doc.unlock
          format.html { redirect_to :back, notice: 'Document was saved.' }
        else
          format.json { render json: doc.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        if doc.update_from_params(params[:department_document])
          format.json { head :no_content }
          format.html { redirect_to session[:goto_url], notice: 'TextDocument was successfully updated.' }
        else
          format.json { render json: doc.errors, status: :unprocessable_entity }
          format.html { render action: "edit_doc", error: 'Invalid parameters' }
        end
      end
    end
  end
  

  protected
  def find_department
    @dept = Department.first
  end

end
