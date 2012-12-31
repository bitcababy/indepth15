class DepartmentController < ApplicationController
	before_filter :find_department, except: [:edit_doc]
	
	def home
    @editable = true # Temporary
    @panes = @dept.homepage_docs.sort
		respond_to do |format|
			format.html { render }
			format.json { render json: @panes }
		end
		return
	end

  def about
  end

  def edit_doc
    @doc = TextDocument.find params[:doc_id]
		respond_to do |format|
			format.html { render layout: !request.xhr? }
    end
  end

  protected
  def find_department
    @dept = Department.first
  end

end
