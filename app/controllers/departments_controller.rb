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

	def department_params
		params.permit(:dept_id)
	end

  def find_department
    @dept = department_params[:dept_id] ? Department.find(department_params[:dept_id]) : Department.first
  end

end
