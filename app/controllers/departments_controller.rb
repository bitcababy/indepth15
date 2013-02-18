class DepartmentsController < ApplicationController
	before_filter :find_department

	def home
    remember_current_page
    @panes = @dept.homepage_docs.sort
    render
	end

  def about
  end

  def get_pane
    which = params[:pos].to_i
    doc = @dept.homepage_docs.find_by(pos: which)
		respond_to do |format|
      format.json {render json: { title: doc.title, content: doc.content } }
    end
  end
    
  protected
  def find_department
    @dept = Department.first
  end

end
