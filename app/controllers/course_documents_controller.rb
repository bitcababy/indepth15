class CourseDocumentsController < ApplicationController
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
    # Should this do the redirecting?
    if request.xhr?
      if @doc.update_from_params(params[:course_document])
        format.json { render json: stored_page, notice: 'Document was saved.' }
      else
        format.json { render json: doc.errors, status: :unprocessable_entity }
      end
    else
      respond_to do |format|
        if @doc.update_from_params(params[:course_document])
          format.json { head :no_content }
          format.html { return_to_last_page notice: 'Document was successfully updated.' }
        else
          format.json { render json: doc.errors, status: :unprocessable_entity }
          format.html { render action: "edit", error: 'Invalid parameters' }
        end
      end
    end
  end
  
  private
  def find_doc
    course = Course.find params[:course_id]
    @doc = course.documents.find params[:id]
  end
end
