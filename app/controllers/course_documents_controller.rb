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
    if @doc.update_from_params(params[:course_document])
      render json: @doc, status: :ok
    else
      render json: doc.errors, status: :unprocessable_entity
    end
  end
  
  private
  def find_doc
    course = Course.find params[:course_id]
    @doc = course.documents.find params[:id]
  end
end
