class DepartmentsController < ApplicationController
	before_filter :find_department, except: [:edit_doc]
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
    @doc = TextDocument.find params[:doc_id]
    if true || @doc.can_lock?(current_user)
      @doc.lock(current_user)
  		respond_to do |format|
  			format.html { render layout: false }
      end
    else
      ## Smell: Is this the right way to do it?
  		respond_to do |format|
        format.html { head :bad_request }
        # format.html { render template: 'shared/document_locked', layout: false}
      end
    end
  end

  protected
  def find_department
    @dept = Department.first
  end

end