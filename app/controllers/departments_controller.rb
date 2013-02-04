class DepartmentsController < ApplicationController
	before_filter :find_department

	def home
    @panes = @dept.homepage_docs.sort
		respond_to do |format|
			format.html { render }
			format.json { render json: @panes }
		end
	end

  def about
  end

  def get_pane
    which = params[:pos].to_i
    doc = @dept.homepage_docs.find_by(pos: which)
		respond_to do |format|
      format.json {render json: {title: doc.title, content: doc.content}}
    end
  end
    
  protected
  def find_department
    @dept = Department.first
  end

end
