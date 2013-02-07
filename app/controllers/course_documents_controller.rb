class CourseDocumentsController < ApplicationController
  before_filter :find_doc

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
        if @doc.update_from_params(params[:course_document])
          format.html { redirect_to :back, notice: 'Document was saved.' }
        else
          format.json { render json: doc.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        if @doc.update_from_params(params[:course_document])
          format.json { head :no_content }
          format.html { redirect_to session[:goto_url], notice: 'Document was successfully updated.' }
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
    @doc = course.docs.find params[:id]
  end
end
