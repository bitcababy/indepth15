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
    if @doc.update_from_params(params[:department_document])
      render json: @doc, status: :ok
    else
      render json: doc.errors, status: :unprocessable_entity
    end
  end
  
  private
  def find_doc
    dept = Department.find params[:dept_id]
    @doc = dept.homepage_docs.find params[:id]
  end

end
